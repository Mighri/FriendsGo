//
//  AppDelegate.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 20/02/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //facebook
  
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
/*
        if let accessToken = FBSDKAccessToken.current(){
            print(accessToken)
        }else{
            print("Not logged In.")
        }
*/
        
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "381533501640-0top6n4qlemq6dpqnjveuqpn28glhf01.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self

       /*
        
        if (FBSDKAccessToken.current() != nil) {
       
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
   
        }
    */
        /*
    GMSServices.provideAPIKey("AIzaSyCjPSfqvEXANHT-itplcDV30fGr2yxW7CU")
        
        GMSPlacesClient.provideAPIKey("AIzaSyCjPSfqvEXANHT-itplcDV30fGr2yxW7CU")
 */
        
        GMSServices.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        GMSPlacesClient.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
       
                FirebaseApp.configure()
      
      return true
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any)-> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
        return true
        
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    // [START signin_handler]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            // [START_EXCLUDE silent]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let photo = user.profile.hasImage
            let photoURL = user.profile.imageURL(withDimension: 100) 
            
           // print(fullName!)
            print(email!)
            print(photoURL)
            print(givenName!)
            print(familyName!)
            
  
            // [START_EXCLUDE]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: ["fullName": fullName!, "email": email!, "givenName": givenName!, "familyName": familyName!, "photoURL": photoURL])
            
            // [END_EXCLUDE]
            /*
            
            let mystoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            
            let ViewController = mystoryboard.instantiateViewController(withIdentifier: "LoginController") as! ViewController
            
              ViewController.stringPassed = fullName!
            
           ViewController.navigationController?.pushViewController(ViewController, animated: true)
            
            let appDelegate:AppDelegate = UIApplication.shared.delegate as!AppDelegate
            
            */
            
        }
    }

    func application(application: UIApplication,
                     openURL url: URL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        var options: [String: AnyObject] = [UIApplicationOpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject,
                                            UIApplicationOpenURLOptionsKey.annotation.rawValue: annotation!]
        return GIDSignIn.sharedInstance().handle(url,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }

    /*
    
    func application(application: UIApplication,
                     openURL url: URL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    */
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       
    }

    func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "ImportViewController") as! ImportViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        
        let mystoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let rightViewController = mystoryboard.instantiateViewController(withIdentifier: "LoginController") as! ViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "000000")
        
        UINavigationBar.appearance().barTintColor = UIColor(hex: "BC2869")
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    
    
    

}

