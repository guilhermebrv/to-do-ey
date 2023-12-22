//
//  Extension - UIViewController.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 20/12/2023.
//

import UIKit

extension UIViewController {
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
