//
//  EditorModel.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import Foundation
import UIKit

protocol BrushesProtocol {
    var brush: UIImage? { get set }
}

struct BrushesModel: BrushesProtocol {
    var brush: UIImage?
    static let cellID = "brushCollectionCell"
    
    func getBrushes() -> [BrushesModel] {
        let penImages = [UIImage(named: "pen")!, UIImage(named: "tipPen")!]
        let brushImages = [UIImage(named: "brush")!, UIImage(named: "tipBrush")!]
        let neonImages = [UIImage(named: "neon")!, UIImage(named: "tipNeon")!]
        let pencilImages = [UIImage(named: "pencil")!, UIImage(named: "tipPencil")!]
        
        let pen = compositeImages(penImages)
        let brush = compositeImages(brushImages)
        let neon = compositeImages(neonImages)
        let pencil = compositeImages(pencilImages)
        let lasso = UIImage(named: "lasso")!
        let eraser = UIImage(named: "eraser")!
        
        return [
            BrushesModel(brush: pen),
            BrushesModel(brush: brush),
            BrushesModel(brush: neon),
            BrushesModel(brush: pencil),
            BrushesModel(brush: lasso),
            BrushesModel(brush: eraser)
        ]
    }
    
    private func compositeImages(_ images: [UIImage]) -> UIImage {
        var compositeImage: UIImage!
        if images.count > 0 {
            let size: CGSize = CGSize(width: images[0].size.width, height: images[0].size.height)
            UIGraphicsBeginImageContext(size)
            for image in images {
                let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                image.draw(in: rect)
            }
            compositeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return compositeImage
    }
}
