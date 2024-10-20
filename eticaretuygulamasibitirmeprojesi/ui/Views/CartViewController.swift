//
//  CartViewController.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 12.10.2024.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = CartViewModel()
    var username: String = "kasim_adalan" // Kullanıcı adı

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.onCartFetched = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.fetchCartProducts(for: username)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath)
        let cartProduct = viewModel.cartProducts[indexPath.row]
        // Hücreyi doldur (örneğin, ürün adı ve resmini göster)
        return cell
    }
}
