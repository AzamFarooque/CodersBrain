//
//  CBListingViewController.swift
//  CodersBrain
//
//  Created by Happlabs Software LLP MAC1 on 27/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import UIKit

class CBListingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CBDelegate {
    
    @IBOutlet weak var listTableView: UITableView!
    var listArray : NSArray!
    var navController : UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "codersBrain")
        imageView.image = image
        navigationItem.titleView = imageView
        fetchList()
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
        cell.imageView?.applyRoundCorner(radius: 50, borderWidth: 0, borderColor: nil)
        cell.imgView?.image = UIImage(named : section.images!)
        cell.imageView?.clipsToBounds = true
        cell.delegate = self as? CBDelegate
        cell.savedButton.tag = indexPath.row
        cell.ListArray = listArray as! [CBListingModel]
        cell.nameLabel.text = section.name!
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}
