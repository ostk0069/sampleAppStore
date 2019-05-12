//
//  AppsHorizontalController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
    
    private let topBottomPadding: CGFloat = 16
    private let lineSpacing: CGFloat = 10
    
    var appGroup: AppGroup?
    var didSelectHandler: ((FeedResult) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(type: AppRowCell.self)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension AppsHorizontalController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = appGroup?.feed.results.count else {
            return 0
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AppRowCell.dequeue(from: collectionView, for: indexPath)
        let app = appGroup?.feed.results[indexPath.item]
        cell.nameLabel.text = app?.name
        cell.companyLabel.text = app?.artistName
        guard let urlString: String = app?.artworkUrl100 else {
            return AppRowCell()
        }
        cell.imageView.sd_setImage(with: URL(string: urlString))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let app = appGroup?.feed.results[indexPath.item] else {
            return
        }
        didSelectHandler?(app)
    }
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - (topBottomPadding * 2 + lineSpacing * 2)) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
        
    }
}


