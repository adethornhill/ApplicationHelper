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

            Text(viewModel.getApplyDate(date: jobApplication.dateApplied ?? Date()))
                .frame(width: 75, height:20.3, alignment: .leading)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
        }
        .padding(.leading, 3)
        .background(getRowColor())
        .cornerRadius(6)
        
    }
    
    func getRowColor()->Color{
        if jobApplication.status == "Rejected"{
            return Color(#colorLiteral(red: 0.8569247723, green: 0.173017025, blue: 0.08323720843, alpha: 0.2768476837))
        }
        else if jobApplication.status == "Accepted"{
            return Color(#colorLiteral(red: 0, green: 0.7583040595, blue: 0, alpha: 0.1535992266))
        }
        return Color(#colorLiteral(red: 0, green: 0.343914181, blue: 0.928293407, alpha: 0.2785940365))
    }
}

struct applicationRowView_Previews: PreviewProvider {
    static var jobApp = JobApplication()
    
    
    static var previews: some View {
        ApplicationRowView(jobApplication: jobApp)
            .environmentObject(JobAppViewModel())
    }
    
}
