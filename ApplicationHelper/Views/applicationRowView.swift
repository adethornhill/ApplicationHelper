//
//  applicationRowView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/20/21.
//

import SwiftUI

struct ApplicationRowView: View {
    
    let jobApplication : JobApplication
    
    var body: some View {
        HStack(spacing: 18){
            Text(jobApplication.getCompany())
                .frame(width: 75, height:20.3, alignment: .leading)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)

            Text(jobApplication.getTitle())
                .frame(width: 75, height:20.3, alignment: .leading)
                .truncationMode(.tail)

            Text(jobApplication.getStatus())
                .frame(width: 75, height:20.3, alignment: .leading)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)

            Text(jobApplication.getApplyDate())
                .frame(width: 75, height:20.3, alignment: .leading)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
        }
        .padding(.leading, 3)
        .background(getRowColor())
        .cornerRadius(6)
        
    }
    
    func getRowColor()->Color{
        if jobApplication.aStatus == "Rejected"{
            return Color(#colorLiteral(red: 0.8569247723, green: 0.173017025, blue: 0.08323720843, alpha: 0.2768476837))
        }
        else if jobApplication.aStatus == "Accepted"{
            return Color(#colorLiteral(red: 0, green: 0.7583040595, blue: 0, alpha: 0.1535992266))
        }
        return Color(#colorLiteral(red: 0, green: 0.343914181, blue: 0.928293407, alpha: 0.2785940365))
    }
}

struct applicationRowView_Previews: PreviewProvider {
    static let jobApp = JobApplication(company: "Microsoft", title: "SE Intern", dateApplied: Date())
    
    
    
    static var previews: some View {
        ApplicationRowView(jobApplication: jobApp)
    }
}
