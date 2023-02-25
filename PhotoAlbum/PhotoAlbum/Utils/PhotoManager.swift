//
//  PhotoManager.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/25.
//

import Foundation
import UIKit
import Photos

func requestCollection() -> [albumInfo] {
    var albums: [albumInfo] = []
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    
    let listfet = PHFetchOptions()
    listfet.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: false)]
    
    let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum , subtype: .smartAlbumUserLibrary , options: nil)
    
    guard let cameraRoll = cameraRoll.firstObject else { return [] }
    
    let asset = PHAsset.fetchAssets(in: cameraRoll, options: fetchOptions)
    
    albums.append(
        albumInfo(asset: asset,
                  name: "Camera Roll",
                  count: asset.count))
    
    let albumList: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album , subtype: .any , options: listfet)
    let albumCount = albumList.count
    let album: [PHAssetCollection] = albumList.objects(at: IndexSet(0..<albumCount))
    
    for i in 0..<albumCount {
        let assetItem = PHAsset.fetchAssets(in: album[i], options: fetchOptions)
        albums.append(
            albumInfo(
                asset: assetItem,
                name: "\(album[i].localizedTitle!)",
                count: assetItem.count))
    }
    return albums
}

func isEmptyAlbum(count: Int) throws -> Bool {
    if count == 0 {
        throw ErrorCase.noPhoto
    } else {
        return true
    }
}

func requestImage(_ img: PHAsset, _ cell: AlbumListTableCell) {
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    imageManager.requestImage(for: img, targetSize: CGSize(width: 70, height: 70), contentMode: .aspectFill, options: nil) { img, _ in
        cell.recentImage.image = img
    }
}
