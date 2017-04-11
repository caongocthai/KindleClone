//
//  PageCollectionViewCell.swift
//  KindleClone
//
//  Created by Thai Cao Ngoc on 11/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel() {
        self.addSubview(contentLabel)
        contentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        contentLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
