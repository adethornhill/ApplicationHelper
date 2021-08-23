//
//  JobAppViewModel.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/22/21.
//

import SwiftUI
import CoreData
class JobAppViewModel : ObservableObject {
    
    @Published var applications: [JobApplication] = [] //all created job applications
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "JopApplicationContainer")
        //load data from container
        container.loadPersistentStores{
            (description,error) in
            if let error = error {
                print("Error loading Core Data: \(error)")
            }
        }
        
        fetchApplications()
    }
    
    //get data from core data database
    func fetchApplications(){
        let request = NSFetchRequest<JobApplication>(entityName:"JobApplication")
        
        do{
            applications =  try container.viewContext.fetch(request)
        } catch let error{
            print("Error when fetching : \(error)")
        }
        
    }
    
    //function for adding new applications
    func addApplication(companyName:String, jobTitle:String , dateApplied:Date){
        let newApp = JobApplication(context: container.viewContext)
        newApp.company = companyName
        newApp.title = jobTitle
        newApp.dateApplied = dateApplied
        newApp.status = "Applied"
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetchApplications() //any time we save we fetch so that savedApplications array is updated
        } catch let error {
            print("Error when saving: \(error)")
        }
    }
    
    
    
    //converts date to string
    func getApplyDate(date: Date)->String{
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        formatter1.locale = Locale(identifier: "en_US")
        return formatter1.string(from: date)
    }
    

    
}



