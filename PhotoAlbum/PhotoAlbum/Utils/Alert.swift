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


// 권한 거부시
// 사진은 없고 앨범만 있을때
// 현재 보고있는 사진이 삭제됐을때
// 이미지 크기가 너무 클때 로딩
