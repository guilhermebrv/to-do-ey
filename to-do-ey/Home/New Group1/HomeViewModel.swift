//
//  HomeViewModel.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 14/12/2023.
//

import UIKit

class HomeViewModel {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var categories: [Item] = [Item(name: "teste", checked: false),Item(name: "teste", checked: false),Item(name: "teste", checked: false),Item(name: "teste", checked: false),Item(name: "teste", checked: false),Item(name: "teste", checked: false)]
    
    public func saveUserData() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(categories)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding data - \(error.localizedDescription)")
        }
    }
    
    public func getCategory() -> [Item] {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                categories = try decoder.decode([Item].self, from: data)
                return categories
            } catch {
                print("error decoding data - \(error.localizedDescription)")
            }
        }
        return [Item]()
    }
    
    public var numberOfRowsInSection: Int {
        return getCategory().count
    }
    
    public var heightForRowAt: CGFloat {
        return 80
    }
}
