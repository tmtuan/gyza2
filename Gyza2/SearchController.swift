//
//  SearchController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 9/3/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit
import AVFoundation

class SearchController: UICollectionViewController, UISearchBarDelegate {
    // MARK: Properties
    var packages = [Package]()
    
    // 1 - 2 column display style
    var displayStyle: Int = 0
    var displayStyleIcon = [ "twoColumn", "oneColumn"]
    
    var scrollView: UIScrollView!
    
    let zoomImageView = UIImageView()
    let blackBackgroundView = UIView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    var thumbnailImageView: UIImageView?
    
    var searchBar: UISearchBar = {
        var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 1000 , height: 14))
        searchBar.placeholder = "Search photos on Gyza...."
        return searchBar
    }()
    
    let cellIdentifier = "cellId"
    
    // MARK: Methods
    func animateImageview(thumbnailImageView: UIImageView) {
        
        self.thumbnailImageView = thumbnailImageView
        
        if let startingFrame = thumbnailImageView.superview?.convert(thumbnailImageView.frame, to: nil) {
            
            thumbnailImageView.alpha = 0
            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 50, width: 1000, height: 54)
                tabBarCoverView.backgroundColor = UIColor.black
                tabBarCoverView.alpha = 0
                keyWindow.addSubview(tabBarCoverView)
            }
            
            scrollView = UIScrollView(frame: view.frame)
            scrollView?.backgroundColor = UIColor.black
            scrollView.alpha = 0
            scrollView?.contentSize = zoomImageView.bounds.size
            scrollView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            zoomImageView .backgroundColor = UIColor.black
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = thumbnailImageView.image
            zoomImageView.contentMode = .scaleAspectFit
            //zoomImageView.clipsToBounds = true
            //zoomImageView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView?.addSubview(zoomImageView)
            
            view.addSubview(scrollView!)
            view.bringSubview(toFront: scrollView!)
            
            scrollView?.delegate = self
            
            setZoomScale()
            
            //view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HomeController.zoomOut)))
            
            UIView.animate(withDuration: 0.75) {
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
                self.scrollView.alpha = 1
            }
        }
    }
    
    func setZoomScale() {
        let imageViewSize = zoomImageView.bounds.size
        let scrollViewSize = scrollView?.bounds.size
        let widthScale = (scrollViewSize?.width)! / imageViewSize.width
        let heightScale = (scrollViewSize?.height)! / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.maximumZoomScale = 6.0
        scrollView.contentSize = (zoomImageView.image?.size)!
        scrollView.zoomScale = 1.0
    }
    
    func zoomOut() {
        if let startingFrame = thumbnailImageView!.superview?.convert(thumbnailImageView!.frame, to: nil) {
            
            UIView.animate(withDuration: 0.75, animations: {() -> Void in
                self.zoomImageView.frame = startingFrame
                
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
                self.scrollView.alpha = 0
                
            }, completion: { (didComplete) -> Void in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.thumbnailImageView?.alpha = 1
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
            })
        }
    }
    
    // MARK: Setup Functions
    
    private func setupCollectionView() {
        
        collectionView?.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = true
        
        collectionView?.register(PackageCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    private func setupNavBarButton() {
        
        let displayStyleImage = UIImage(named: displayStyleIcon[displayStyle])?.withRenderingMode(.alwaysOriginal)
        let displayStyleBarButtonItem = UIBarButtonItem(image: displayStyleImage, style: .plain, target: self, action: #selector(handleDisplayStyle))
        navigationItem.rightBarButtonItems = [displayStyleBarButtonItem]
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        let leftNavBarButton = UIBarButtonItem(customView: self.searchBar)
        navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    func handleDisplayStyle() {
        print("Switch style")
        displayStyle = 1 - displayStyle
        navigationItem.rightBarButtonItems?[0].image = UIImage(named: displayStyleIcon[displayStyle])?.withRenderingMode(.alwaysOriginal)
        
        self.collectionView?.reloadData()
        self.collectionView?.collectionViewLayout.invalidateLayout()
        
        if (displayStyle == 0 ) {
            let flowLayout = UICollectionViewFlowLayout()
            collectionView?.collectionViewLayout = flowLayout
            
            
        } else if (displayStyle == 1) {
            let pinterestLayout = PinterestLayout(conformer: self)
            collectionView?.collectionViewLayout = pinterestLayout!
            
        } else {
            print("Có lỗi")
        }
    }
    
    
    // MARK: View Appearing
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let pinterestLayout = PinterestLayout(conformer: self) {
//            collectionView?.collectionViewLayout = pinterestLayout
//        }
        
        UINavigationBar.appearance().backgroundColor = UIColor.black
        if let pinterestLayout = collectionView?.collectionViewLayout as? PinterestLayout {
            pinterestLayout.delegate = self
            print("conform PinterestLayout Search ")
        } else {
            print("Chưa conform PinterestLayout")
        }
        
        setupCollectionView()
        //setupNavBarButton()
        setupSearchBar()
        
        fetchSearchResults(keyword: "")
    }
    
    // MARK: UICollectionView Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.packages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PackageCell
        
        cell.package = packages[indexPath.item]
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    // MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        
        let keyword = searchBar.text as! String
        fetchSearchResults(keyword: keyword)
    }
    
    func fetchSearchResults(keyword: String) {
        
        self.packages.removeAll()
        let url = URL(string: "https://api.gyza.vn/api/search?keyword=\(keyword)")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in

            if error != nil {
                print(error!)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(json)
                
                if let rootDictionary = json as? [Any] {
                    if rootDictionary.count > 0 {
                    for result in rootDictionary {
                        if let resultDictionary = result as? [String: Any] {
                            let pack = Package()
                            if let source =  resultDictionary["_source"] as? [String: Any] {
                                // name
                                if let name = source["name"] as? [String: Any] {
                                    if let en_name = name["en"] as? String {
                                        pack.name = en_name
                                    }
                                }
                                // photopgrapher
                                if let photographer = source["photographer"] as? String {
                                    pack.photographer = photographer
                                }
                                
                                // designer
                                if let designer = source["designer"] as? String {
                                    pack.designer = designer
                                }
                                // category
                                if let category = source["category"] as? String {
                                    pack.category = category
                                }
                                // location
                                if let location = source["location"] as? String {
                                    pack.location = location
                                }
                                
                                // address
                                if let address = source["address"] as? String {
                                    pack.address = address
                                }
                                
                                // slug
                                if let slug = source["slug"] as? String {
                                    pack.slug = slug
                            
                                    // user
                                    let userURL = URL(string: "https://api.gyza.vn/api/packages/\(slug)/?fields=publicer&populates[0][path]=publicer&populates[0][select]=_id+displayName+avatar")
                                    
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
                                }
                                
                                // style tags
                                if let styleTags = source["styleTags"] as? [String: Any] {
                                    if let styleTagsEn = styleTags["en"] as? [String] {
                                        for tag in styleTagsEn {
                                            pack.styleTags += [tag]
                                        }
                                    }
                                }
                                
                                // photo
                                if let gallery = source["gallery"] as? [String: Any] {
                                    if let largePhoto = gallery["lg"] as? [String: Any] {
                                        if let width = largePhoto["width"] as? Float {
                                            pack.photoWidth = CGFloat(width)
                                        }
                                        
                                        if let height = largePhoto["height"] as? Float {
                                            pack.photoHeight = CGFloat(height)
                                        }
                                        if let secureUrl = largePhoto["secure_url"] as? String {
                                            pack.photo = secureUrl
                                        }
                                    }
                                }
                                self.packages += [pack]
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    

}

extension SearchController: UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
}

extension SearchController: PinterestLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        
        let item = packages[indexPath.item] as Package
        //item.photoHeight =
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: CGSize(width: view.frame.width, height: item.photoHeight == 0 ? 500 : item.photoHeight), insideRect:boundingRect)
        
        return rect.size.height > 450  ? 450 : rect.size.height
    }
}

extension SearchController {
    
    override func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = zoomImageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 10 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 10 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.zoomImageView
    }
}



