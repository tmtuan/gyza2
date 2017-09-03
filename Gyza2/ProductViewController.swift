//
//  ProductViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 9/1/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class ProductViewController: UICollectionViewController {
    
    // MARK: Propertes
    var products = [Product]()
    
    let cellIdentifier = "cellId"
    
    
    // MARK: Load func
    override func viewDidLoad() {
        
        navigationItem.title = "Product"
        
        setupCollectionView()
        
        fetchProducts()
    }
    
    func fetchProducts() {
        
        let url = URL(string: "https://api.gyza.vn/api/products")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                if let rootDictionary = json as? [String: Any] {
                    for productDictionary in rootDictionary["results"] as! [[String: Any]] {
                        let product = Product()
                        
                        // name 
                        if let name = productDictionary["name"] as? [String: Any] {
                            if let en_name = name["en"] as? String {
                                product.name = en_name
                            }
                        }
                        
                        // photo 
                        if let gallery = productDictionary["gallery"] as? [String: Any] {
                            if let largePhoto = gallery["large"] as? [String: Any] {
                                if let width = largePhoto["width"] as? Float {
                                    product.photoWidth = CGFloat(width)
                                }
                                if let height = largePhoto["height"] as? Float {
                                    product.photoHeight = CGFloat(height)
                                }
                                if let secureURL = largePhoto["secure_url"] as? String {
                                    product.photo = secureURL
                                }
                            }
                        }
                        self.products += [product]
                    }
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            } catch let error {
                print(error)
            }
            
            
        }.resume()
        
        
    }
    
    // MARK: setup
    
    func setupCollectionView() {
        
        collectionView?.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = true
    
        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }

    
    // MARK: collectionView delegates
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductCell
        
        cell.product = products[indexPath.item]
        
        return cell
        
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = view.frame.width / 3.0 - 1 - 1
        return CGSize(width: size, height: size)
    }
    
}
