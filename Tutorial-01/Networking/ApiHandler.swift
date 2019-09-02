//
//  ApiHandler.swift
//  Tutorial-01
//
//  Created by Manuel S. Gomez on 9/2/19.
//  Copyright © 2019 codingManu. All rights reserved.
//

import UIKit

class ApiHandler {

    enum ApiError: Error {
        case imageNotFound
    }

    static func getProducts(completion: @escaping (Result<[AppleProduct], Error>) -> ()) {

        guard let url = URL(string: "https://tutorialsapi.codingmanu.com/tutorial-01/data.json") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let error = error {
                    completion(.failure(error))
                }

                let decoder = JSONDecoder()
                let returnedProducts = try decoder.decode([AppleProduct].self, from: data)

                completion(.success(returnedProducts))

            } catch {
                completion(.failure(error))
            }
            }.resume()
    }

    static func getProductImage(url: String, completion: @escaping (Result<UIImage, Error>) -> ()) {

        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

                if let error = error {
                    completion(.failure(error))
                }

                if let returnedImage = UIImage(data: data) {
                    completion(.success(returnedImage))
                } else {
                    completion(.failure(ApiError.imageNotFound))
            }
        }.resume()
    }
}
