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
   // @State var showAlert:Bool = false
    var body: some View {
        VStack{
            //create form for adding a job application
            Text("For which company do you want to update the application status?")
                .bold()
                .font(.system(size: 20))
                .padding()
                
                
            Form{
                Section(footer: Text("Next button only appears if input matches a company name in database")){
                    TextField("Company Name", text: $companyName)
                    
                }
            }
            NavigationLink(
                destination: UpdateStatusView(appMatches: viewModel.searchAppByName(compName: companyName)),
                label: {
                            Text("Next")
                                .bold()
                                .frame(width: 200,
                                       height: 25,
                                       alignment: .center)
                                .padding()
                                .background(!doesAppExist() ? Color.white : Color.blue)
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
