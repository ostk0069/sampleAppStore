//
//  AppDetailController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController {
    
    var app: Result?
    var reviews: Reviews?
    var height: CGFloat = 280
    
    var appId: String! {
        didSet {
            Service.shared.fetchSearchResult(id: appId) { (result: SearchResult?, error) in
                self.app = result?.results.first
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            Service.shared.fetchReviews(id: appId) { (reviews: Reviews?, error) in
                self.reviews = reviews
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: "AppDetailCell")
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: "PreviewCell")
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: "ReviewRowCell")
    }
}

extension AppDetailController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailCell", for: indexPath) as! AppDetailCell
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewCell", for: indexPath) as! PreviewCell
            cell.horizontalController.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewRowCell", for: indexPath) as! ReviewRowCell
            cell.reviewsController.reviews = self.reviews
            return cell
        }
    }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            height = estimatedSize.height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 260
        }
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
}
