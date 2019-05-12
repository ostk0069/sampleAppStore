//
//  ItemSection.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/07.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

class ItemSection {
    static let shared = ItemSection()
    
    let items = [
        TodayItem.init(
            category: "THE DAILY LIST",
            title: "Test-Drive These CarPlay Apps",
            image: #imageLiteral(resourceName: "garden"),
            description: "",
            backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            cellType: .multiple
        ),
        TodayItem.init(
            category: "LIFE HACK",
            title: "Utilizing your time",
            image: #imageLiteral(resourceName: "holiday"),
            description: "All the tools and apps you need to intelligently organize your life the right way.",
            backgroundColor: #colorLiteral(red: 0.9892268777, green: 0.9734713435, blue: 0.763643086, alpha: 1),
            cellType: .single
        ),
        TodayItem.init(
            category: "LIFE HACK",
            title: "Utilizing your time",
            image: #imageLiteral(resourceName: "holiday"),
            description: "All the tools and apps you need to intelligently organize your life the right way.",
            backgroundColor: #colorLiteral(red: 0.9892268777, green: 0.9734713435, blue: 0.763643086, alpha: 1),
            cellType: .single
        ),
    ]
}
