//
//  PinterestLayout.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 8/5/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
    
    // 1
    var delegate: PinterestLayoutDelegate!
    
    // 2
    let numberOfColumns = 2
    var cellPadding: CGFloat = 6.0
    
    // 3
    var cache = [UICollectionViewLayoutAttributes]()
    
    // 4
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView?.contentInset
        return (collectionView?.bounds.width)! - ((insets?.left)! + (insets?.right)!)
    }
    
    override func prepare() {
        
        // 1
        if cache.isEmpty {
            //2
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            // 3
            for item in 0..<Int((collectionView?.numberOfItems(inSection: 0))!) {
                
                let indexPath = NSIndexPath(item: item, section: 0) as NSIndexPath
                
                // 4
                let width = columnWidth - cellPadding * 2
                let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath, withWidth: width) + cellPadding * 2
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height) as CGRect
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // 5
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                // 6
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = 1 - column
                
            }
            
        }
    }
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: contentWidth, height: contentHeight)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if rect.intersects(attributes.frame) {
                layoutAttributes.append(attributes)
            }
        }
        
        print("layout Attributes")
        return layoutAttributes
    }
}
