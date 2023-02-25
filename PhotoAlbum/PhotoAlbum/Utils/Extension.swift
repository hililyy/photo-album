//
//  Extension.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/25.
//

import UIKit
import Photos

extension UIViewController {
    func showPhotoCollectVC(asset: PHFetchResult<PHAsset>, albumName: String, index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "PhotoCollectVC") as? PhotoCollectVC else { return }
        vc.model.pictures = asset
        vc.model.albumName = albumName
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
