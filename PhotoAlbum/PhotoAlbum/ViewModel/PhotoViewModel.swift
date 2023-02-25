//
//  PhotoViewModel.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/25.
//

import Foundation
import Photos

class PhotoViewModel {
    static let model = PhotoViewModel()
    var pictures: PHFetchResult<PHAsset>!
    var albumName: String!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    func getFileNameAndSize(index: Int) -> photoInfo {
        var data = photoInfo()
        
        let asset = self.pictures.object(at: index)
        var byte: String = ""
        let resources = PHAssetResource.assetResources(for: asset)
        let filename = resources.first!.originalFilename
        
        var sizeOnDisk: Int64 = 0
        if let resource = resources.first {
            let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong
            sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64!))
            byte = String(format: "%.2f", Double(sizeOnDisk) / (1024.0 * 1024.0)) + " MB"
        }
        data.name = filename
        data.size = byte
        
        return data
    }
}
