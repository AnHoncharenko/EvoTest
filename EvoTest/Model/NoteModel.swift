//
//  NoteModel.swift
//  EvoTest
//
//  Created by Anton Honcharenko on 5/14/19.
//  Copyright © 2019 Anton Honcharenko. All rights reserved.
//

import Foundation
import RealmSwift

class NoteModel: Object  {
    @objc dynamic var date: Date = Date()
    @objc dynamic var text: String = ""    
}
