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

class ContactsListViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var textField:UITextField!
    
    var arrDataSource:[CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchContacts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
}

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
extension ContactsListViewController : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: StoryboardID.ContactDetailVC)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

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

extension ContactsListViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let input = textField.text + string
        
        
        
       return true
    }
}
