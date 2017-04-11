//
//  PageCollectionViewController.swift
//  KindleClone
//
//  Created by Thai Cao Ngoc on 11/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

private let pageCellID = "pageCellID"

class PageCollectionViewController: UICollectionViewController {
    
    var book: Book? {
        didSet {
            self.navigationItem.title = self.book?.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: pageCellID)

        // Do any additional setup after loading the view.
        self.collectionView?.backgroundColor = UIColor(red: 240/255, green: 230/255, blue: 210/255, alpha: 1)
        setNavigationBar()
        setCollectionViewLayout()
        
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.pages.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCellID, for: indexPath) as! PageCollectionViewCell
    
        // Configure the cell
        pageCell.contentLabel.text = book?.pages[indexPath.row]
        return pageCell
    }
}

extension PageCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView!.frame.width, height: self.collectionView!.frame.height - 64)
    }
    
    func setCollectionViewLayout() {
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        self.collectionView?.isPagingEnabled = true
    }
}

extension PageCollectionViewController {
    func setNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
    }
    
    func doneButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
