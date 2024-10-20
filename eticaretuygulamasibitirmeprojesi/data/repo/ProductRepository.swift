//
//  ProductRepository.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 13.10.2024.
//

import Foundation

final class NetworkManager {
    private let decoder: JSONDecoder = {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }()
    
    func fetchProducts(_ result: @escaping (Result<[Product], NetworkError>) -> Void) {
        guard let url = URL(string: URLEndpoints.fetchProducts.rawValue) else {
            result(.failure(.invalidURL))
            return
        }
        
        let request: URLRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                result(.failure(.invalidResponse))
                return
            }
            
            do {
                let productResponse: ProductResponse = try self.decoder.decode(ProductResponse.self, from: data)
                result(.success(productResponse.products))
            } catch {
                debugPrint(error.localizedDescription)
                result(.failure(.invalidData))
            }
        }.resume()
    }
    
    static func fetchImages(imageEndpoint: String, _ result: @escaping (Result<Data, NetworkError>) -> Void) -> Void {
        guard let url = URL(string: "\(URLEndpoints.fetchImages.rawValue)\(imageEndpoint)") else {
            result(.failure(.invalidURL))
            return
        }
        
        let request: URLRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                result(.failure(.invalidResponse))
                return
            }
            
            result(.success(data))
            
        }.resume()
    }
    
    // Here is some response maybe will be added later
    func addToBasket(product: ProductRequest, _ result: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let url = URL(string: URLEndpoints.addToBasket.rawValue) else {
            result(.failure(.invalidURL))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = product.responseString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard response != nil else {
                result(.failure(.invalidResponse))
                return
            }
            
            guard data != nil else {
                result(.failure(.invalidData))
                return
            }
            
            result(.success(true))
        }.resume()
    }
    
    func fetchBasket(_ result: @escaping (Result<[CartProduct], NetworkError>) -> Void) {
        guard let url = URL(string: URLEndpoints.fectBasket.rawValue) else {
            result(.failure(.invalidURL))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "kullaniciAdi=nizamet_ozkan".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                result(.failure(.invalidResponse))
                return
            }
            
            do {
                let productResponse: CartProductResponse = try self.decoder.decode(CartProductResponse.self, from: data)
                result(.success(productResponse.products))
            } catch {
                debugPrint(error.localizedDescription)
                result(.success([]))
            }
        }.resume()
    }
    
    func removeFromCart(_ cartId: Int, _ result: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let url = URL(string: URLEndpoints.removeFromBasket.rawValue) else {
            result(.failure(.invalidURL))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "sepetId=\(cartId)&kullaniciAdi=nizamet_ozkan".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error != nil else {
                debugPrint(error?.localizedDescription ?? "weird error")
                result(.success(false))
                return
            }
            
            guard response != nil else {
                result(.failure(.invalidResponse))
                return
            }
            
            guard data != nil else {
                result(.failure(.invalidData))
                return
            }
            
            result(.success(true))
        }.resume()
    }
}

enum URLEndpoints: String {
    case fetchProducts = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php"
    case fetchImages = "http://kasimadalan.pe.hu/urunler/resimler/"
    case addToBasket = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php"
    case fectBasket = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php"
    case removeFromBasket = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct ProductResponse: Decodable {
    let products: [Product]
    let success: Int
    
    enum CodingKeys: String, CodingKey {
        case products = "urunler"
        case success = "success"
    }
}
