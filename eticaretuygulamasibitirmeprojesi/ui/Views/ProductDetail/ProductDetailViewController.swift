//
//  ProductDetailViewController.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 14.10.2024.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var totalPriceLabel: UILabel!

    var product: Product?
    var quantity: Int = 1 {
        didSet {
            quantityLabel.text = "\(quantity)"
            updateTotalPrice()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProductDetails()
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        quantity = Int(sender.value)
    }

    @IBAction func addToCartTapped(_ sender: UIButton) {
        guard let product = product else { return }
        print("Ürün sepete eklendi: \(product.name), adet: \(quantity)")
    }

    private func setupProductDetails() {
        guard let product = product else { return }
        productNameLabel.text = product.name
        productPriceLabel.text = "₺\(product.price)"
        totalPriceLabel.text = "₺\(product.price * quantity)"
        if let imageURL = URL(string: product.image) {
            productImageView.kf.setImage(with: imageURL)
        }
    }

    private func updateTotalPrice() {
        guard let product = product else { return }
        let totalPrice = product.price * quantity
        totalPriceLabel.text = "₺\(totalPrice)"
    }
}
