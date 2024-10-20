//
//  UICollectionView+Ext.swift
//  eticaretuygulamasibitirmeprojesi
//
//  Created by Berkay Kemal Özer on 17.10.2024.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cell: T.Type) {
        let className = String(describing: cell)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
           guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T else {
               fatalError("Could not dequeue cell with identifier: \(String(describing: type))")
           }
           return cell
       }
    
    func reloadDataOnMainThread() {
             DispatchQueue.main.async { self.reloadData() }
         }
}
