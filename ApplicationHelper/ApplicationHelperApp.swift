//
//  ApplicationHelperApp.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/16/21.
//

import SwiftUI

@main
struct ApplicationHelperApp: App {
    
    @StateObject var jobAppViewModel : JobAppViewModel = JobAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
            }
            .environmentObject(jobAppViewModel)
        }
    }
}
