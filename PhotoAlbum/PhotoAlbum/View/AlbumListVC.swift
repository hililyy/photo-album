//
//  AlbumListVC.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/22.
//

import UIKit
import Photos

class AlbumListVC: UIViewController, RequestAuth {    
    @IBOutlet weak var albumTableView: UITableView!
    let model = AlbumViewModel.viewModel
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "앨범"
        requestPhotoAuth()
    }
    
    func requestPhotoAuth() {
        do {
            try photoAuth {
                self.model.albumsInfo = requestCollection()
                DispatchQueue.main.async {
                    self.albumTableView.reloadData()
                }
            }
        } catch {
            simpleAlert("접근 권한 없음", "설정에서 사진 접근 권한을 허용해주세요.", self)
        }
    }
}

extension AlbumListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.albumsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.albumTableView.dequeueReusableCell(withIdentifier: "AlbumListTableCell", for: indexPath) as? AlbumListTableCell else { return UITableViewCell() }
        
        let title: String = model.albumsInfo[indexPath.item].name
        let count: Int = model.albumsInfo[indexPath.item].count
        
        cell.albumTitle.text = title
        cell.imageNum.text = "\(count)"
        cell.selectionStyle = .none
        
        do {
            if try isEmptyAlbum(count: count) {
                let img: PHAsset = model.albumsInfo[indexPath.item].asset.object(at: 0)
                requestImage(img, cell)
            }
        } catch {
            cell.recentImage.image = UIImage(named: "img_emptyAlbum")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showPhotoCollectVC(
            asset: model.albumsInfo[indexPath.item].asset,
            albumName: model.albumsInfo[indexPath.item].name,
            index: indexPath.item
        )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
