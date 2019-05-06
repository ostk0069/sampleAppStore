//
//  TodayController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/06.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    
    let items = ItemSection.shared.items
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: "TodayCell")
    }
    
    var startingFrame: CGRect?
    var appFullscreenController: AppFullscreenController?
    
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    @objc func handleRemoveRedView() {
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.7,
            options: .curveEaseOut,
            animations: {
                
                self.appFullscreenController?.tableView.contentOffset = .zero
                
                guard let startingFrame = self.startingFrame else {
                    return
                }
                
                self.topConstraint?.constant = startingFrame.origin.y
                self.leadingConstraint?.constant = startingFrame.origin.x
                self.widthConstraint?.constant = startingFrame.width
                self.heightConstraint?.constant = startingFrame.height
                self.view.layoutIfNeeded()
                
                self.tabBarController?.tabBar.transform = .identity
        }, completion: { _ in
            self.appFullscreenController?.view.removeFromSuperview()
            self.appFullscreenController?.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}

extension TodayController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCell", for: indexPath) as! TodayCell
        cell.todayItem = items[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.row]
        appFullscreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        
        view.addSubview(appFullscreenController.view)
        addChild(appFullscreenController)
        
        self.appFullscreenController = appFullscreenController
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {
            return
        }
        self.startingFrame = startingFrame
        appFullscreenController.view.frame = startingFrame
        
        appFullscreenController.view.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = appFullscreenController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = appFullscreenController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = appFullscreenController.view.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = appFullscreenController.view.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        appFullscreenController.view.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut,
                       animations: {
                        self.topConstraint?.constant = 0
                        self.leadingConstraint?.constant = 0
                        self.widthConstraint?.constant = self.view.frame.width
                        self.heightConstraint?.constant = self.view.frame.height
                        self.view.layoutIfNeeded()
                        self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
                        
                        guard let cell = self.appFullscreenController?.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else {
                            return
                        }
                        cell.todayCell.topConstraint?.constant = 24
                        cell.layoutIfNeeded()
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
