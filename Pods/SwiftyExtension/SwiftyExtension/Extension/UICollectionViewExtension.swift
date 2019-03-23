//
//  UICollectionViewExtension.swift
//  GoldenTime
//
//  Created by Liem Ly Quan on 10/6/16.
//  Copyright © 2016 CAN. All rights reserved.
//
import UIKit

public extension UICollectionView {
    func registerCellNib(cellClass: AnyClass) {
        let identifier = String.className(aClass: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell(cellClass: AnyClass, for indexPath: IndexPath) -> UICollectionViewCell{
        let identifier = String.className(aClass: cellClass)
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
    func registerSupplementaryView(viewClass: AnyClass, ofKind kind: String) {
        let identifier = String.className(aClass: viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
    
    func dequeueReusableSupplementaryView(viewClass: AnyClass, ofKind kind: String, for indexPath: IndexPath) -> UICollectionReusableView{
        let identifier = String.className(aClass: viewClass)
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
    }
}


