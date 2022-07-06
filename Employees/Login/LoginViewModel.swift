//
//  LoginViewModel.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import Foundation

class LoginViewModel {
    
    var user = UserModel()
    var mensaje : String?
    
    func sendData(completionHandler: @escaping (Bool) -> ()) {
        
        Services.shared.loginFirebase(email: self.user.username!, password: self.user.password!) { [weak self] (result) in
            
            switch result {
                case .success(_):
                
                DispatchQueue.main.async {
                    completionHandler(true)
                }
                break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.mensaje = error.rawValue
                        completionHandler(false)
                    }
            }
            
            
            
        }
        
    }
}
