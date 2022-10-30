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
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    private let numberOfItems = 3
        
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
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
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
        
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .none
        
        manager.requestImage(for: image, targetSize: CGSize(width: screenWidth + 1.0, height: screenHeight + 1.0), contentMode: .aspectFit, options: options) {(result, info) in
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

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemSpacing: CGFloat = 1.0
        let itemsInOneLine: CGFloat = 3
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let width = screenWidth - itemSpacing * CGFloat(itemsInOneLine - 1)
        flow.itemSize = CGSize(width: floor(width / itemsInOneLine), height: width / itemsInOneLine)
        return flow.itemSize
    }
}

// MARK: - UICollectionViewDataSource
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
        
        manager.requestImage(for: asset, targetSize: CGSize(width: screenWidth * 2, height: screenWidth * 2), contentMode: .aspectFill, options: options) {(image, _) in
            DispatchQueue.main.async {
                cell.galleryImageView.image = image
            }
        }
        
        return cell
    }
}
