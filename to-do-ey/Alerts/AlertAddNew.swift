//
//  AlertAddNew.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 15/12/2023.
//

import UIKit

class AlertAddNew {
    private let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    public func showAlert(title: String, completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            let textField = alertController.textFields?.first
            completion(textField?.text)
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Choose a name for it"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        controller.present(alertController, animated: true)
    }
}
