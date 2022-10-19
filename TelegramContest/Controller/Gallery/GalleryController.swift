//
//  GalleryController.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit
import Photos

final class GalleryController: UIViewController {
    // MARK: - Gallery View
    private let galleryView = GalleryView()
    
    // MARK: - UI Elements
    private var galleryCollectionView: UICollectionView {
        galleryView.galleryCollectionView
    }
    
    // MARK: - Variables
    private var images = [PHAsset]()
        
    // MARK: - Life Cycle Methods
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
    
    // MARK: - Populate Photos Method
    private func populatePhotos() {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { [weak self] status in
                if status == .authorized {
                    let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                    
                    assets.enumerateObjects { (object, _, _) in
                        self?.images.append(object)
                    }
                    
                    self?.images.reverse()
                    
                    DispatchQueue.main.async {
                        self?.galleryCollectionView.reloadData()
                    }
                }
            }
        } else {
            // TODO: - For iOS < 14
        }
    }


}

// MARK: - UICollectionViewDelegate
extension GalleryController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        var thumbnail = UIImage()
        let editorController = EditorController()
        let screenWidth = UIScreen.main.bounds.width
        
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        
        manager.requestImage(for: image, targetSize: CGSize(width: screenWidth, height: 520), contentMode: .aspectFill, options: options) {(result, info) in
            if let result = result {
                thumbnail = result
            }
        }
        
        editorController.galleryImage = thumbnail
        
        let navController = UINavigationController(rootViewController: editorController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

// MARK: - UI CollectionViewDataSource
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
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 129.0, height: 129.0), contentMode: .aspectFit, options: options) {(image, _) in
            DispatchQueue.main.async {
                cell.galleryImageView.image = image
            }
        }
        
        return cell
    }
}
