//
//  NotificationManager.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 9/20/21.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationManager {
    private static let instance = NotificationManager() //singleton
    
    private init(){
        
    }
    
    static func getInstance()->NotificationManager{
        
        return NotificationManager.instance
    }
    func requestAuthorization(){
        let options : UNAuthorizationOptions = [.alert , .sound ]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error ) in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    //takes in jobapplication and date of interview and schedules appropriate reminder
    func scheduleNotification(interviewDate: Date , jobApp:JobApplication){
        let reminderDate : Date? = calcReminderDate(interviewDate: interviewDate)
        
        if let reminderDate = reminderDate {
            
            //Calculate how far interview is from reminder date
            var timeRemaining: String
            if reminderDate == Calendar.current.date(byAdding: .day, value: -7, to: interviewDate){
                timeRemaining = "in a week"
                    
            }
            else if reminderDate == Calendar.current.date(byAdding: .day, value: -3, to: interviewDate){
                timeRemaining = "in 3 days"
            }
            else{
                timeRemaining = "tomorrow"
            }
            
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: reminderDate)
            dateComponents.hour = 12
            dateComponents.minute = 30
            
            let content = UNMutableNotificationContent()
            content.title = "Upcoming Interview!!⏰"
            content.subtitle = "\(jobApp.status ?? "Nil Status") for \(jobApp.company ?? "Nil Company") \(timeRemaining), make sure to prepare📝"
            content.sound = .default
            
            removeAppNoti(jobApp: jobApp) //remove old pending notification if updating
            
            let notificationID = UUID() //keep track of notification
            jobApp.reminderID = notificationID //set notification ID to jobApp.reminderID
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(
                identifier: notificationID.uuidString,
                content: content,
                trigger: trigger )
            
            UNUserNotificationCenter.current().add(request)
        }
        //else dont make reminder
    
        
    }
    
    //calculate and return date to to set reminder for job interview
    func calcReminderDate(interviewDate: Date)->Date?{
        var reminderDate : Date?
        let now=Date()
        
        
        
        //if interview date already passed return
        if now > interviewDate{
            return reminderDate
        }
        // if interview > week away set reminder for a week before
        let weekLater = Calendar.current.date(byAdding: .day, value: 7, to: now)
        let daysLater3 = Calendar.current.date(byAdding: .day, value: 3, to: now)
        let dayLater = Calendar.current.date(byAdding: .day, value: 1, to: now)
            
        //calender.current.date() returns type date?
            
        if interviewDate > weekLater!{
            reminderDate = Calendar.current.date(byAdding: .day, value: -7, to: interviewDate)

                
        }
        //if interview date is less than a week away set reminder for 3 days before
        else if interviewDate > daysLater3!{
            reminderDate = Calendar.current.date(byAdding: .day, value: -3, to: interviewDate)
        }
        else if interviewDate > dayLater!{
            reminderDate = Calendar.current.date(byAdding: .day, value: -1, to: interviewDate)
        }
        
        return reminderDate
    }
    
    //removes pending notification connected to specific application
    func removeAppNoti(jobApp:JobApplication){
        if let reminderID = jobApp.reminderID {
            let center = UNUserNotificationCenter.current()
            //stops notification from happening if not happened already
            center.removePendingNotificationRequests(withIdentifiers: [reminderID.uuidString])
            jobApp.reminderID = nil
        }
        //else if reminderID = Nil then no reminder pending
        
    }
}
