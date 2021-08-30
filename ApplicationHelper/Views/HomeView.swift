//
//  ContentView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/16/21.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
                VStack{
                //3 nav links for different screens
                    
                    NavigationLink(destination: AddApplicationView(),
                                   label: {
                                    HomeScreenButtonView(str:"Add Application", borderColor: Color.purple)
                                   })
                     
                    NavigationLink(destination: UpdateApplicationView(),
                                   label: {
                                    HomeScreenButtonView(str:"Update Application", borderColor: Color.blue)
                                   })
                    Spacer()
                }
                .navigationBarItems(trailing: NavigationLink("Applications",destination: AllApplicationsView()))
                .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}
