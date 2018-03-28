//
//  CBListingDetailViewController.swift
//  CodersBrain
//
//  Created by Farooque on 28/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import UIKit

class CBListingDetailViewController: UIViewController {
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    var listModel : CBListingModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()
        imgView.image =  UIImage(named :listModel.images!)
        detailLabel.text = listModel.newsDetail!
    }

    @IBAction func didTapBackButton(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}
