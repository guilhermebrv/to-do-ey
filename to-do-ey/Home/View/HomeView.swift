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
        tableview.allowsSelection = false
        tableview.contentInset = UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
        tableview.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        return tableview
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
        addSubview(categoriesTableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            categoriesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoriesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            categoriesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
