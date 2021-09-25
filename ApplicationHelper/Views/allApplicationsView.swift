//
//  allApplicationsView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/20/21.
//

import SwiftUI

struct AllApplicationsView: View {
    
    @EnvironmentObject var jobAppViewModel : JobAppViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            HStack(spacing: 5){
                DropDownView(title: "Filter", items: jobAppViewModel.filters)
                DropDownView(title: "Sort", items: jobAppViewModel.descriptors)
            }
            
            HStack(spacing: 10){
                Text("Company")
                    .bold()
                    .frame(width:77)
                    
                Divider()
                    .frame(height:20)
                
                Text("Job Title")
                    .bold()
                    .frame(width:77)
                
                Divider()
                    .frame(height:20)
                
                Text("Status")
                    .bold()
                    .frame(width:77)
                
                Divider()
                    .frame(height:20)
                
                Text("Date Applied")
                    .bold()
                    .frame(width:77)
            }
            Divider()
            
            List(){
                ForEach(jobAppViewModel.applications){ application in
                    NavigationLink(
                        destination: SingleApplicationView(jobApplication: application) ,
                        label : {
                            ApplicationRowView(jobApplication: application)
                            } )
                                 }
            }
            .offset(x: -10)
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle("Applications")
        . navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Label("Home page", systemImage: "house.fill")
                }

            }
        }
        .accentColor(.black)
                

    }
}

struct allApplicationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AllApplicationsView()
                .preferredColorScheme(.light)
                .padding()
        }
        .environmentObject(JobAppViewModel())
    }
}
