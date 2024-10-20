//
//  CartProduct.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 12.10.2024.
//

import Foundation

struct CartProduct: Decodable {
    let cartId: Int
    let name: String
    let image: String
    let category: String
    let price: Int
    let brand: String
    var orderCount: Int
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case cartId = "sepetId"
        case name = "ad"
        case image = "resim"
        case category = "kategori"
        case price = "fiyat"
        case brand = "marka"
        case orderCount = "siparisAdeti"
        case username = "kullaniciAdi"
    }
}
