//
//  Loader.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import Foundation
import UIKit

class Loader  {
    
    
    static let shared = Loader()

    var alert = UIAlertController()
    
    
    func showActivityIndicator(viewToPresent: UIViewController) {
        alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        viewToPresent.present(alert, animated: true, completion: nil)
    }
    
    func hideActivity() {
        alert.dismiss(animated: true) {
            self.alert.dismiss(animated: true)
        }
    }
    
}
