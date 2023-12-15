//
//  Extension + UIView.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit

extension UIView {
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: 10),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 30),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -30),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -10)
        ])
    }
}
