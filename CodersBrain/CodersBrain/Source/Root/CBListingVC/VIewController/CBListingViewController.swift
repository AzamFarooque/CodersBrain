//
//  CBListingViewController.swift
//  CodersBrain
//
//  Created by Happlabs Software LLP MAC1 on 27/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import CoreData

class CBListingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CBDelegate {
    
    let coreDataUtility = CBCoreDataUtilityFile()
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var listTableView: UITableView!
    var listArray : NSArray!
    var navController : UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        headerView.addShadow()
        fetchList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.value(forKey: "id") != nil{
            nameLabel.isHidden = false
            logoutButton.isHidden = false
            logoutLabel.isHidden = false
            let name = UserDefaults.standard.value(forKey: "name")
            nameLabel.text = name! as? String
        }
        else{
            nameLabel.isHidden = true
            logoutButton.isHidden = true
            logoutLabel.isHidden = true
        }
    }
    
        func presentLoginController(){
            let storyboard = UIStoryboard(storyboard: .Main)
            let subsectionVC : CBLoginViewController = storyboard.instantiateViewController()
            navController = UINavigationController(rootViewController: subsectionVC)
            navController.isNavigationBarHidden = true
            self.present(navController, animated:true, completion: nil)
        }
    
    // Pragma Mark :- Fetch Stories
    
    func fetchList(){
        CBUserServices.fetchStoriesList(){ (responseObject:NSArray?, error:NSError?,total) in
            if ((error) != nil) {
                print("Error logging you in!")
            } else {
                
                self.listArray = responseObject
                self.listTableView.reloadData()
        
      }
    }
}
    
    // Pragma MARK : TableView Delegates
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  listArray.count == 0 ? 0 : listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CBListingTableViewCell", for: indexPath as IndexPath) as! CBListingTableViewCell
        
        let section:CBListingModel = listArray[indexPath.row] as! CBListingModel
        cell.update(model : section , buttonTag : indexPath.row)
        cell.delegate = self
        cell.savedButton.tag = indexPath.row
        cell.ListArray = listArray as! [CBListingModel]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(storyboard: .listingDetail)
        let detailViewController : CBListingDetailViewController = storyboard.instantiateViewController()
        detailViewController.listModel = listArray[indexPath.row] as! CBListingModel
        self.navigationController?.present(detailViewController, animated: true)
    }
    
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
         confirmLogout()
    }
    
    func confirmLogout(){
        let alertController: UIAlertController = UIAlertController(title: "CodersBrain", message:"Are you sure you want to logout", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.logout()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: "id")
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        logoutButton.isHidden = true
        nameLabel.isHidden = true
        logoutLabel.isHidden = true
        coreDataUtility.deleteFavouritedChannelList()
        fetchList()
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}
