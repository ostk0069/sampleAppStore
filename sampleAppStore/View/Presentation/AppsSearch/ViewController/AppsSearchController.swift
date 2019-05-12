//
//  AppsSearchController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/04.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController {
    
    private var appResults = [Result]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        collectionView.register(type: SearchResultCell.self)
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
    }
    
    private func fetchItunesApps() {
        Service.shared.fetchApps(searchTerm: "twitter") { (res, error) in
            if let error = error {
                print("failed to fetch apps:", error)
                return
            }
            guard let results = res else {
                return
            }
            self.appResults = results.results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension AppsSearchController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApps(searchTerm: searchText) { (res, error) in
                if let error = error {
                    print(error)
                    return
                }
                guard let result = res else {
                    return
                }
                self.appResults = result.results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}

extension AppsSearchController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
            let cell = SearchResultCell.dequeue(from: collectionView, for: indexPath)
            cell.appResult = appResults[indexPath.item]
            return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appDetailController = AppDetailController(appId: String(appResults[indexPath.item].trackId))
        navigationController?.pushViewController(appDetailController, animated: true)
    }
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}
