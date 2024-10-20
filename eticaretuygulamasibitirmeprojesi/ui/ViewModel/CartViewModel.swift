//
//  CartViewModel.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 12.10.2024.
//

import Foundation

class CartViewModel {
    var cartProducts: [CartProduct] = []
    var onCartFetched: (() -> Void)?

    func fetchCartProducts(for username: String) {
        let url = URL(string: "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "kullaniciAdi=\(username)"
        request.httpBody = bodyData.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            let fetchedCart = try? JSONDecoder().decode([CartProduct].self, from: data)
            self.cartProducts = fetchedCart ?? []
            DispatchQueue.main.async {
                self.onCartFetched?()
            }
        }.resume()
    }

    func addProductToCart(product: Product, quantity: Int, username: String) {
        let url = URL(string: "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "ad=\(product.name)&resim=\(product.image)&kategori=\(product.category)&fiyat=\(product.price)&marka=\(product.brand)&siparisAdeti=\(quantity)&kullaniciAdi=\(username)"
        request.httpBody = bodyData.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response accordingly
        }.resume()
    }
}
