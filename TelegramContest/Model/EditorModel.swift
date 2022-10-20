//
//  EditorModel.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import Foundation
import UIKit

protocol BrushesProtocol {
    var brush: String { get set }
}

struct BrushesModel: BrushesProtocol {
    var brush: String
    static let cellID = "brushCollectionCell"
    
    static func getBrushes() -> [BrushesModel] {
        return [
            BrushesModel(brush: "pen"),
            BrushesModel(brush: "brush"),
            BrushesModel(brush: "brush2"),
            BrushesModel(brush: "pencil"),
            BrushesModel(brush: "lasso"),
            BrushesModel(brush: "eraser")
        ]
    }
}
