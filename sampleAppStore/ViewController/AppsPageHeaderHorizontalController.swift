//
//  AppsPageHeaderHorizontalController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class AppsPageHeaderHorizontalController: BaseListController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        collectionView.register(AppsPageHeaderCell.self, forCellWithReuseIdentifier: "AppsPageHeaderCell")
        
        if let layout  = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

extension AppsPageHeaderHorizontalController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppsPageHeaderCell", for: indexPath) as! AppsPageHeaderCell
        return cell
    }
}

extension AppsPageHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 0)
    }
}
