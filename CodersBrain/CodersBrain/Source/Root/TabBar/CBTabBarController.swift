//
//  SurgeSendMainTabBarController.swift
//  SurgeSend
//
//  Created by Happlabs Software LLP MAC1 on 15/03/18.
//  Copyright © 2018 Happlabs Software LLP. All rights reserved.
//

import UIKit

class CBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font : UIFont(name: "Avenir-Book", size: 11) as Any], for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font : UIFont(name: "Avenir-Book", size: 11) as Any], for: .selected)
    self.tabBar.barTintColor =  UIColor(red: 45/255, green: 134/255, blue: 25/255, alpha: 1)
        UITabBar.appearance().tintColor = UIColor.white
        if #available(iOS 10.0, *) {
            UITabBar.appearance().unselectedItemTintColor = UIColor.white
        } else {
        }
    }
}

