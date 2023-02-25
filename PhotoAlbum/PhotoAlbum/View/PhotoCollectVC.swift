//
//  PhotoCollectVC.swift
//  PhotoAlbum
//
//  Created by 강조은 on 2023/02/22.
//

import UIKit
import Photos

class PhotoCollectVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let model = PhotoViewModel.model
    let half: Double = Double(UIScreen.main.bounds.width / 3 - 6)

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout() {
        let flowlayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 4
        flowlayout.itemSize = CGSize(width: half, height: half)
        flowlayout.sectionInset = UIEdgeInsets.zero
        flowlayout.minimumLineSpacing = spacing
        flowlayout.minimumInteritemSpacing = spacing
        self.collectionView.collectionViewLayout = flowlayout
        self.navigationItem.title = model.albumName
    }
}

extension PhotoCollectVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoListCollectionCell", for: indexPath) as? PhotoListCollectionCell else { return UICollectionViewCell.init() }
        let picture: PHAsset = model.pictures.object(at: indexPath.item)
        
        model.imageManager.requestImage(
            for: picture,
            targetSize: CGSize(width: half, height: half),
            contentMode: .aspectFill,
            options: nil,
            resultHandler: {img, _ in
            cell.imageView?.image = img
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var photoInfo = photoInfo()
        photoInfo = model.getFileNameAndSize(index: indexPath.row)
        photoInfoAlert(photoInfo, self)
    }
}
