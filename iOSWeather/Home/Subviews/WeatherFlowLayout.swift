//
//  WeatherFlowLayout.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class WeatherFlowLayout: UICollectionViewFlowLayout {
    
    private var attributesCache: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        attributesCache = [] //clear cache
        guard let collectionView = collectionView else { return }
        // Add all item in sections into attributes
        let numberOfSections = collectionView.numberOfSections
        for section in 0..<numberOfSections {
            let headerIndexPath = IndexPath(item: 0, section: section)
            if let headerAttribute = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: headerIndexPath)?.copy() {
                attributesCache.append(headerAttribute as! UICollectionViewLayoutAttributes)
            }
            if let footerAttribute = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,at: headerIndexPath)?.copy() {
                attributesCache.append(footerAttribute as! UICollectionViewLayoutAttributes)
            }
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            for item in 0..<numberOfItems {
                let indexPath = IndexPath(item: item, section: section)
                if let attribute = layoutAttributesForItem(at: indexPath)?.copy() {
                    attributesCache.append(attribute as! UICollectionViewLayoutAttributes)
                }
            }
        }
    }
    
    // UICollectionViewLayout should be updating the layout while scrolling
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //constantly updating method to configure header and footers behaviours
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let collectionView = self.collectionView else { return nil }
        // Scroll offset Y
        let yOffset = collectionView.contentOffset.y
        // all headers attributes
        let headersAttributes = attributesCache.filter { attribute -> Bool in
            return attribute.representedElementKind == UICollectionView.elementKindSectionHeader
        }
        //all footers attributes
        let footersAttributes = attributesCache.filter { (attribute) -> Bool in
            attribute.representedElementKind == UICollectionView.elementKindSectionFooter
        }
        // first header and first footer attributes
        guard let header = headersAttributes.first, let footer = footersAttributes.first else { return nil }
        // setup header in first section
        let minimumHeight = Screen.Home.CurrentHeader.minimumHeight
        let defaultHeight = Screen.Home.CurrentHeader.defaultHeight
        let newHeaderHeight = max(minimumHeight,defaultHeight - yOffset)
        header.frame.size.height = newHeaderHeight
        header.frame.origin.y = yOffset
        // setup footer in  first section
        footer.frame.origin.y = header.frame.origin.y + header.frame.size.height
        let cellsAttributes = attributesCache.filter { (attribute) -> Bool in
            return attribute.representedElementCategory == .cell //if attributes belong to items
        }
        
        let footerBottomBound = footer.frame.origin.y + footer.frame.size.height
        cellsAttributes.forEach { (attribute) in
            if attribute.frame.origin.y < footerBottomBound {
                attribute.alpha = 0
            }
        }
        return attributesCache
        
    }
    
    
    
}
