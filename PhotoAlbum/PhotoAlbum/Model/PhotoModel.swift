//
//  PhotoModel.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/25.
//

import Foundation
import Photos

struct albumInfo {
    let asset: PHFetchResult<PHAsset>
    let name: String
    let count: Int
}

struct photoInfo {
    var name: String
    var size: String
    
    init() {
        self.name = ""
        self.size = ""
    }
}
