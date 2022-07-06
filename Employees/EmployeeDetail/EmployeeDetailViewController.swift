//
//  EmployeeDetailViewController.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var employeeIdLabel: UILabel!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeAgeLabel: UILabel!
    @IBOutlet weak var employeeSalaryLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    
    var detailViewModel  = EmployeeDetailViewModel()
    
    fileprivate(set) lazy var emptyStateView: UIView = {
        guard let view = Bundle.main.loadNibNamed("EmptyViewGeneral", owner: nil, options: [:])?.first as? UIView  else {
            return UIView()
        }
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
        
    }
    
    
    
    func setupDataSource() {
        
        self.getDetailEmployee()
       
    }
    
    func setup(model: Employee) {
        self.employeeIdLabel.text = "Employee ID: \(model.id)"
        self.employeeNameLabel.text = "Employee name: \(model.employee_name)"
        self.employeeAgeLabel.text = "Employee age: \(model.employee_age)"
        self.employeeSalaryLabel.text = "$\(model.employee_salary)"
        let color =  model.employee_salary > 1000 ?  UIColor.greenDark : UIColor.red
        self.employeeSalaryLabel.textColor = color
    }
    
    func getDetailEmployee() {
        self.detailViewModel.fetcEmployeeDetailData { (emp) in
            Loader.shared.hideActivity()
            let emptyView = self.emptyStateView as! EmptyViewGeneral
            emptyView.tag = 20
            if let employee = emp {
                self.setup(model: employee)
                self.mainStackView.isHidden = false
                Utils.shared.removeSubview(view: self.view, tag: 20)
            } else {
                self.mainStackView.isHidden = true
                emptyView.delegate = self
                self.view.addSubview(emptyView)
                
            }
           
        }
    }

  

}

extension EmployeeDetailViewController : EmptyViewGeneralDelegate {
   
    func clickRecargar(_ sender: EmptyViewGeneral) {
        
        Animations.shared.animateButtonPulse(view: sender.recargarButton, scaleX: 0.9, y: 0.9, duration: 0.1, withImpact: true)
        self.getDetailEmployee()
        Loader.shared.showActivityIndicator(viewToPresent: self)
    }
    
}
