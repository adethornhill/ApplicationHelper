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
    
    func deleteApplication(jobApp : JobApplication){
        if applications.contains(jobApp){
            container.viewContext.delete(jobApp)
            saveData()
        }
    }
    
    func createAppForTests(companyName:String, jobTitle:String , dateApplied:Date)->JobApplication{
        let newApp = JobApplication(context: container.viewContext)
        newApp.company = companyName
        newApp.title = jobTitle
        newApp.dateApplied = dateApplied
        newApp.status = "Applied"
        return newApp
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
    func getDateString(date: Date)->String{
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        formatter1.locale = Locale(identifier: "en_US")
        return formatter1.string(from: date)
    }
    
    func getImportantDate(jobApplication: JobApplication)->String{
        if let dateToReturn = jobApplication.importantDate {
            return getDateString(date: dateToReturn)
        }
        return "N/A"
    }
    
    
    func getRowColor(jobApplication: JobApplication)->Color{
        if jobApplication.status == "Rejected"{
            return Color(#colorLiteral(red: 0.8569247723, green: 0.173017025, blue: 0.08323720843, alpha: 0.2768476837))
        }
        else if jobApplication.status == "Accepted"{
            return Color(#colorLiteral(red: 0, green: 0.7583040595, blue: 0, alpha: 0.1535992266))
        }
        return Color(#colorLiteral(red: 0, green: 0.343914181, blue: 0.928293407, alpha: 0.2785940365))
    }
    
    //calculate top color of an application in its single application view
    func singleViewTopColor(jobApplication: JobApplication)->Color{
        if jobApplication.status == "Rejected"{
            return Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        }
        else if jobApplication.status == "Accepted"{
            return Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        }
        return Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))

        
    }
    
}



