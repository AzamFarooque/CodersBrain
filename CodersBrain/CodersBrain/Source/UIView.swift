//
//  UIView.swift
//  SurgeSend
//
//  Created by Happlabs Software LLP MAC1 on 13/02/18.
//  Copyright © 2018 Happlabs Software LLP. All rights reserved.
//

import UIKit

extension UIView {
    
  
    
    func applyRoundCorner(radius : Float, borderWidth : Float, borderColor : UIColor?) {
        self.layer.masksToBounds = true
        if borderWidth > 0 {
            self.layer.borderWidth = CGFloat(borderWidth)
            self.layer.borderColor = borderColor?.cgColor
        }
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func addShadow(){
//        self.layer.shadowRadius = 2
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.masksToBounds = false
//        self.layer.shadowOffset = CGSize(width: 0, height: 1)
//
        
        
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }


    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .white)

        if let _ = self.viewWithTag(200) as? UIActivityIndicatorView {
            
        } else {
            activityIndicator.center = self.center
            activityIndicator.color = UIColor.white
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 200
            self.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        if let activityIndicator = self.viewWithTag(200) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
}
