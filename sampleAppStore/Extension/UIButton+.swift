//
//  UIButton+.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
