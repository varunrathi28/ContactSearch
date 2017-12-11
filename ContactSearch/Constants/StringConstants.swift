//
//  StringConstants.swift
//  ContactSearch
//
//  Created by Varun Rathi on 09/12/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit

struct Auth {
    
    static let kAPIKey = "f6adfb412206bfa75b42e3118b52efbb"
    static let kAPPId = "37RZ8589WU"
    static let kIndex = "contacts"
    
}

struct StringConstants {

    
    static let kOkTitle =  "OK"
    static let kAlertMessage = "Please allow the app to access your contacts through the Settings."
    
}

enum DataCategory:Int {
    case Phone
    case Gender
    case Age
    case Email
    case Birthday
    case Company
    
    
    func toString()-> String {
        
        switch self {
        case .Phone:
            return "Phone"
            
        case .Birthday:
            return "Birthday"
            
        case .Age:
            return "Age"
            
        case .Company:
            return "Company"
            
        case .Email:
            return "Email"
            
        default:
            return "Gender"
        }
    }
}


struct CellData {

    let category:DataCategory
    let detail:String
    
}

