//
//  ReviewsController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/06.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingController {
    
    var reviews: Reviews? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(type: ReviewCell.self)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension ReviewsController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = reviews?.feed.entry.count else {
            return 0
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ReviewCell.dequeue(from: collectionView, for: indexPath)
        let entry = reviews?.feed.entry[indexPath.item]
        cell.titleLabel.text = entry?.title.label
        cell.autherLabel.text = entry?.author.name.label
        cell.bodyLabel.text = entry?.content.label
        
        for (index, view) in cell.starStackView.arrangedSubviews.enumerated() {
            guard let entry = entry else {
                return ReviewCell()
            }
            if let ratingInt = Int(entry.rating.label) {
                view.alpha = index > ratingInt ? 0 : 1
            }
        }
        return cell
    }
}

extension ReviewsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
}
