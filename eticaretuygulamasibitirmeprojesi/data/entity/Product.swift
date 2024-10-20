//
//  Product.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 12.10.2024.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let name: String
    let image: String
    let category: String
    let price: Int
    let brand: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "ad"
        case image = "resim"
        case category = "kategori"
        case price = "fiyat"
        case brand = "marka"
    }
}
