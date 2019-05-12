//
//  TodayMultipleAppsController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/12.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController {
    
    var apps = [FeedResult]()
    private let mode: Mode
    override var prefersStatusBarHidden: Bool { return true }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let spacing: CGFloat = 16
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == .fullscreen {
            setupCloseButton()
        } else {
            collectionView.isScrollEnabled = false
        }
        collectionView.register(type: MultipleAppCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(
                top: 20,
                left: 0,
                bottom: 0,
                right: 16
            ),
            size: .init(width: 44, height: 44)
        )
    }
}

extension TodayMultipleAppsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return apps.count
        } else {
            return min(4, apps.count)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = apps[indexPath.item]
        let cell = MultipleAppCell.dequeue(from: collectionView, for: indexPath, with: item)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = self.apps[indexPath.item].id
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat
        let height: CGFloat = 68
        switch mode {
        case .small:
            width = view.frame.width
        case .fullscreen:
            width = view.frame.width - 48
        }
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        } else {
            return .zero
        }
    }
}
