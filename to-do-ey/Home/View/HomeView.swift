//
//  HomeView.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit

class HomeView: UIView {
    
    lazy var categoriesTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = .white
        tableview.contentInset = UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
        tableview.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        return tableview
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 20
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .black
        searchBar.tintColor = .darkGray
        searchBar.searchTextField.leftView?.tintColor = .black.withAlphaComponent(0.5)
        searchBar.placeholder = "Search for a task:"
        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(searchBar)
        addSubview(categoriesTableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            categoriesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            categoriesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoriesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            categoriesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
