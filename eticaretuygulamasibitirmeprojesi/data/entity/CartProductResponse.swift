//
//  CartProductResponse.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 16.10.2024.
//

import Foundation

struct CartProductResponse: Decodable {
    let products: [CartProduct]
    let success: Int
    
    enum CodingKeys: String, CodingKey {
        case products = "urunler_sepeti"
        case success = "success"
    }
}
