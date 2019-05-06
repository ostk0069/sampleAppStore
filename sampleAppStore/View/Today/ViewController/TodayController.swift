//
//  TodayController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/06.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: "TodayCell")
    }
    
    var startingFrame: CGRect?
    var appFullscreenController: AppFullscreenController?
    
    @objc func handleRemoveRedView(gesture: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.7,
            options: .curveEaseOut,
            animations: {
                gesture.view?.frame = self.startingFrame ?? .zero
                self.tabBarController?.tabBar.transform = .identity
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
            self.appFullscreenController?.removeFromParent()
        })
    }
}

extension TodayController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCell", for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.view.layer.cornerRadius = 16
        appFullscreenController.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        view.addSubview(appFullscreenController.view)
        addChild(appFullscreenController)
        self.appFullscreenController = appFullscreenController
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {
            return
        }
        self.startingFrame = startingFrame
        appFullscreenController.view.frame = startingFrame
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            appFullscreenController.view.frame = self.view.frame
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
