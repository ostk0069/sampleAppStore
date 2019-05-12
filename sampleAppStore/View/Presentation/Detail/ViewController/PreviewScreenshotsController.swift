//
//  PreviewScreenshotsController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappingController {
    
    var app: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(type: ScreenshotCell.self)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension PreviewScreenshotsController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = app?.screenshotUrls.count else {
            return 0
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ScreenshotCell.dequeue(from: collectionView, for: indexPath)
        guard let screenShotURL = self.app?.screenshotUrls[indexPath.item] else {
            return ScreenshotCell()
        }
        cell.imageView.sd_setImage(with: URL(string: screenShotURL))
        return cell
    }
}

extension PreviewScreenshotsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
