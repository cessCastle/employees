//
//  Navigations.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.

import Foundation
import  UIKit

class Navigations {
    
    static let shared = Navigations()
    

    
    func showADetailEmployee(employeeId: Int,vCToPresent : UINavigationController) {
           let storyboard : UIStoryboard = UIStoryboard(name: "EmployeeList", bundle: nil)
           let vC = storyboard.instantiateViewController(withIdentifier: "employeeDetail") as! EmployeeDetailViewController
           //vC.modalPresentationStyle = .automatic
           vC.detailViewModel.employeeId = employeeId
           vCToPresent.pushViewController(vC, animated: true)
            
    }
    
    func showHome(vCToPresent : UIViewController) {
           let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let vC = storyboard.instantiateViewController(withIdentifier: "tabBarVC") as! TabBarViewController
           vC.modalPresentationStyle = .fullScreen
           vCToPresent.present(vC, animated: true, completion: nil)
            
    }
    
    func showLogin(vCToPresent : UIViewController) {
           let storyboard : UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
           let vC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
           vC.modalPresentationStyle = .fullScreen
           vCToPresent.present(vC, animated: true, completion: nil)
            
    }
    

}
