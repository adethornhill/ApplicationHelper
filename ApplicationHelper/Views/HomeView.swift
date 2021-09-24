//
//  ContentView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/16/21.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack{
           Color(#colorLiteral(red: 0.9894165397, green: 0.9216066003, blue: 0.8180939555, alpha: 1))
                .edgesIgnoringSafeArea(.all)
         
        VStack(spacing : 100){
                //3 nav links for different screens
            Spacer()
                .frame(height:20)
                    NavigationLink(destination: AddApplicationView(),
                                   label: {
                                    HomeScreenButtonView(str:"Add Application", borderColor: Color.purple)
                                   })
                     
                    NavigationLink(destination: UpdateApplicationView(),
                                   label: {
                                    HomeScreenButtonView(str:"Update Application", borderColor: Color.blue)
                                   })
                    Spacer()
                    //TEST notifications are being scheduled correctly DELETE!!
//                    Button("Print pending notifications"){
//                        print("The following are the pending notification requests: ")
//                        let center = UNUserNotificationCenter.current()
//                        center.getPendingNotificationRequests(completionHandler: { requests in
//                            for request in requests {
//                                print(request.content.subtitle)
//                            }
//                        })
//                    }
                }
                .navigationBarItems(trailing: NavigationLink("Applications",destination: AllApplicationsView()))
                .navigationBarBackButtonHidden(true)
    }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}
