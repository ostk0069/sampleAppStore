//
//  AppFullscreenHeaderCell.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/07.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class AppFullscreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todayCell)
        todayCell.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
