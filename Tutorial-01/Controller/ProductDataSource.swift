//
//  DataSource.swift
//  Tutorial-01
//
//  Created by Manuel S. Gomez on 9/2/19.
//  Copyright © 2019 codingManu. All rights reserved.
//

import UIKit

class ProductDataSource: NSObject, UITableViewDataSource {

    var products: [AppleProduct] = []

    func loadProducts(completion: @escaping (Result<Void, Error>) -> ()) {
        ApiHandler.getProducts { [unowned self] (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let products):
                self.products = products
                completion(.success(Void()))
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
        cell.configureWithProduct(products[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
}
