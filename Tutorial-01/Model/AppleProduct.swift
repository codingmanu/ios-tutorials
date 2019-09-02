//
//  AppleProduct.swift
//  Tutorial-01
//
//  Created by Manuel S. Gomez on 9/2/19.
//  Copyright © 2019 codingManu. All rights reserved.
//

import UIKit

class AppleProduct: Decodable {

    enum CodingKeys: CodingKey {
        case id, name, year, imageUrl
    }

    let id: String
    let name: String
    let year: Int
    let imageUrl: String

    var productImage: UIImage?

}
