//
//  CBSaveListViewController.swift
//  CodersBrain
//
//  Created by Happlabs Software LLP MAC1 on 27/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import UIKit
import CoreData

class CBSaveListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let coreDataUtility = CBCoreDataUtilityFile()
    var saveListArray: [NSManagedObject] = []
    @IBOutlet weak var saveTableList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        coreDataUtility.fetchSavelList()
        saveListArray = coreDataUtility.saveListArray
        saveTableList.reloadData()
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
        return  saveListArray.count == 0 ? 0 : saveListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CBSaveListTableViewCell", for: indexPath as IndexPath) as! CBSaveListTableViewCell
        
        let Section = saveListArray[indexPath.row]
        cell.imgView.applyRoundCorner(radius: 40, borderWidth: 1, borderColor: UIColor.red)
        cell.imgView.clipsToBounds = true
        cell.imgView?.image = UIImage(named : (Section.value(forKeyPath: "images") as? String)!)
        cell.nameLabel.text = Section.value(forKeyPath: "news") as? String
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
 
}
