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
                .border(borderColor, width: 3)
                .foregroundColor(.black)
        Spacer()
        }

    }
}

struct HomeScreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenButtonView(str: "Add Job App",borderColor: Color.purple)
    }
}
