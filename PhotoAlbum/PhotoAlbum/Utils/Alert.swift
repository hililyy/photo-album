//
//  Alert.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/25.
//

import UIKit

func photoInfoAlert(_ photoInfo: photoInfo, _ controller: UIViewController) {
    let alert = UIAlertController(
        title: "사진정보",
        message: "파일명: \(photoInfo.name)\n파일크기: \(photoInfo.size)",
        preferredStyle: UIAlertController.Style.alert
    )
    
    let okAction = UIAlertAction(title: "확인", style: .default)

    alert.addAction(okAction)
    controller.present(alert, animated: true, completion: nil)
}

func simpleAlert(_ title: String, _ message: String, _ controller: UIViewController) {
    let alert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: UIAlertController.Style.alert
    )
    
    let okAction = UIAlertAction(title: "확인", style: .default)

    alert.addAction(okAction)
    controller.present(alert, animated: true, completion: nil)
}
