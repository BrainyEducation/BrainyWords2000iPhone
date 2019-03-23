//
//  UITableViewExtension.swift
//  SwiftyExtension
//
//  Created by Khoi Nguyen on 4/23/17.
//  Copyright © 2017 Nguyen. All rights reserved.
//

import UIKit

public extension UITableView{
    func createIndexPaths(number: Int, section: Int? = nil)->[IndexPath]{
        var indexPaths = [IndexPath]()
        for i in 0..<number{
            let indexPath = IndexPath(row: i, section: section ?? 1)
            indexPaths.append(indexPath)
        }
        return indexPaths
    }
    
    func deleteRowsInTableView<T>(number: Int, section: Int? = nil, arr: inout [T]){
        let indexPaths = self.createIndexPaths(number: number, section: section)
        arr.removeAll()
        self.deleteRows(at: indexPaths, with: .none)
    }
    
    func insertRowsInTableView(number: Int, section: Int? = nil){
        let indexPaths = self.createIndexPaths(number: number, section: section)
        self.insertRows(at: indexPaths, with: .none)
    }
    
    func registerCellNib(cellClass: AnyClass) {
        let identifier = String.className(aClass: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderNib(headerClass: AnyClass) {
        let identifier = String.className(aClass: headerClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell(cellClass: AnyClass) -> UITableViewCell?{
        let identifier = String.className(aClass: cellClass)
        return self.dequeueReusableCell(withIdentifier: identifier)
    }
    
    func dequeueReusableHeader(headerClass: AnyClass) -> UITableViewHeaderFooterView?{
        let identifier = String.className(aClass: headerClass)
        return self.dequeueReusableHeaderFooterView(withIdentifier: identifier)
    }
    
    func initialize(delegate: AnyObject,
                    separatorStyle: UITableViewCellSeparatorStyle = .none,
                    showsVerticalScrollIndicator: Bool = false,
                    automaticRowHeight: Bool = false,
                    contentInset: UIEdgeInsets = .zero){
        
        self.dataSource = (delegate as! UITableViewDataSource)
        self.delegate = (delegate as! UITableViewDelegate)
        
        self.separatorStyle = separatorStyle
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.contentInset = contentInset
        
        self.tableFooterView = UIView(frame: .zero)
        
        if automaticRowHeight{
            self.estimatedRowHeight = 44
            self.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    func registerCellNibs(nibs: [AnyClass]){
        for aClass in nibs{
            self.registerCellNib(cellClass: aClass)
        }
    }
}
