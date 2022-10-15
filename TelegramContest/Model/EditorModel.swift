//
//  EditorModel.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import Foundation

protocol BrushesProtocol {
    var brush: String { get set }
}

struct BrushesModel: BrushesProtocol {
    var brush: String
    static let cellID = "brushCollectionCell"
    
    static func getBrushes() -> [BrushesModel] {
        return [
            BrushesModel(brush: "pencil"),
            BrushesModel(brush: ""),
            BrushesModel(brush: ""),
            BrushesModel(brush: ""),
            BrushesModel(brush: ""),
        ]
    }
}
