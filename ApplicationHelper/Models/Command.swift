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
