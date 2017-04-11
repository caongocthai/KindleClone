//
//  BookTableViewCell.swift
//  KindleClone
//
//  Created by Thai Cao Ngoc on 10/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            self.titleLabel.text = self.book?.title
            self.authorLabel.text = self.book?.author
            self.coverImageView.image = nil
            
            guard let coverImageUrl = self.book?.coverImageUrl else { return }
            guard let url = URL(string: coverImageUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil { return }
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self.coverImageView.image = image
                }
            }.resume()
        }
    }
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Helvetica", size: 19)
        label.textColor = .white
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Helvetica", size: 15)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        addCoverImageView()
        addTitleLabel()
        addAuthorLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BookTableViewCell {
    func addCoverImageView() {
        self.addSubview(coverImageView)
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func addTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 13).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -11).isActive = true
    }
    
    func addAuthorLabel() {
        self.addSubview(authorLabel)
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 13).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        authorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 11).isActive = true
    }
}
