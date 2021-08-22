//
//  JobAppViewModel.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/22/21.
//

import SwiftUI

class JobAppViewModel : ObservableObject {
    
    @Published var applications: [JobApplication] = [] //all created job applications
    
    init(){
        getApplications()
    }
    
    func getApplications(){
        let newApplications = [
            JobApplication(company: "Microsoft", title: "SE Intern", dateApplied: Date()),
            JobApplication(company: "FB", title: "Accountant", dateApplied: Date()),
            JobApplication(company: "SalesForce", title: "Sales Intern", dateApplied: Date())
        ]
        
        applications.append(contentsOf: newApplications)
    }
    
    //appends new application to applications array
    func addApplication(companyName:String, jobTitle:String , dateApplied:Date){
        let newApplication = JobApplication(company:companyName,title: jobTitle, dateApplied: dateApplied)
        applications.append(newApplication)
    }
    
    
}

