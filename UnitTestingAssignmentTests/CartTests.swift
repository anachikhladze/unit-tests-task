//
//  CartTests.swift
//  CartTests
//
//  Created by Anna Sumire on 03.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class CartTests: XCTestCase {
    
    var viewModel: CartViewModel!
       
       override func setUp() {
           super.setUp()
           viewModel = CartViewModel()
           viewModel.allproducts = [Product(id: 1, price: 10.0, selectedQuantity: 2),
                                    Product(id: 2, price: 20.0, selectedQuantity: 3)]
       }
       
       override func tearDown() {
           viewModel = nil
           super.tearDown()
       }
    
    func testSelectedItemsQuantity() {
        // Given (Arrange)
        let firstProduct = Product(id: 1, price: 10.0, selectedQuantity: 2)
        let secondProduct = Product(id: 2, price: 20.0, selectedQuantity: 3)
       
        // When (Act)
        viewModel.addProduct(product: firstProduct)
        viewModel.addProduct(product: secondProduct)
        
        // Then (Assert)
        XCTAssertEqual(viewModel.selectedItemsQuantity, 5, "The selectedItemsQuantity should be 5")
    }
    
    func testTotalPrice() {
        // Given (Arrange)
        let firstProduct = Product(id: 1, price: 10.0, selectedQuantity: 2)
        let secondProduct = Product(id: 2, price: 20.0, selectedQuantity: 3)
       
        // When (Act)
        viewModel.addProduct(product: firstProduct)
        viewModel.addProduct(product: secondProduct)
        
        // Then (Assert)
        XCTAssertEqual(viewModel.totalPrice, 80.0, "The totalPrice should be 80.0")
    }
    
    func testAddProductWithID() {
        // Given (Arrange)
        let id = 1
        
        // When (Act)
        viewModel.addProduct(withID: id)
        
        // Then (Assert)
        XCTAssertEqual(viewModel.selectedProducts.count, 1, "The selectedProducts count should be 1")
        XCTAssertEqual(viewModel.selectedProducts.first?.id, id, "The first product's id should be \(id)")
    }
    
    func testAddProduct() {
        // Given (Arrange)
        let productToAdd = Product(id: 7, price: 100.0, selectedQuantity: 3)
        
        // When (Act)
        viewModel.addProduct(product: productToAdd)
        
        // Then (Assert)
        XCTAssertEqual(viewModel.selectedProducts.count, 1, "The selectedProducts count should be 1")
        XCTAssertEqual(viewModel.selectedProducts.first?.id, productToAdd.id, "The first product's id should be \(productToAdd.id ?? 0)")
    }
    
    func testAddRandomProduct() {
        // Given (Arrange)
        let initialCount = viewModel.selectedProducts.count
        
        // When (Act)
        viewModel.addRandomProduct()
        let newCount = viewModel.selectedProducts.count
        
        // Then (Assert)
        XCTAssertEqual(newCount, initialCount + 1, "addRandomProduct should increase the count of selectedProducts by 1")
    }
    
    func testClearCart() {
        // Given (Arrange)
        let firstProduct = Product(id: 1, price: 10.0, selectedQuantity: 2)
        let secondProduct = Product(id: 2, price: 20.0, selectedQuantity: 3)
        viewModel.addProduct(product: firstProduct)
        viewModel.addProduct(product: secondProduct)
        
        // When (Act)
        viewModel.clearCart()
        
        // Then (Assert)
        XCTAssertTrue(viewModel.selectedProducts.isEmpty)
    }

}
