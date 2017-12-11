//
//  ContactImageCell.swift
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit

class ContactImageCell: UITableViewCell {

    @IBOutlet weak var contactNameLbl:UILabel!
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var profileImageView:UIImageView!
    
    @IBOutlet weak var callBtn:UIButton!
    @IBOutlet weak var messageBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(profileImagePressed))
        
        profileImageView.addGestureRecognizer(longPressGesture)
        // Initialization code
    }
    
    func updateData(data: [String:Any]) {
        
        if let name = data["name"] as? String {
            
            contactNameLbl.text = name
        }
        
        if let index = data["index"] as? Int {
            
            backgroundImageView.image = UIImage(named:"back\(index % AppTheme.BackgroundCount)")
            profileImageView.image = UIImage(named: "\(index % AppTheme.ImageCount)")
        }
    }
    
    @objc func profileImagePressed()
    {
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contactNameLbl.text = nil
        backgroundImageView.image = nil
        profileImageView.image = nil
        
    }

}
