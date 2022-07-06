//
//  EmptyViewGeneral.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.


import Foundation
import UIKit

protocol EmptyViewGeneralDelegate: AnyObject {
    func clickRecargar(_ sender: EmptyViewGeneral)
}

class EmptyViewGeneral: UIView {

    @IBOutlet weak var imagenImageView: UIImageView!
    @IBOutlet weak var textoLabel: UILabel!
    @IBOutlet weak var recargarButton: UIButton!

    weak var delegate: EmptyViewGeneralDelegate?
    
    
    
    
    @IBAction func recargarPressed(_ sender: UIButton) {
        
        delegate?.clickRecargar(self)
        
    }
    
}
