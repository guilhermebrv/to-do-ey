//
//  RealmData.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 26/12/2023.
//

import Foundation
import RealmSwift

class RealmData: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
