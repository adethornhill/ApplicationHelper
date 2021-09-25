//
//  UpdateApplicationView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/26/21.
//

import SwiftUI

struct UpdateApplicationView: View {
    @EnvironmentObject var viewModel:JobAppViewModel
    @State private var companyName : String = ""
    @State private var alertTitle:String=""
    var body: some View {
        VStack{
            //create form for adding a job application
            Text("For which company do you want to update the application status?")
                .bold()
                .font(.system(size: 20))
                .padding()
                
                
            Form{
                Section(footer: Text("Continue button only works if input matches a company name in database")){
                    TextField("Company Name", text: $companyName)
                    
                }
            }
            NavigationLink(
                destination: UpdateStatusView(appMatches: viewModel.searchAppByName(compName: companyName)),
                label: {
                            Text("Continue")
                                .bold()
                                .frame(width: 200,
                                       height: 25,
                                       alignment: .center)
                                .padding()
                                .background(!doesAppExist() ? Color(#colorLiteral(red: 0.6805589199, green: 0.6765155196, blue: 0.683668375, alpha: 1)): Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                }).disabled(!doesAppExist())
            
        }
        
    }
    
    
    //function that returns if application for company exists
    func doesAppExist()->Bool{
        if viewModel.searchAppByName(compName: companyName).count == 0 {
            return false
        }
        return true
    }
}

struct UpdateApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            UpdateApplicationView()
        }
        .environmentObject(JobAppViewModel())
    }
}
