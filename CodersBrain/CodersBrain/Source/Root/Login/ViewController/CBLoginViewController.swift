//
//  CBLoginViewController.swift
//  CodersBrain
//
//  Created by Happlabs Software LLP MAC1 on 27/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import Google


class CBLoginViewController: UIViewController, GIDSignInDelegate,GIDSignInUIDelegate,LoginButtonDelegate {
    
    @IBOutlet weak var skipButton: UIButton!
    var dict : [String : AnyObject]!
    let clientID = "761614235758-t0ekvqvfijc3qnrokugrm7dl8390ft2n.apps.googleusercontent.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.applyRoundCorner(radius: 20, borderWidth: 0, borderColor: nil)
        
        if (FBSDKAccessToken.current()) != nil{
            getFBUserData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GIDSignIn.sharedInstance().clientID = clientID
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
         // Gmail creating button
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.frame = CGRect(x: self.view.frame.width/2 - 50 , y: self.view.frame.height/2, width : 50 , height : 50)
        self.view.addSubview(googleSignInButton)
        
        // Facebook creating button
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.frame = CGRect(x: self.view.frame.width/2 - 50 , y: self.view.frame.height/2 - 50, width : 115 , height : 35)
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        getFBUserData()
    }
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    // Pragma Mark : Facebook Function is fetching the user data
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    let id = self.dict["id"] as! String
                    let name = self.dict["name"] as! String
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(name, forKey: "name")
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    // Pragma MARK : Back Buttton Action
    
    @IBAction func didTapSkipButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //  Pragma Mark : Gamil Information when signin complets.
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print(error ?? "google error")
            return
        }
        else{
            UserDefaults.standard.set(1, forKey: "id")
            UserDefaults.standard.set(user.profile.name!, forKey: "name")
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
