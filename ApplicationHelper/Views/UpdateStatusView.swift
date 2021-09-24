//
//  updateStatusView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/26/21.
//

import SwiftUI

struct UpdateStatusView: View {
    @EnvironmentObject var viewModel:JobAppViewModel
    
    let appMatches : [JobApplication] //applications that match company name from UpdateApplicationView
    
    var body: some View {
        VStack{
            Text("Which application to update?").bold()
            Text("(Cannot update accepted or rejected applications)")
                .foregroundColor(.gray)
            List(){
                ForEach(appMatches){ application in
                    NavigationLink(
                        destination: UpdateOptionsView(jobApp: application),
                        label: {ApplicationRowView(jobApplication: application)}
                    ).disabled(!viewModel.canUpdateJob(jobApp: application))
                }
                    
            }.listStyle(PlainListStyle())
        }
        
    }
}

struct UpdateOptionsView: View {
    @EnvironmentObject var viewModel:JobAppViewModel
    let jobApp : JobApplication
    let possibleStatus = ["Interview","Rejected","Accepted"]
    @State private var selectedUpdate : String = ""
    @State private var interviewNum = "1"
    @State private var interviewDate = Date(timeIntervalSince1970: 0)
    @State private var updateValid : Bool = false
    
    var body: some View {
        
        
        VStack(spacing: 20){
            SingleApplicationView(jobApplication: jobApp)
            
            //picker to choose what status to update application to
            //PICKER LABEL NOT SHOWING ANYMORE WHYYYY so put in menu
            Menu{
                Picker(selection: $selectedUpdate,
                       label:
                        HStack {
                            Text("Update to: \(selectedUpdate)")
                       }
                        .labelsHidden()
                )
                {
                    ForEach(possibleStatus.indices) { index in
                        Text(possibleStatus[index]).tag(possibleStatus[index])
                        }
                }
                .pickerStyle(.menu)
                }
            label:{
                HStack {
                    Text("Update to: \(selectedUpdate)")
               }
                .padding()
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: .blue.opacity(0.6), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
            }
            
            
            //if interview is picked give options of numbers
            Menu{
            Picker(selection: $interviewNum, label: Text("Interview Number: \(interviewNum) ")) {
                ForEach(1..<6) { num in
                        Text("\(num)").tag("\(num)")
                    }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            }
        label:{
            Text("Interview Number: \(interviewNum) ")
        }
        .disabled(selectedUpdate != "Interview")
        .padding()
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(selectedUpdate != "Interview" ? Color.white : Color.blue)
        .cornerRadius(10)
        .shadow(color: selectedUpdate != "Interview" ? Color.white : .blue.opacity(0.6), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
                
                //Date picker to set date of interview
            if selectedUpdate == "Interview"{
                DatePicker("Date of Interview:", selection: $interviewDate, in: Date()..., displayedComponents: .date)
                    .frame(maxWidth: 300)
            }
            
            Spacer()
            NavigationLink(destination: HomeView() , isActive: $updateValid){
                Button(action: {
                    if selectedUpdate != ""
                    {
                        if selectedUpdate=="Interview" {
                            viewModel.updateStatus(jobApp: jobApp, status: "\(selectedUpdate) \(interviewNum)", importantDate: interviewDate )
                            
                            //request authorization to send push notifications
                            NotificationManager.getInstance().requestAuthorization()
                            
                            //set notification to remind user about interview
                            NotificationManager.getInstance().scheduleNotification(interviewDate: interviewDate, jobApp: jobApp)
                        }
                        else{
                            viewModel.updateStatus(jobApp: jobApp, status: selectedUpdate)
                        }
                        updateValid = true
                    }
                }, label: {
                    Text("Submit")
                        .bold()
                        .frame(width: 200,
                               height: 25,
                               alignment: .center)
                        .padding()
                        .background(!isUpdateValid() ? Color(#colorLiteral(red: 0.6805589199, green: 0.6765155196, blue: 0.683668375, alpha: 1)): Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
            .disabled(!isUpdateValid())
            
        }
    }
    
    func newInterviewNum(num:String)->Int{
        guard let number = Int(num) else {
            return 1
        }
        return number
    }
    
    func isUpdateValid()->Bool{
        if  selectedUpdate=="Interview" && !viewModel.canUpdateToInterview(jobApp: jobApp, newNum: newInterviewNum(num: interviewNum )) {
            return false
        }
        return true
    }
}

struct updateStatusView_Previews: PreviewProvider {
    
    static var viewModel : JobAppViewModel = JobAppViewModel()
    
    static var jobApp = viewModel.createAppForTests(companyName: "Company1", jobTitle:"Assistant", dateApplied: Date())
    
    static var jobApp2 = viewModel.createAppForTests(companyName: "Company1", jobTitle:"Intern", dateApplied: Date())
    
    static var previews: some View {
        NavigationView{
            UpdateStatusView(appMatches: [jobApp,jobApp2])
        }
        .environmentObject(JobAppViewModel())
    }
}
