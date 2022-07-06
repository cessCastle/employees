//
//  EmployeeDetailViewModel.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import Foundation

class EmployeeDetailViewModel {
    
    var employee : Employee?
    var employeeId : Int = 0
    var indexpath : IndexPath?
    
    
    func fetcEmployeeDetailData(completionHandler: @escaping (Employee?) -> ()) {
        
        Services.shared.getEmployeeDetail(employeeId: self.employeeId) { [weak self] (result) in
            
            switch result {
                case .success(let response):
                self?.employee = response.data
                DispatchQueue.main.async {
                    completionHandler(self?.employee!)
                }
                break
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(error)
                        completionHandler(self?.employee)
                    }
            }
        }
    
        
    }

}
