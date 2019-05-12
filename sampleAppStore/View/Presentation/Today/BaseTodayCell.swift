//
//  BaseTodayCell.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/12.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 16
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: 10)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.transform = .init(scaleX: 0.9, y: 0.9)
                })
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.transform = .identity
                })
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
