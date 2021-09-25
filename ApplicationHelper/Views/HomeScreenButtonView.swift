//
//  HomeScreenButtonView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/16/21.
//

import SwiftUI

//buttons on homescreen are navigation links
struct HomeScreenButtonView: View {
    let str: String
    let borderColor: Color
    var body: some View {
        VStack{
            Text(str) //text on button
                .font(.body)
                .bold()
                .padding()
                .frame(maxWidth: 185)
                .border(borderColor, width: 3)
                .foregroundColor(.black)
                .shadow(color: borderColor.opacity(0.4), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
                
        //Spacer()
        }

    }
}

struct HomeScreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenButtonView(str: "Update Application",borderColor: Color.purple)
    }
}
