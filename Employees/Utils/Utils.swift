//
//  Utils.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.

import Foundation
import UIKit


class Utils {
    
    static let shared = Utils()
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    
    func registerCell(tableView: UITableView, nib: String? = nil, identifier: String) {
          tableView.register(UINib(nibName: nib ?? identifier, bundle: nil),forCellReuseIdentifier: identifier)
      }
    
    func registerCell(collectionView: UICollectionView, nib: String? = nil, identifier: String) {
        collectionView.register(UINib(nibName: nib ?? identifier, bundle: nil),forCellWithReuseIdentifier: identifier)
    }
    
    
    func removeSubview(view: UIView,tag : Int){
        print("Start remove sibview")
        if let viewWithTag = view.viewWithTag(tag) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }


  
}




