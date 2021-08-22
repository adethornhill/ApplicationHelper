//
//  CreateJobAppFormView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/19/21.
//

import SwiftUI

struct AddApplicationView: View {
    
    @Environment(\.presentationMode) var presentationMode //monitors where we are in view hiearchy
    @EnvironmentObject var jobAppViewModel:JobAppViewModel
    @State private var companyName = ""
    @State private var jobTitle = ""
    @State private var dateApplied = Date()
    @State var alertTitle:String=""
    @State var showAlert:Bool = false
    
    var body: some View {
            VStack{
                //create form for adding a job application
                Form{
                    Section{
                        TextField("Company Name", text: $companyName)
                        
                        TextField("JobTitle", text: $jobTitle)
                        
                        DatePicker("Date Applied:", selection: $dateApplied, in: ...Date(), displayedComponents: .date)
                    }
                }
                //button to submit form
                Button(action: submitPressed,
                       label: {
                        Text("Submit")
                            .bold()
                            .frame(width: 200,
                                   height: 25,
                                   alignment: .center)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                       })
            }
            .navigationTitle("Add Job Application")
            .alert(isPresented: $showAlert, content:getAlert)
    }
    
    func submitPressed(){
        if isTextValid(){
            jobAppViewModel.addApplication(companyName: companyName, jobTitle: jobTitle, dateApplied: dateApplied)
            
            presentationMode.wrappedValue.dismiss() //go back 1 view in view hiearchy
        }
    }
    
    func isTextValid()->Bool{
        if companyName.count < 2 || jobTitle.count < 2 {
            alertTitle="Company Name and Job Title must both contain at least 2 letters ‼️"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert()->Alert{
        return Alert(title: Text(alertTitle))
    }
}


struct CreateJobAppFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddApplicationView()
        }
        .environmentObject(JobAppViewModel())
    }
}
