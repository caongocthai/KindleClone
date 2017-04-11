//
//  BookTableViewController.swift
//  KindleClone
//
//  Created by Thai Cao Ngoc on 10/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    var books = [Book]()
    
    let bookCellID = "bookCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .darkGray
        self.tableView.register(BookTableViewCell.self, forCellReuseIdentifier: bookCellID)
        self.tableView.tableFooterView = UIView()

        customiseNavigationBar()
        fetchData()
    }
    
    func customiseNavigationBar() {
        navigationItem.title = "Kindle"
        navigationController?.navigationBar.barTintColor = UIColor(white: 0.15, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "amazon_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
    }
}

extension BookTableViewController {
    func fetchData() {
        guard let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if error != nil { return }
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let bookDictionaries = json as? [[String: Any]] else { return }
                
                for bookDictionary in bookDictionaries {
                    guard let title = bookDictionary["title"] as? String else { return }
                    guard let author = bookDictionary["author"] as? String else { return }
                    guard let coverImageUrl = bookDictionary["coverImageUrl"] as? String else { return }
                    
                    var pages = [String]()
                    if let pageDictionaries = bookDictionary["pages"] as? [[String:Any]] {
                        for pageDictionary in pageDictionaries {
                            if let text = pageDictionary["text"] as? String {
                                pages.append(text)
                            }
                        }
                    }
                    self.books.append(Book(title: title, by: author, coverImageUrl: coverImageUrl, content: pages))
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch { return }
        }.resume()
    }
}

extension BookTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> BookTableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: bookCellID, for: indexPath) as! BookTableViewCell
        // Configure the cell...
        bookCell.book = books[indexPath.row]
        return bookCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension BookTableViewController {
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        customiseFooter(footerView)
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func customiseFooter(_ footerView: UIView) {
        footerView.backgroundColor = .black
        
        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        footerView.addSubview(segmentedControl)
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let gridButon = UIButton(type: .system)
        gridButon.translatesAutoresizingMaskIntoConstraints = false
        gridButon.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal), for: .normal)
        footerView.addSubview(gridButon)
        gridButon.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 10).isActive = true
        gridButon.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        gridButon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let sortButon = UIButton(type: .system)
        sortButon.translatesAutoresizingMaskIntoConstraints = false
        sortButon.setImage(#imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal), for: .normal)
        footerView.addSubview(sortButon)
        sortButon.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -10).isActive = true
        sortButon.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        sortButon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortButon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

extension BookTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flowLayout = UICollectionViewFlowLayout()
        let pageCollectionViewController = PageCollectionViewController(collectionViewLayout: flowLayout)
        let selectedCell = self.tableView.cellForRow(at: indexPath) as? BookTableViewCell
        pageCollectionViewController.book = selectedCell?.book
        self.present(UINavigationController(rootViewController: pageCollectionViewController), animated: true, completion: nil)
    }
}










