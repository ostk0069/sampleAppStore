//
//  AppDetailCell.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var app: Result! {
        didSet {
            nameLabel.text = app?.trackName
            releaseNotesLabel.text = app?.releaseNotes
            guard let urlString = app?.artworkUrl100 else {
                return
            }
            appIconImageView.sd_setImage(with: URL(string: urlString))
            getButton.setTitle(app?.formattedPrice, for: .normal)
        }
    }
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    let getButton = UIButton(title: "GET")
    let whatsNewLabel = UILabel(text: "Whats new", font: .systemFont(ofSize: 20))
    let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        
        getButton.backgroundColor = #colorLiteral(red: 0.001666533411, green: 0.4817790985, blue: 0.999358356, alpha: 1)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 16
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getButton.setTitleColor(.white, for: .normal)
        getButton.constrainWidth(constant: 80)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [
                    nameLabel,
                    UIStackView(arrangedSubviews: [getButton, UIView()]),
                    UIView()
                    ], spacing: 12)
                ], customSpacing: 20),
            whatsNewLabel,
            releaseNotesLabel
            ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
