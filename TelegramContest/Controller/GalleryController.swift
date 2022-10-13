//
//  GalleryController.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit
import Photos

final class GalleryController: UIViewController {
    private let galleryView = GalleryView()
    
    private var galleryCollectionView: UICollectionView {
        galleryView.galleryCollectionView
    }
    
    private var images = [PHAsset]()
        
    override func loadView() {
        view = galleryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        galleryCollectionView.register(GalleryCollectionCell.self, forCellWithReuseIdentifier: "galleryCollectionCell")
        
        populatePhotos()
    }
    
    private func populatePhotos() {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { [weak self] status in
                if status == .authorized {
                    let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                    
                    assets.enumerateObjects { (object,_, _) in
                        self?.images.append(object)
                    }
                    
                    self?.images.reverse()
                    
                    DispatchQueue.main.async {
                        self?.galleryCollectionView.reloadData()
                    }
                }
            }
        } else {
            // TODO: -
        }
    }


}

extension GalleryController: UICollectionViewDelegate {

}

extension GalleryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCollectionCell", for: indexPath) as? GalleryCollectionCell else {
            return UICollectionViewCell()
        }
        
        let asset = images[indexPath.row]
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.resizeMode = .none
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 129.0, height: 129.0), contentMode: .aspectFit, options: options) {(image, _) in
            DispatchQueue.main.async {
                cell.galleryImageView.image = image
            }
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
}
