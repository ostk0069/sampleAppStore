//
//  ReviewCell.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/06.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let autherLabel = UILabel(text: "author", font: .systemFont(ofSize: 16))
    let starsLable = UILabel(text: "star", font: .systemFont(ofSize: 20))
    
    let bodyLabel = UILabel(text: "hogedndjlncjdnkjndjndjncjdnckdjcnj", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        layer.cornerRadius = 12
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel,UIView(),autherLabel]),
            starsLable,
            bodyLabel
            ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
