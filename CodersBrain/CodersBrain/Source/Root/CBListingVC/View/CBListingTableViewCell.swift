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
    let coreDataUtility = CBCoreDataUtilityFile()
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    weak var delegate : CBDelegate?
    var ListArray :  [CBListingModel] = []
    var saveListArray: [NSManagedObject] = []
    
    @IBOutlet weak var saveOrRemoveLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.applyRoundCorner(radius: 40, borderWidth: 1, borderColor: UIColor.red)
        imgView.clipsToBounds = true
        cntView.applyRoundCorner(radius: 10, borderWidth: 0, borderColor: nil)
        cntView.addShadow()
    }
    
    
    func update(model : CBListingModel , buttonTag : Int){
        coreDataUtility.fetchSavelList()
        saveListArray = coreDataUtility.saveListArray
        if let news = model.news{
        nameLabel.text = news
        }
        if let img = model.images{
        imgView.image =  UIImage(named :img)
        }
        if saveListArray.count == 0{
            saveOrRemoveLabel.text = "Tap To Save Article."
            savedButton.setImage(UIImage(named: "unsavedIcon"), for: UIControlState.normal)
        }
        checkForSave(model : model)
    }
    
    
    // Pragma MARK : Check For Favourite
    
    func checkForSave(model : CBListingModel){
        if saveListArray.count > 0 {
            for index in 0...saveListArray.count-1 {
                let favouritedSection = saveListArray[index]
                let channelTittle = favouritedSection.value(forKeyPath: "news") as? String
                if (channelTittle == model.news){
                    saveOrRemoveLabel.text = "Tap To Remove Article."
                    savedButton.setImage(UIImage(named: "saveIcon"), for: UIControlState.normal)
                    break
                }
                else{
                    saveOrRemoveLabel.text = "Tap To Save Article."
                    savedButton.setImage(UIImage(named: "unsavedIcon"), for: UIControlState.normal)
                }
            }
        }
    }
    
    @IBAction func didTapToSave(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: "id") != nil{
            if (sender as AnyObject).currentImage!.isEqual(UIImage(named: "unsavedIcon")){
                coreDataUtility.saveChannelList(model: ListArray[sender.tag] , Index: sender.tag)
                saveOrRemoveLabel.text = "Tap To Remove Article."
                (sender as AnyObject).setImage(UIImage(named: "saveIcon"), for: UIControlState.normal)
            }
            else{
                coreDataUtility.removeSavelList(model: ListArray[sender.tag])
                saveOrRemoveLabel.text = "Tap To Save Article."
                (sender as AnyObject).setImage(UIImage(named: "unsavedIcon"), for: UIControlState.normal)
            }
        }
        else{
            delegate?.presentLoginController()
        }
    }
}
