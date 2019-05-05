//
//  AppsPageHeaderCell.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

class AppsPageHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "FaceBook .inc", font: .boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(text: "keeping up with friends is faster than ever", font: .systemFont(ofSize: 30))
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .red
        
        companyLabel.textColor = .blue
        titleLabel.numberOfLines = 2
        
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
