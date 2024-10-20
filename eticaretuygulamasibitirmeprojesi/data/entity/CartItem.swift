//
//  CartItem.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 15.10.2024.
//

import Foundation

struct CartItem {
    let name: String
    let price: Double
    let quantity: Int
    let imageName: String
}


struct ProductRequest {
    let name: String
    let image: String
    let category: String
    let price: Int
    let brand: String
    let orderCount: Int
    private let userName: String = "berkay_ozer"
    
    init(name: String, image: String, category: String, price: Int, brand: String, orderCount: Int) {
        self.name = name
        self.image = image
        self.category = category
        self.price = price
        self.brand = brand
        self.orderCount = orderCount
    }
}

extension ProductRequest {
    var responseString: String { "ad=\(self.name)&resim=\(self.image)&kategori=\(self.category)&fiyat=\(self.price)&marka=\(self.brand)&siparisAdeti=\(self.orderCount)&kullaniciAdi=berkay_ozer"
    }
}
