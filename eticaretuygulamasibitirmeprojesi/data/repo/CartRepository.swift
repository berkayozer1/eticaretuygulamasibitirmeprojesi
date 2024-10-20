import Foundation

class CartRepository {
    func fetchCartItems(for username: String, completion: @escaping ([CartProduct]) -> Void) {
        let url = URL(string: "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "kullaniciAdi=\(username)"
        request.httpBody = bodyData.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            let cartItems = try? JSONDecoder().decode([CartProduct].self, from: data)
            completion(cartItems ?? [])
        }.resume()
    }

    func addProductToCart(product: Product, quantity: Int, username: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // BodyData değişkenleri, Product modelindeki değişken isimleriyle uyumlu olmalı
        let bodyData = "ad=\(product.name)&resim=\(product.image)&kategori=\(product.category)&fiyat=\(product.price)&marka=\(product.brand)&siparisAdeti=\(quantity)&kullaniciAdi=\(username)"
        
        request.httpBody = bodyData.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }.resume()
    }

    func deleteProductFromCart(cartId: Int, username: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "sepetId=\(cartId)&kullaniciAdi=\(username)"
        request.httpBody = bodyData.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }.resume()
    }
}

