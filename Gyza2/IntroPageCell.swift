//
//  IntroPageCell.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 9/5/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class IntroPageCell: UICollectionViewCell {

    // MARK: Properties
    var page: Page? {
        didSet {
            
            guard let page = page else {
                return
            }
            imageView.image = UIImage(named: page.imageName)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium), NSForegroundColorAttributeName: UIColor.white])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.white]))

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
            textView.attributedText = attributedText
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "IntroPage01")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "Gyza"
        textView.backgroundColor = UIColor.black
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setupViews() {
        backgroundColor = UIColor.yellow 
        addSubview(imageView)
        addSubview(textView)
       
        // ImageView Anchors
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    
        // TextView Anchors
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    
    
}
