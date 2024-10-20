//
//  ProductListViewModel.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 12.10.2024.
//

import Foundation

final class ProductListViewModel {
    private weak var view: HomeVCInterface?
    
    private let networkManager: NetworkManager = NetworkManager()
      
    @Published private(set) var products: [Product] = []
    
    init(view: HomeVCInterface) {
        self.view = view
    }
    
    func getProducts() {
        networkManager.fetchProducts { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async { [weak self] in
                    self?.products = products
                    self?.view?.collectionViewReloadData()
                }
                print("\(products.count) viewModel")
            case .failure:
                break
            }
        }
    }
}
