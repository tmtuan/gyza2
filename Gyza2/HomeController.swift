//
//  ViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/5/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties
    var packages = [Package]()
    
    // MARK: Methods
    func fetchPackages() {
        let url = URL(string: "https://api.gyza.vn/api/packages")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            
                if let rootDictionary = json as? [String: Any] {
                    
                    for packageDictionary in rootDictionary["results"] as! [[String: Any]]   {
                        let pack = Package()
                        
                        // name
                        if let name = packageDictionary["name"] as? [String: Any] {
                            if let en_name = name["en"] as? String {
                                pack.name = en_name
                            }
                        }
                        
                        // photopgrapher
                        if let photographer = packageDictionary["photographer"] as? String {
                            pack.photographer = photographer
                        }
                        
                        // designer
                        if let designer = packageDictionary["designer"] as? String {
                            pack.designer = designer
                        }
                        
                        // category
                        if let category = packageDictionary["category"] as? String {
                            pack.category = category
                        }
                        
                        // location
                        if let location = packageDictionary["location"] as? String {
                            pack.location = location
                        }
                        
                        // address
                        if let address = packageDictionary["address"] as? String {
                            pack.address = address
                        }
                        
                        // slug
                        if let slug = packageDictionary["slug"] as? String {
                            pack.slug = slug
                        }
                        
                        // user
                        let userURL = URL(string: "https://api.gyza.vn/api/packages/\(pack.slug!)/?fields=publicer&populates[0][path]=publicer&populates[0][select]=_id+displayName+avatar")
                        
                        URLSession.shared.dataTask(with: userURL!) {
                            (data, response, error) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            
                            do {
                                let userJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                                
                                if let rootUserDictionary = userJSON as? [String: Any] {
                                    if let user_publisher = rootUserDictionary["publicer"] as? [String: Any] {
                                        pack.user = User()
                                        pack.user?.id = user_publisher["_id"] as? String
                                        pack.user?.displayName = user_publisher["displayName"] as? String
                                        
                                        // avatar
                                        if let user_avatar = user_publisher["avatar"] as? [String: Any] {
                                            if let avatar_url = user_avatar["secure_url"] as? String {
                                                pack.user?.avatar = avatar_url
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                }
                                
                            } catch let userJsonError {
                                print(userJsonError)
                            }
                        }.resume()
                        
                        
                        
                        // style tags
                        if let styleTags = packageDictionary["styleTags"] as? [String: Any] {
                            if let styleTagsEn = styleTags["en"] as? [String] {
                                for tag in styleTagsEn {
                                    pack.styleTags += [tag]
                                }
                            }
                        }
                        
                        // photo
                        if let gallery = packageDictionary["gallery"] as? [String: Any] {
                            if let largePhoto = gallery["large"] as? [String: Any] {
                                if let secureUrl = largePhoto["secure_url"] as? String {
                                    pack.photo = secureUrl
                                    
                                }
                            }
                        }
                        self.packages += [pack]
                    }
                    DispatchQueue.main.sync {
                        self.collectionView?.reloadData()
                    }
                    
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchPackages()
        
        navigationItem.title = "Gyza"
        
        collectionView?.backgroundColor = UIColor.white
        
        let cellIdentifier = "cellId"
        collectionView?.register(PackageCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    // MARK: UICollectionView Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.packages.count 
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PackageCell
     
        cell.package = packages[indexPath.item]
       
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
}

