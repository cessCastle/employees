//
//  EmployeeViewModel.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import Foundation

class EmployeeViewModel {
    
    var employees : [Employee] = []
    var employee : Employee?
    var indexpath : IndexPath?
    
    
    func fetchData(completionHandler: @escaping (Bool) -> ()) {
        
        Services.shared.getAllEmployees { [weak self] (result) in
            
            switch result {
                case .success(let employeesResponse):
                self?.employees = employeesResponse.data
                DispatchQueue.main.async {
                    completionHandler(true)
                }
                break
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(error)
                        completionHandler(false)
                }
            }
        }
        
    }
    
    
    func numberOfRows(at section: Int) -> Int {
        return employees.count
    }
    
    func item(at indexPath: IndexPath) -> Employee
    {
        return employees[indexPath.row]
    }
    
    
}
