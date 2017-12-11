//
//  ContactDetailCell.swift
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit



class ContactDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblDetailTitle:UILabel!
    @IBOutlet weak var lblDetaiDesciption:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
     
       
        // Initialization code
    }
    
    func updateCellDetail(with data:CellData) {
        lblDetailTitle.text = data.category.toString()
        lblDetaiDesciption.text = data.detail
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lblDetailTitle.text = ""
        lblDetaiDesciption.text = ""
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    // 3D Touch capable
                    
                    let force = touch.force/touch.maximumPossibleForce
                }
            }
        }
    }
}
