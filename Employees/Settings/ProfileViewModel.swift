//
//  ProfileViewModel.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import Foundation
import UIKit

class ProfileViewModel  {
    
    var image : UIImage?
    var imageUrl : String?
    
    
    func uploadImageData(completionHandler: @escaping (Bool) -> ()) {
        
        Services.shared.uploadImage(photo: self.image!) { result in
            
            switch result {
                case .success(let responseUrl):
                self.imageUrl = responseUrl
                DispatchQueue.main.async {
                    completionHandler(true)
                }
                break
                case .failure(_):
                    DispatchQueue.main.async {
                        completionHandler(false)
                    }
            }
        }
    }
        
    
    func logOut(completionHandler: @escaping (Bool) -> ()) {
       
        Services.shared.logOutUserFirebase { result in
            
            switch result {
                case .success(_):
                DispatchQueue.main.async {
                    self.deleteUsersDefaults()
                    completionHandler(true)
                }
                break
                case .failure(_):
                    DispatchQueue.main.async {
                        completionHandler(false)
                    }
            }
        }
        
    }
    
    func deleteUsersDefaults() {
        UserDefaults.standard.removeObject(forKey: "session")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "profileImageUrl")
    }
     
    
}
