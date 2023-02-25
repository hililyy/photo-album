//
//  PhotoAuth.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/25.
//

import Foundation
import Photos

func photoAuth(completion: @escaping () -> ()) throws {
    let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    
    switch photoAuthorizationStatus {
    case .authorized:	
        print("접근을 허용하였습니다.")
        completion()
    case .denied:
        print("접근을 거부하였습니다.")
    case .notDetermined:
        print("아직 응답하지 않았습니다.")
        PHPhotoLibrary.requestAuthorization({ (status) in
            switch status {
            case .authorized:
                print("접근을 허용하였습니다.")
                completion()
            case .denied:
                print("접근을 거부하였습니다.")
            default: break
            }
        })
    case .restricted:
        print("접근이 제한되었습니다.")
    default:
        break
    }
    
    if photoAuthorizationStatus == .denied {
        throw ErrorCase.noPhoto
    }
}
