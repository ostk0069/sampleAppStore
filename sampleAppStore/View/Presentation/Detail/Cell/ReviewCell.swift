//
//  ReviewCell.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/06.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit
import Instantiate
import InstantiateStandard

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let autherLabel = UILabel(text: "author", font: .systemFont(ofSize: 16))
    
    let starStackView: UIStackView = {
        var arragedSubviews = [UIView]()
        (0..<5).forEach({ (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arragedSubviews.append(imageView)
        })
        arragedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arragedSubviews)
        return stackView
    }()
    
    let bodyLabel = UILabel(text: "body", font: .systemFont(ofSize: 18), numberOfLines: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        layer.cornerRadius = 12
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel,
                autherLabel
                ], customSpacing: 8
            ),
            starStackView,
            bodyLabel
            ], spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        autherLabel.textAlignment = .right
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewCell: Reusable {
}
