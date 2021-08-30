//
//  Command.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/26/21.
//

import Foundation

protocol Command {
    
    //functions used to get sort descriptors or filters for JobApplications
    var title : String {get}
    
    func getPredicate () -> NSPredicate?
    func getSortDescriptors() -> [NSSortDescriptor]
    
    
}
protocol FilterCommand : Command{
    
}

protocol Descriptor : Command {
    
}

//use command objects to filter job applications
class FavouriteFilter : FilterCommand {
    
    var title: String = "Favourites"
    
    //creates predicate on which to filter applications
    func getPredicate() -> NSPredicate? {
        return NSPredicate(format: "isFavourite == %@", kCFBooleanTrue as! CVarArg)
    }
    
    func getSortDescriptors() -> [NSSortDescriptor] {
        return []
    }
    
}

class NoneCommand : Command {
    
    var title: String = "None"
    
    //creates predicate on which to filter applications
    func getPredicate() -> NSPredicate? {
        return nil
    }
    
    func getSortDescriptors() -> [NSSortDescriptor] {
        return []
    }
    
    
}

class AppliedFilter:FilterCommand{
    var title: String = "Applied"
    
    func getPredicate() -> NSPredicate? {
        return NSPredicate(format: "status == %@", "Applied")
    }
    
    func getSortDescriptors() -> [NSSortDescriptor] {
        return []
    }
    
    
}

class InterviewFilter:FilterCommand{
    var title: String = "Interview"
    
    func getPredicate() -> NSPredicate? {
        return NSPredicate(format: "status CONTAINS %@", "Interview")
    }
    
    func getSortDescriptors() -> [NSSortDescriptor] {
        return []
    }
    
}

class AcceptedFilter:FilterCommand{
    var title: String = "Accepted"
    
    func getPredicate() -> NSPredicate? {
        return NSPredicate(format: "status == %@", "Accepted")
    }
    
    func getSortDescriptors() -> [NSSortDescriptor] {
        return []
    }
    
}

class RejectedFilter:FilterCommand{
    var title: String = "Rejected"
    
    func getPredicate() -> NSPredicate? {
        return NSPredicate(format: "status == %@", "Rejected")
    }
    
    func getSortDescriptors() -> [NSSortDescriptor] {
        return []
    }
    
}

class AscendDate:Descriptor{
    var title: String = "Date Applied ↑"
    
    func getPredicate() -> NSPredicate? {
        return nil
    }
    
    func getSortDescriptors() -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \JobApplication.dateApplied, ascending: true)
        return [sort]
    }
    
    
}

class DescendDate:Descriptor{
    var title: String = "Date Applied ↓"
    
    func getPredicate() -> NSPredicate? {
        return nil
    }
    
    func getSortDescriptors() -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \JobApplication.dateApplied, ascending: false)
        return [sort]
    }
    
    
}
