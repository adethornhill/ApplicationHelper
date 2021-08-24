//
//  singleApplicationView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/23/21.
//

import SwiftUI

struct SingleApplicationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let jobApplication : JobApplication
    @EnvironmentObject var viewModel : JobAppViewModel
    @State var showAlert : Bool = false
    
    var body: some View {
        VStack{
            
            Text(jobApplication.company ?? "name").bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.singleViewTopColor(jobApplication: jobApplication))
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 35)
            
            Group{
                
            HStack{
            Text("Job Title:").bold()
            Text(jobApplication.title ?? "name")
            }
            Spacer()
                .frame(height: 15)
                
            HStack{
            Text("Date Applied:").bold()
            Text(
                viewModel.getDateString(date: jobApplication.dateApplied ?? Date() )
            )
            }
            Spacer()
                .frame(height: 15)
                    
            HStack{
            Text("Status:").bold()
            Text(jobApplication.status ?? "name")
                }
            
            Spacer()
                .frame(height: 15)
            
            HStack{
            Text("Upcoming Date:").bold()
            Text(viewModel.getImportantDate(jobApplication: jobApplication))
                    }
            }
            
            Spacer()
                .frame(maxHeight: 130)
            
            Button(action: {showAlert=true} , label: {
                Text("Delete")
                    .bold()
                    .padding(6)
                    .frame(maxWidth: 150)
                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .foregroundColor(.red)
                    .cornerRadius(10)
            })
            
            Spacer()
                .frame(maxHeight: 20)
            
        }
            .frame(width: 320, height: 400)
            .background(viewModel.getRowColor(jobApplication: jobApplication))
        .border(Color.gray,width: 4)
        .font(.system(size: 22))
        .alert(isPresented: $showAlert, content: getAlert)
        
    }
    
    func getAlert()->Alert{
        return Alert(title: Text("Are you sure you want to delete this application?"), primaryButton: .default(Text("No")), secondaryButton: .default(Text("Yes I'm sure"),
                    action:{
                        viewModel.deleteApplication(jobApp: jobApplication)
                        
                        //go back 1 view in view hiearchy
                        presentationMode.wrappedValue.dismiss()
                    })
        )
    }
}



struct singleApplicationView_Previews: PreviewProvider {
    static var viewModel : JobAppViewModel = JobAppViewModel()
    
    static var jobApp = viewModel.createAppForTests(companyName: "ManuLife", jobTitle:"bossman", dateApplied: Date())
    
    static var previews: some View {
        SingleApplicationView(jobApplication: jobApp)
            .environmentObject(JobAppViewModel())
    }
}
