//
//  AppsSearchController.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/04.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: UICollectionViewController {
    
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
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: "SearchResultCell")
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(collectionViewLayout: UICollectionViewFlowLayout()) has not been implemented")
    }
    
    private func fetchItunesApps() {
        Service.shared.fetchApps(searchTerm: "twitter") { (results, error) in
            if let error = error {
                print("failed to fetch apps:", error)
                return
            }
            self.appResults = results
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
            Service.shared.fetchApps(searchTerm: searchText) { (response, error) in
                self.appResults = response
                
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
            cell.appResult = appResults[indexPath.item]
            return cell
    }
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}
