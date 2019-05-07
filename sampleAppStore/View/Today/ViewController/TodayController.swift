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
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: "TodayCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
                
                guard let cell = self.appFullscreenController?.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else {
                    return
                    
                }
                cell.todayCell.topConstraint?.constant = 24
                cell.layoutIfNeeded()
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
        cell.todayItem = items[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.row]
        appFullscreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        let fullscreenView = appFullscreenController.view!
        view.addSubview(fullscreenView)
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
        fullscreenView.frame = startingFrame
        
        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        fullscreenView.layer.cornerRadius = 16
        
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
                        cell.todayCell.topConstraint?.constant = 48
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
