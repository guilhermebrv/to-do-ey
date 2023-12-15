//
//  CategoriesTableViewCellView.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit

class CategoriesTableViewCellView: UIView {

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        layer.cornerRadius = 10
        clipsToBounds = true
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(categoryLabel)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

}
