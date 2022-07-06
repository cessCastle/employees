//
//  Employee.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import Foundation


struct EmployeesResponse : Codable {

    var status : String
    var message : String
    var data : [Employee]

}

struct Employee : Codable {
    var id : Int
    var employee_name : String
    var employee_salary : Int
    var employee_age :  Int
    var profile_image : String
    
}

struct EmployeesResponseById : Codable {

    var status : String
    var message : String
    var data : Employee

}
