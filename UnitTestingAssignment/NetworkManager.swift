//
//  NetworkManager.swift
//  UnitTestingAssignment
//
//  Created by Baramidze on 02.12.23.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    private let productsUrlString = "https://dummyjson.com/products"
    
    private init() {}
    
    // MARK: - Fetch products
    func fetchProducts(completion: @escaping (Result<[Product]?, Error>) -> Void) {
        
        let url = URL(string: productsUrlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError()))
                return
            }
            
            do {
                let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                completion(.success(productsResponse.products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

final class MockNetworkManager: NetworkManagerProtocol {
    var products: [Product]?
    var error: Error?

    func fetchProducts(completion: @escaping (Result<[Product]?, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(products))
        }
    }
}
