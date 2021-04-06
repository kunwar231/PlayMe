//
//  CategoryModel.swift
//  Foody CookBook
//
//  Created by A10B6X9A on 06/04/21.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation

struct Categories : Codable {

        let Categories : [CategoryModel]?
}

struct CategoryModel: Codable {
    
    let idCategory : String?
    let strCategory : String?
    let strCategoryThumb : String?
    let strCategoryDescription : String?
}
