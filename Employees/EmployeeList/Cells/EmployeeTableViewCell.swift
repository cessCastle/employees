//
//  EmployeeTableViewCell.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeId: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeSalary: UILabel!
    @IBOutlet weak var employeeAge: UILabel!
    
    
    
    func setup(model: Employee) {
        employeeId.text = "Employee ID: \(model.id)"
        employeeName.text = "Employee Name: \(model.employee_name)"
        employeeSalary.text = "$\(model.employee_salary)"
        employeeAge.text = "\(model.employee_age)"
        let color =  model.employee_age > 25 && model.employee_age < 35 ?  UIColor.greenDark : UIColor.red
        employeeAge.textColor = color
       
        
    }
    
}
