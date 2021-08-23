//
//  JobApplication.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/19/21.
//

import Foundation

struct JobApp : Identifiable{
    
    let id: String
    let aCompany : String
    let aTitle : String
    let aDateApplied: Date
    let aStatus: String 
    let aArchived: Bool = false
    //var aEventDate : Date?//imprtant date i.e date of interview, date rejected
    
    init(company:String,title:String,dateApplied:Date, id : String = UUID().uuidString, aStatus:String = "Applied"){
        self.aCompany=company
        self.aTitle=title
        self.aDateApplied=dateApplied
        self.id = id
        self.aStatus=aStatus
    }
    
    func getCompany()->String{
        return self.aCompany
    }
    
    func getTitle()->String{
        return self.aTitle
    }
    
    func getApplyDate()->String{
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        formatter1.locale = Locale(identifier: "en_US")
        return formatter1.string(from: aDateApplied)
    }
    
    func getStatus()->String{
        return self.aStatus
    }
}
