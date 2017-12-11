//
//  HeaderView.swift
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit


class HeaderView: UIView {

    @IBOutlet weak var imageBackground:UIImageView!
    @IBOutlet weak var imageProfile:UIImageView!
    @IBOutlet weak var contactName:UILabel!
    
    @IBOutlet weak var btnCall:UIButton!
    @IBOutlet weak var btnMail:UIButton!
    
    
    
    func updateData(data :[String:Any]) {
        
        if let name = data["name"] as? String {
            
            contactName.text = name
        }
        
        if let index = data["index"] as? Int {
            
            imageBackground.image = UIImage(named:"back\(index % AppTheme.BackgroundCount)")
            imageProfile.image = UIImage(named:"\(index % AppTheme.ImageCount)")
        }
        
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
