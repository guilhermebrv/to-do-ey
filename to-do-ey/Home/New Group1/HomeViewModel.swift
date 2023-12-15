//
//  HomeViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit

class HomeViewModel {
    
    var categories: [String] = ["Teste1", "Teste2", "Teste3", "Teste4", "Teste5"]
    
    public var getCategory: [String] {
        return categories
    }
    
    public var numberOfRowsInSection: Int {
        return categories.count
    }
    
    public var heightForRowAt: CGFloat {
        return 100
    }
}
