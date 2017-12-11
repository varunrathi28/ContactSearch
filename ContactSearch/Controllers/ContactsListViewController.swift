//
//  ContactsListViewController
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit
import Contacts
import CoreData
import AlgoliaSearch
import InstantSearch

class ContactsListViewController: HitsTableViewController {
    
    @IBOutlet weak var tableView:HitsTableWidget!
    @IBOutlet weak var searchBar:SearchBarWidget!
    
    var client:Client!
    var arrDataSource:[CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
         hitsTableView = tableView
        InstantSearch.shared.registerAllWidgets(in: self.view)
       // configure()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      //  fetchContacts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configure()
    {
        
      let searchBar = SearchBarWidget(frame: .zero)
        
        
        let stats = StatsLabelWidget(frame: .zero)
        
        self.view.addSubview(searchBar)
        self.view.addSubview(stats)
        
        // Add autolayout constraints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        stats.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["searchBar": searchBar, "stats": stats]
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[searchBar]-10-[stats]", options: [], metrics: nil, views:views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[searchBar]-2-|", options: [], metrics: nil, views:views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[stats]-2-|", options: [], metrics: nil, views:views)
        NSLayoutConstraint.activate(constraints)
        
        // Style the stats label
        stats.textAlignment = .center
        stats.font = UIFont.boldSystemFont(ofSize:18.0)
        
        
        // Load all objects in the JSON file into an index named "contacts".
     
        
    }
   
    func fetchContacts()
    {
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactImageDataKey,CNContactEmailAddressesKey,
                    CNContactPhoneNumbersKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        let contactManager = ContactsManager.shared
        
        do {
            try contactManager.contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                
                
                self.arrDataSource.append(contact)
                
                if self.arrDataSource.count > 0
                {
                    self.tableView.reloadData()
                }
            }
            
            
        }
        catch {
            
            Utility.showMessage(with:"unable to fetch contacts")
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing hit: [String : Any]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ContactCell , for: indexPath) as! ContactListCell

        // For using contacts from phone
/*
        let contact = arrDataSource[indexPath.row]
        cell.updateData(with: contact)
        */
        
        cell.updateCell(with: hit)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, containing hit: [String : Any]) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: StoryboardID.ContactDetailVC) as! DetailViewController
        vc.data = hit
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
       
        
}



/*

extension ContactsListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ContactCell , for: indexPath) as! ContactListCell
        
        let contact = arrDataSource[indexPath.row]
        
        cell.updateData(with: contact)
        return cell
    }
    
}
 
 */

 


extension ContactsListViewController:ContactProtocol {
    
    func didFetchedContacts(contacts: [CNContact]) {
        
        for contact in contacts {
            
            arrDataSource.append(contact)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}




extension ContactsListViewController : UISearchBarDelegate {
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
