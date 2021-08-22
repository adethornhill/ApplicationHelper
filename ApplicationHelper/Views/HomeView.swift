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
                    Spacer()
                    NavigationLink(destination: AddApplicationView(),
                                   label: {
                                    HomeScreenButtonView(str:"Add Application", borderColor: Color.purple)
                                   })
                     
                    NavigationLink(destination: EmptyView(),
                                   label: {
                                    HomeScreenButtonView(str:"Update Application", borderColor: Color.blue)
                                   })
                
                    NavigationLink(destination: EmptyView(),
                                   label: {
                                    HomeScreenButtonView(str:"Delete Application", borderColor: Color.green)
                                   })
                }
                .navigationBarItems(trailing: NavigationLink("Applications",destination: AllApplicationsView()))
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}
