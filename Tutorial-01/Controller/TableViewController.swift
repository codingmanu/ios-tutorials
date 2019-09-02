//
//  TableViewController.swift
//  Tutorial-01
//
//  Created by Manuel S. Gomez on 9/2/19.
//  Copyright © 2019 codingManu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let dataSource = ProductDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign delegate and data source to table.
        tableView.delegate = self
        tableView.dataSource = dataSource

        tableView.register(ProductCell.self, forCellReuseIdentifier: "Cell")

        //Refresh control added to update products from data source.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(eventRefreshControl), for: .valueChanged)
        tableView.refreshControl = refreshControl

        // Set rows to automatic size.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadProductsFromDataSource()
    }

    @objc func eventRefreshControl(refreshControl: UIRefreshControl) {
        reloadProductsFromDataSource()
    }

    private func reloadProductsFromDataSource() {
        dataSource.loadProducts(completion: { [weak self] (result) in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                self?.showErrorAlert(error.localizedDescription)
            }
        })
    }

    private func showErrorAlert(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Error loading products: \(message)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
                self?.tableView.refreshControl?.endRefreshing()
            }))
            self.present(alert, animated: true)
        }
    }
}

