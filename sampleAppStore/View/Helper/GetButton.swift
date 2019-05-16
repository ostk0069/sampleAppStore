//
//  GetButton.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/16.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class GetButton: UIButton {
    
    init(title: String = "GET", cornerRadius: CGFloat = 16, font: UIFont = .boldSystemFont(ofSize: 16), width: CGFloat = 80, height: CGFloat = 32, backgroundColor: UIColor = #colorLiteral(red: 0.9390758872, green: 0.9392114282, blue: 0.970784843, alpha: 1)) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(#colorLiteral(red: 0, green: 0.3788880408, blue: 0.9968038201, alpha: 1), for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = font
        self.constrainWidth(constant: width)
        self.constrainHeight(constant: height)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
