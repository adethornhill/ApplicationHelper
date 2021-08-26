//
//  allApplicationsView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/20/21.
//

import SwiftUI

struct AllApplicationsView: View {
    
    @EnvironmentObject var jobAppViewModel : JobAppViewModel
    
    var body: some View {
        VStack{
            FilterDropDownView(title: "Filter", items: jobAppViewModel.filters)
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
                    ApplicationRowView(jobApplication: application)                }
            }
            .offset(x: -10)
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Applications")
                

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
