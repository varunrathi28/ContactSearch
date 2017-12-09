//
//  ContactsManager.swift
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit
import Contacts

class ContactsManager:NSObject {
    
    var contactStore = CNContactStore()
    static let shared = ContactsManager()
    
    
    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
            
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        
                        DispatchQueue.main.async {
                            let text = StringConstants.kAlertMessage
                            let message = "\(accessError!.localizedDescription)\n\n\(text)"
                            Utility.showMessage(with: message)
                        }
                        
                    }
                }
            })
            
        default:
            completionHandler(false)
        }
    }
    
    
}
