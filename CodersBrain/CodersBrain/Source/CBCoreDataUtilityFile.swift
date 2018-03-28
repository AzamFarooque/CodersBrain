//
//  CBCoreDataUtilityFile.swift
//  CodersBrain
//
//  Created by Farooque on 27/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CBCoreDataUtilityFile: NSObject {
    
      var saveListArray: [NSManagedObject] = []
    
    // Pragma MARK : Save Channel List in Core Data
    
    func saveChannelList(model : CBListingModel , Index : Int ){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "CBSavedList",
                                       in: managedContext)!
        let listInfo = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
        listInfo.setValue(model.news!, forKeyPath: "news")
        listInfo.setValue(model.images!, forKeyPath: "images")
        listInfo.setValue(model.newsDetail, forKey: "newsDetail")
        listInfo.setValue(Index, forKey: "index")
        do {
            try managedContext.save()
            saveListArray.append(listInfo)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    // Pragma MARK : Fetching Favourited Channel List
    
    func fetchSavelList(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "CBSavedList")
        do {
            saveListArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // Pragma MARK : Remove Favourited Channel List
    
    func removeSavelList(model : CBListingModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        for index in 0...saveListArray.count-1 {
            let favouritedSection = saveListArray[index]
            let news = favouritedSection.value(forKeyPath: "news") as? String
            if (news == model.news!) {
                
                let managedContext =
                    appDelegate.persistentContainer.viewContext
                managedContext.delete(saveListArray[index])
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                    
                }
            }
        }
    }
    
    
    func deleteFavouritedChannelList(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CBSavedList")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    
    
}
