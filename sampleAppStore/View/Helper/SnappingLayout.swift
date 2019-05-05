//
//  SnappingLayout.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class SnappingLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        let itemWidth = collectionView.frame.width - 48
        var pageNumber = round(collectionView.contentOffset.x / itemWidth)
        
        // https://stackoverflow.com/questions/33855945/uicollectionview-snap-onto-cell-when-scrolling-horizontally
        let vX = velocity.x
        if vX > 0 {
            pageNumber += 1
        } else if vX < 0 {
            pageNumber -= 1
        }
        return CGPoint(x: pageNumber * itemWidth, y: 0)
    }
}
