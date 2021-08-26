//
//  Command.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/26/21.
//

import Foundation

protocol FilterCommand{
    var title : String {get}
    
    //function used to either sort or filter JobApplications
    func createPredicate() -> NSPredicate?
    
}

//use command objects to filter job applications
class FavouriteFilter : FilterCommand {
    
    var title: String = "Favourites"
    
    //creates predicate on which to filter applications
    func createPredicate() -> NSPredicate? {
        return NSPredicate(format: "isFavourite == %@", kCFBooleanTrue as! CVarArg)
    }
    
    
}

class NoneFilter : FilterCommand {
    
    var title: String = "None"
    
    //creates predicate on which to filter applications
    func createPredicate() -> NSPredicate? {
        return nil
    }
    
    
}
