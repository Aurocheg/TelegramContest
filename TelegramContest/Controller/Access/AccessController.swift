//
//  AccessController.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit

final class AccessController: UIViewController {
    private let accessView = AccessView()

    override func loadView() {
        view = accessView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
