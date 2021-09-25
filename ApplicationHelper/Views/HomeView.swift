//
//  ContentView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/16/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            
        VStack(spacing : 100){
            
            Text("Track your applications  📈")
                .font(.system(size: 20))
                .bold()
                    NavigationLink(destination: AddApplicationView(),
                                   label: {
                                    HomeScreenButtonView(str:"Add Application", borderColor: Color.purple)
                                   })
                     
                    NavigationLink(destination: UpdateApplicationView(),
                                   label: {
                                    HomeScreenButtonView(str:"Update Application", borderColor: Color.purple)
                                   })
                    Spacer()
                }
        . navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink(destination: AllApplicationsView()){
                    Label("Applications", systemImage: "folder")
                }
            }
        }
        .accentColor(.purple)
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}
