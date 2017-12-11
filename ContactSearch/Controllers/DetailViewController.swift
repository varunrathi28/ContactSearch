//
//  DetailViewController.swift
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    var arrDatasource:[CellData] = []
    
    var data:[String:Any] = [:] {
        
        didSet {
            
            self.configureData()
        }
    }
    var headerView:HeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension

    //    loadHeaderView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func loadHeaderView()
    {
        let nibs = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        
        self.headerView = nibs?.first as! HeaderView
        self.headerView.stretchDelegate = self as? GSKStretchyHeaderViewStretchDelegate
        self.tableView.addSubview(self.headerView)
    }

    
    func configureData()
    {
        // Parse contact details
        
        
        // Phone
        if  let phone = data["phone"] as? String {
            let phoneData = CellData(category:.Phone, detail:phone)
            arrDatasource.append(phoneData)
        }
        
        // Gender
        if  let gender = data["gender"] as? String {
            
            let cityData = CellData(category:.Gender, detail:gender)
            arrDatasource.append(cityData)
            
       // Age
            
            
            if let age = data["age"] as? Int {
             let ageData = CellData(category:.Age, detail:String(age))
                arrDatasource.append(ageData)
            }
            
            
        // Email
        if let email = data["email"] as? String {

            let emailData = CellData(category:.Email, detail:email)
            arrDatasource.append(emailData)
        }
        
        //Birthday
        
        if let birthday = data["birthday"] as? String {
            
            let birthdayData = CellData(category: .Birthday, detail: birthday)
            arrDatasource.append(birthdayData)
        }
        
        //Company
        if let company = data["company"] as? String {
       
            let compData = CellData(category: .Company, detail:company)
            arrDatasource.append(compData)
        }
        
       
        }
        
       
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDatasource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
          let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ContactDpCell, for: indexPath) as! ContactImageCell
            cell.updateData(data: data)
            return cell
        }
        
        else
        {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ContactDetailCell, for: indexPath) as! ContactDetailCell
        
        let data = arrDatasource[indexPath.row - 1]
        cell.updateCellDetail(with: data)
        return cell
        }
    }
    
}

extension DetailViewController:UITableViewDelegate {
    
  
}


