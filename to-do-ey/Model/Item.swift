//
//  Item.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 16/12/2023.
//

import Foundation

struct Item: Codable {
    var name: String
    var checked: Bool = false
}
