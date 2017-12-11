//
//  DetailViewController.swift
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    var arrDatasource:[CellData] = []
    var data:[String:Any] = [:] {
        
        didSet {
            
            self.configureData()
        }
    }
    
    var isRegisteredFor3DTouch:Bool = false
    var headerImageView:UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
            
            if !isRegisteredFor3DTouch {
                
              
                   headerImageView = cell.profileImageView
                
               if traitCollection.forceTouchCapability == .available {
               
                registerForPreviewing(with: self, sourceView: headerImageView!)
                 isRegisteredFor3DTouch = true
                }
            }
            
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


extension DetailViewController:UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController)
    {
        // Present or push the view controller
        present(viewControllerToCommit, animated: true)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexpath = tableView.indexPathForRow(at: location) else { return nil}
   
        guard let cell =  tableView.cellForRow(at: indexpath) as? ContactImageCell else { return nil }
        
        
        let convertedLocation = view.convert(location, to: headerImageView!)
        if (headerImageView?.bounds.contains(convertedLocation))!
        {
            // Init the peek view controller, set relevant properties, and return it
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let imagePreview = storyboard.instantiateViewController(withIdentifier:StoryboardID.ImageVC) as? ImagePreviewController
            imagePreview?.imageView.image = headerImageView!.image
          //  imagePreview.sourceRect = headerImageView!.frame
            
            previewingContext.sourceRect = cell.profileImageView.frame
            return imagePreview
        }
        else
        {
            return nil
        }
        
    }
  
}


