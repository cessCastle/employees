//
//  EmployeeListViewController.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import UIKit

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var employeeViewModel = EmployeeViewModel()
    
    fileprivate(set) lazy var emptyStateView: UIView = {
        guard let view = Bundle.main.loadNibNamed("EmptyViewGeneral", owner: nil, options: [:])?.first as? UIView  else {
            return UIView()
        }
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.setupDataSource()
     

        
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        Utils.shared.registerCell(tableView: tableView, nib: "EmployeeTableViewCell", identifier: "employeeCell")
     
    }
    
    func setupDataSource() {
        
        self.getAllEmployees()
       
    }
    
    func getAllEmployees() {
        Loader.shared.showActivityIndicator(viewToPresent: self)
        self.employeeViewModel.fetchData { (result) in
            Loader.shared.hideActivity()
            switch result {
                case true :
                self.tableView.backgroundView = nil
                break
                
                case false:
                let emptyView = self.emptyStateView as! EmptyViewGeneral
                self.tableView.backgroundView = emptyView
                emptyView.delegate = self
                break
                
            }
            
            self.tableView.reloadData()
            
        }
    }

}

extension EmployeeListViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.employeeViewModel.numberOfRows(at: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as? EmployeeTableViewCell
        let employee = employeeViewModel.item(at: indexPath)
        cell?.setup(model:employee)
    
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let employee = employeeViewModel.item(at: indexPath)
        //homeViewModel.indexPath = indexPath
        
        Navigations.shared.showADetailEmployee(employeeId: employee.id, vCToPresent: self.navigationController!)
    }
    
    
    
}

extension EmployeeListViewController : EmptyViewGeneralDelegate {
   
    func clickRecargar(_ sender: EmptyViewGeneral) {
        
        Animations.shared.animateButtonPulse(view: sender.recargarButton, scaleX: 0.9, y: 0.9, duration: 0.1, withImpact: true)
        self.getAllEmployees()
    }
    
}
