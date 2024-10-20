import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var productsList = [Product]

    var viewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        _ = viewModel.productsList.subscribe(onNext: { list in
            self.productsList = list
            self.collectionView.reloadData()
        })
        
        // Tasarım ayarları - FilmlerApp'teki tasarıma benzer olacak şekilde düzenleyelim
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
        
        collectionView.collectionViewLayout = layout
    }
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = productsList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell

        // Hücre içeriklerinin ayarlanması
        cell.imageViewProduct.image = UIImage(named: product.imageName)  // Ürün resmini ayarlıyoruz
        cell.labelPrice.text = "\(product.price) ₺"  // Fiyatı ayarlıyoruz
        
        // Hücre tasarımı
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productsList[indexPath.row]
        performSegue(withIdentifier: "showProductDetail", sender: product)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetail" {
            if let product = sender as? Product {
                let destinationVC = segue.destination as! ProductDetailViewController
                destinationVC.product = product
            }
        }
    }
}

