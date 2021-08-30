//
//  updateStatusView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/26/21.
//

import SwiftUI

struct UpdateStatusView: View {
    
    let appMatches : [JobApplication] //applications that match company name from UpdateApplicationView
    
    var body: some View {
        VStack{
            Text("Which application to update?").bold()
            List(){
                ForEach(appMatches){ application in
                    NavigationLink(
                        destination: UpdateOptionsView(jobApp: application),
                        label: {ApplicationRowView(jobApplication: application)}
                    )
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
            
            Picker(selection: $selectedUpdate,
                   label:
                    HStack {
                        Text("Update to: \(selectedUpdate)")
                   }
                    .padding()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: .blue.opacity(0.6), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
            )
            {
                ForEach(possibleStatus.indices) { index in
                    Text(possibleStatus[index]).tag(possibleStatus[index])
                    }
            }
            .pickerStyle(MenuPickerStyle())
            
            //if interview is picked give options of numbers
            
            Picker(selection: $interviewNum, label: Text("Interview Number: \(interviewNum) ")) {
                ForEach(1..<6) { num in
                        Text("\(num)").tag("\(num)")
                    }
            }
            .pickerStyle(MenuPickerStyle())
            .disabled(selectedUpdate != "Interview")
            .padding()
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(selectedUpdate != "Interview" ? Color.white : Color.blue)
            .cornerRadius(10)
            .shadow(color: selectedUpdate != "Interview" ? Color.white : .blue.opacity(0.6), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
                
                //Date picker to set date of interview
                DatePicker("Date of Interview:", selection: $interviewDate, in: Date()..., displayedComponents: .date)
                    .disabled(selectedUpdate != "Interview")
                    .foregroundColor(selectedUpdate != "Interview" ? Color.white : Color.black)
                    .accentColor(selectedUpdate != "Interview" ? Color.white : Color.blue)
                    .frame(maxWidth: 300)
            
            Spacer()
            NavigationLink(destination: HomeView() , isActive: $updateValid){
                Button(action: {
                    if selectedUpdate != ""
                    {
                        selectedUpdate=="Interview" ?
                            viewModel.updateStatus(jobApp: jobApp, status: "\(selectedUpdate)  \(interviewNum)", importantDate: interviewDate ) : viewModel.updateStatus(jobApp: jobApp, status: selectedUpdate)
                        updateValid = true
                    }
                }, label: {
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
            
        }
    }
    
    //IMPLEMENT LATER
    //Make func to give alert cannot update an accepted or rejected application
    //or cannot update from interview 3 to 1
//    func isUpdateValid(){
//        if
//    }
}

struct updateStatusView_Previews: PreviewProvider {
    
    static var viewModel : JobAppViewModel = JobAppViewModel()
    
    static var jobApp = viewModel.createAppForTests(companyName: "ManuLife", jobTitle:"Assistant", dateApplied: Date())
    
    static var jobApp2 = viewModel.createAppForTests(companyName: "ManuLife", jobTitle:"Intern", dateApplied: Date())
    
    static var previews: some View {
        NavigationView{
            UpdateStatusView(appMatches: [jobApp,jobApp2])
        }
        .environmentObject(JobAppViewModel())
    }
}
