//
//  AlbumListVC.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/22.
//

import UIKit
import Photos

class AlbumListVC: UIViewController {
    
    @IBOutlet weak var albumTableView: UITableView!
    let model = AlbumViewModel.viewModel
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "앨범"
        photoAuth {
            self.model.albumsInfo = requestCollection()
            DispatchQueue.main.async {
                self.albumTableView.reloadData()
            }
        }
    }
}

extension AlbumListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.albumsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.albumTableView.dequeueReusableCell(withIdentifier: "AlbumListTableCell", for: indexPath) as? AlbumListTableCell else { return UITableViewCell() }
        let img: PHAsset = model.albumsInfo[indexPath.item].asset.object(at: 0)
        
        cell.albumTitle.text = model.albumsInfo[indexPath.item].name
        cell.imageNum.text = "\(model.albumsInfo[indexPath.item].count)"
        cell.selectionStyle = .none
        imageManager.requestImage(for: img, targetSize: CGSize(width: 70, height: 70), contentMode: .aspectFill, options: nil) { img, _ in
            cell.recentImage.image = img
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
