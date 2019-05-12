//
//  MultipleAppCell.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/12.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit
import Instantiate
import InstantiateStandard

class MultipleAppCell: UICollectionViewCell {
    
    var app: FeedResult! {
        didSet {
            nameLabel.text = app.name
            companyLabel.text = app.artistName
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    let imageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "APP Name", font: .boldSystemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9390758872, green: 0.9392114282, blue: 0.970784843, alpha: 1))
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        getButton.layer.cornerRadius = 32 / 2
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 2),
            getButton
            ]
        )
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
        
        addSubview(separatorView)
        separatorView.anchor(
            top: nil,
            leading: nameLabel.leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(
                top: 0,
                left: 0,
                bottom: -8,
                right: 0
            ), size: .init(
                width: 0,
                height: 0.5
            )
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MultipleAppCell: Reusable {
    typealias Dependency = FeedResult
    
    func inject(_ dependency: Dependency) {
        self.app = dependency
    }
}
