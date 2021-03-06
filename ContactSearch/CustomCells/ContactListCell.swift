//
//  ContactListCell.swift
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit
import Contacts

class ContactListCell: UITableViewCell {

    @IBOutlet weak var contactNameLbl:UILabel!
    @IBOutlet weak var contactImageView:UIImageView!
    @IBOutlet weak var contactEmailLbl: UILabel!
    @IBOutlet weak var contactPhoneLbl: UILabel!
    @IBOutlet weak var contactGenderCell:UILabel!
    
    var data:[String:Any]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contactImageView.layer.cornerRadius = contactImageView.bounds.height / 2
        contactImageView.layer.masksToBounds = true
        // Initialization code
    }
    
    // For using dic
    
    func updateCell (with hit:[String:Any]) {
        
        data = hit
        
        if let name = hit["name"] as? String {
            
            contactNameLbl.text = name
        }
        
        if let email = hit["email"] as? String {
         
            contactEmailLbl.text = email
        }
        
        if let phone = hit["phone"] as? String {
            
            contactPhoneLbl.text = phone
        }
        
        if let index = hit["index"] as? Int {
            
            if  let image = UIImage(named: "\(index % 15)") {
                
                   contactImageView.image = image
            }
        }
        
        if let gender = hit["gender"] as? String {
            contactGenderCell.text = gender
        }
        
    }
    
    
    // For using contacts
    
    func updateData(with contact:CNContact) {
        contactNameLbl.text = contact.givenName
        
        if let imageData = contact.imageData {
            
            let contactImage = UIImage(data: imageData)
            contactImageView.image = contactImage
        }
        
        var phoneStr = ""
        var nameStr = ""
        var number: CNPhoneNumber!
        if contact.phoneNumbers.count > 0 {
            number = contact.phoneNumbers[0].value as! CNPhoneNumber
            phoneStr = number.stringValue.replacingOccurrences(of:"-" , with:"")
            
            contactPhoneLbl.text = phoneStr
        }
        
        if contact.emailAddresses.count > 0
        {
            let email:CNLabeledValue = contact.emailAddresses[0]
            contactEmailLbl.text = email.value as String
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contactNameLbl.text = nil
        contactImageView.image = nil
        contactEmailLbl.text = nil
        contactPhoneLbl.text = nil
        contactGenderCell.text = nil
    }

}
