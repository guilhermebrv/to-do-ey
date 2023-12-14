//
//  CategoriesTableViewCell.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: CategoriesTableViewCell.self)
    private var screen: CategoriesTableViewCellView = CategoriesTableViewCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configScreen() {
        contentView.addSubview(screen)
        screen.pin(to: contentView)
    }
    
    public func setupCell(category: String) {
        screen.categoryLabel.text = category
    }

}
