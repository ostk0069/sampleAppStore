//
//  TodayController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/06.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    
    var items = [TodayItem]()
    var startingFrame: CGRect?
    var appFullscreenController: AppFullscreenController!
    var anchoredConstraint: AnchoredConstraints?
    static let cellSize: CGFloat = 500
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.color = .darkGray
        view.startAnimating()
        view.hidesWhenStopped = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(type: TodayCell.self)
        collectionView.register(type: TodayMultipleAppCell.self)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
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
                self.anchoredConstraint?.top?.constant = startingFrame.origin.y
                self.anchoredConstraint?.leading?.constant = startingFrame.origin.x
                self.anchoredConstraint?.width?.constant = startingFrame.width
                self.anchoredConstraint?.height?.constant = startingFrame.height
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
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        var topGrossingGroup: AppGroup?
        var topGamesGroup: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            topGrossingGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            topGamesGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            ItemSection.shared.items[0].apps = topGrossingGroup?.feed.results ?? []
            ItemSection.shared.items[2].apps = topGamesGroup?.feed.results ?? []
            self.items = ItemSection.shared.items
            self.collectionView.reloadData()
        }
    }
    
    @objc private func handleMultipleAppsTap(gesture: UITapGestureRecognizer) {
        let collectionView = gesture.view
        
        var superview = collectionView?.superview
        while superview != nil {
            if let cell = superview as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else {
                    return
                }
                let fullController = TodayMultipleAppsController(mode: .fullscreen)
                fullController.apps = self.items[indexPath.item].apps
                present(BackEnableNavigationController(rootViewController: fullController), animated: true)
                return
            }
            superview = superview?.superview
        }
    }
    
    private func showAppListCard(for indexPath: IndexPath) {
        let fullController = TodayMultipleAppsController(mode: .fullscreen)
        fullController.apps = self.items[indexPath.item].apps
        present(BackEnableNavigationController(rootViewController: fullController), animated: true)
    }
    
    private func setupSingleFullscreenController(for indexPath: IndexPath) {
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.row]
        appFullscreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        appFullscreenController.view.layer.cornerRadius = 16
        self.appFullscreenController = appFullscreenController
    }
    
    private func startingCellFrame(for indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {
            return
        }
        self.startingFrame = startingFrame
    }
    
    private func cardStartingPosition(for indexPath: IndexPath) {
        let fullscreenView = appFullscreenController.view!
        view.addSubview(fullscreenView)
        addChild(appFullscreenController)
        
        self.collectionView.isUserInteractionEnabled = false
        
        startingCellFrame(for: indexPath)
        guard let startingFrame = self.startingFrame else {
            return
        }
        
        self.anchoredConstraint = fullscreenView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(
                top: startingFrame.origin.y,
                left: startingFrame.origin.x,
                bottom: 0,
                right: 0
            ),
            size: .init(
                width: startingFrame.width,
                height: startingFrame.height
            )
        )
        self.view.layoutIfNeeded()
    }
    
    private func cardPopupAnimation() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut,
                       animations: {
                        self.anchoredConstraint?.top?.constant = 0
                        self.anchoredConstraint?.leading?.constant = 0
                        self.anchoredConstraint?.width?.constant = self.view.frame.width
                        self.anchoredConstraint?.height?.constant = self.view.frame.height
                        self.view.layoutIfNeeded()
                        self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
                        
                        guard let cell = self.appFullscreenController?.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else {
                            return
                        }
                        cell.todayCell.topConstraint?.constant = 48
                        cell.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func showSingleAppCard(for indexPath: IndexPath) {
        setupSingleFullscreenController(for: indexPath)
        cardStartingPosition(for: indexPath)
        cardPopupAnimation()
    }
}

extension TodayController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        switch item.cellType{
        case .single:
            let cell = TodayCell.dequeue(from: collectionView, for: indexPath, with: item)
            return cell
        case .multiple:
            let cell = TodayMultipleAppCell.dequeue(from: collectionView, for: indexPath, with: item)
            cell.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        switch item.cellType {
        case .multiple:
            showAppListCard(for: indexPath)
        case .single:
            showSingleAppCard(for: indexPath)
        }
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
