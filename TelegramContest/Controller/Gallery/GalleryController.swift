//
//  GalleryController.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit
import Photos

final class GalleryController: UIViewController {
    static var collectionViewDidResized: ((_ count: CGFloat) -> ())?
    
    // MARK: - Gallery View
    private let galleryView = GalleryView()
    
    // MARK: - UI Elements
    private var galleryCollectionView: UICollectionView {
        galleryView.galleryCollectionView
    }
    
    // MARK: - Variables
    private var assets = PHFetchResult<PHAsset>()
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    private var numberOfItems: CGFloat = 2
    private var numberOfSwipes = 0
        
    // MARK: - View Life Cycle Methods
    override func loadView() {
        view = galleryView
    }

    override func viewDidLoad() {
        getPermission {granted in
            guard granted else { return }
            self.fetchAssets()
            DispatchQueue.main.async {
                self.galleryCollectionView.reloadData()
            }
        }
        PHPhotoLibrary.shared().register(self)
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(GalleryCollectionCell.self, forCellWithReuseIdentifier: "galleryCollectionCell")
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(resizeGalleryCollection(_:)))
        galleryCollectionView.addGestureRecognizer(pinchGesture)
    }
    
    // MARK: - @objc
    @objc func resizeGalleryCollection(_ gestureRecognizer: UIPinchGestureRecognizer) {
        
    }
    
    // MARK: - Photos Methods
    private func getPermission(completionHandler: @escaping (Bool) -> Void) {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        
        PHPhotoLibrary.requestAuthorization {status in
            completionHandler(status == .authorized ? true : false)
        }
    }
    
    private func fetchAssets() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false
            )
        ]
        
        assets = PHAsset.fetchAssets(with: allPhotosOptions)
    }
}

// MARK: - UICollectionViewDelegate
extension GalleryController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = assets[indexPath.item]
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
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let width = screenWidth - itemSpacing * CGFloat(numberOfItems - 1)
        let itemSize = CGSize(width: floor(width / numberOfItems), height: width / numberOfItems)
        
        return itemSize
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCollectionCell", for: indexPath) as? GalleryCollectionCell else {
            return UICollectionViewCell()
        }
        
        let asset = assets[indexPath.item]
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        options.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: screenWidth * 2, height: screenWidth * 2), contentMode: .aspectFill, options: options) {(image, _) in
            DispatchQueue.main.async {
                cell.galleryImageView.image = image
            }
        }
        
        return cell
    }
}

extension GalleryController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let change = changeInstance.changeDetails(for: assets) else { return }
        DispatchQueue.main.async {
            self.assets = change.fetchResultAfterChanges
            self.galleryCollectionView.reloadData()
        }
    }
}
