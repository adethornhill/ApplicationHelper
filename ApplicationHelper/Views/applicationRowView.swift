//
//  applicationRowView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/20/21.
//

import SwiftUI

struct ApplicationRowView: View {
    
    
    let jobApplication : JobApplication
    @EnvironmentObject var viewModel : JobAppViewModel
    
    
    var body: some View {
                LazyHStack(spacing: 18){
                    Text(jobApplication.company ?? "Default Company")
                        .frame(width: 75, height:20.3, alignment: .leading)
                        .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)

                    Text(jobApplication.title ?? "Default title")
                        .frame(width: 75, height:20.3, alignment: .leading)
                        .truncationMode(.tail)

                    Text(jobApplication.status ?? "Default status")
                        .frame(width: 75, height:20.3, alignment: .leading)
                        .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)

                    Text(viewModel.getDateString(date: jobApplication.dateApplied ?? Date()))
                        .frame(width: 75, height:20.3, alignment: .leading)
                        .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                }
                .padding(.leading, 3)
                .background(viewModel.getRowColor(jobApplication:jobApplication))
                .cornerRadius(6)
                .foregroundColor(.black)
    }
    
    
}

struct applicationRowView_Previews: PreviewProvider {
    
    
    static var viewModel : JobAppViewModel = JobAppViewModel()
    
    static var jobApp = viewModel.createAppForTests(companyName: "Company1", jobTitle:"bossman", dateApplied: Date())
    
    static var previews: some View {
        ApplicationRowView(jobApplication: jobApp)
            .environmentObject(JobAppViewModel())
    }
    
}
