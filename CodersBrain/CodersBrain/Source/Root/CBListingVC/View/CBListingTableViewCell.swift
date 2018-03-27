//
//  CBListingTableViewCell.swift
//  CodersBrain
//
//  Created by Happlabs Software LLP MAC1 on 27/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import UIKit
import CoreData

protocol CBDelegate : class {
    func presentLoginController()
}

class CBListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    weak var delegate : CBDelegate?
    var ListArray :  [CBListingModel] = []
    var saveListArray: [NSManagedObject] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cntView.applyRoundCorner(radius: 10, borderWidth: 0, borderColor: nil)
        cntView.addShadow()
    }
    
    
    func update(model : CBListingModel , buttonTag : Int){
        fetchFavouritedChannelList()
        if saveListArray.count == 0{
            savedButton.setImage(UIImage(named: "unsavedIcon"), for: UIControlState.normal)
        }
        checkForFavourite(model : model)
    }
    
    
    // Pragma MARK : Check For Favourite
    
    func checkForFavourite(model : CBListingModel){
        if saveListArray.count > 0 {
            for index in 0...saveListArray.count-1 {
                let favouritedSection = saveListArray[index]
                let channelTittle = favouritedSection.value(forKeyPath: "name") as? String
                
                if (channelTittle == model.name){
                    savedButton.setImage(UIImage(named: "saveIcon"), for: UIControlState.normal)
                    break
                }
                else{
                    savedButton.setImage(UIImage(named: "unsavedIcon"), for: UIControlState.normal)
                }
            }
        }
    }
    
    @IBAction func didTapToSave(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: "id") != nil{
            if (sender as AnyObject).currentImage!.isEqual(UIImage(named: "unsavedIcon")){
                saveChannelList(model: ListArray[sender.tag] , Index: sender.tag)
                (sender as AnyObject).setImage(UIImage(named: "saveIcon"), for: UIControlState.normal)
            }
            else{
                removeChannelList(model: ListArray[sender.tag])
                (sender as AnyObject).setImage(UIImage(named: "unsavedIcon"), for: UIControlState.normal)
            }
        }
        else{
            delegate?.presentLoginController()
        }
    }
    
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
        listInfo.setValue(model.name!, forKeyPath: "name")
        listInfo.setValue(model.images!, forKeyPath: "images")
        listInfo.setValue(Index, forKey: "index")
        do {
            try managedContext.save()
            saveListArray.append(listInfo)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    // Pragma MARK : Fetching Favourited Channel List
    
    func fetchFavouritedChannelList(){
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
    
    func removeChannelList(model : CBListingModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        for index in 0...saveListArray.count-1 {
            let favouritedSection = saveListArray[index]
            let name = favouritedSection.value(forKeyPath: "name") as? String
            if (name == model.name!) {
                
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
