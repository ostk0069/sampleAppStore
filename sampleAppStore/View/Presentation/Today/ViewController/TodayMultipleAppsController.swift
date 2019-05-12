//
//  TodayMultipleAppsController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/12.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController {
    
    var results = [FeedResult]()
    private let spacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(type: MultipleAppCell.self)
        collectionView.isScrollEnabled = false
        
//        Service.shared.fetchGames { (appGroup, error) in
//            self.results = appGroup?.feed.results ?? []
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
    }
}

extension TodayMultipleAppsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, results.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = results[indexPath.item]
        let cell = MultipleAppCell.dequeue(from: collectionView, for: indexPath, with: item)
        return cell
    }
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (view.frame.height - 3 * spacing) / 4
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
