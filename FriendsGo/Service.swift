//
//  Service.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 28/02/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON


class Service {
    
    //singleton
    static let sharedInstance = Service()
    
    // - Méthode pour le login et la récupération de l'objet(user connecté)
    
    func login(url: String)
    {
        // - Params
        let params : [String : String] = ["userName": "Radhia",
                                          "userPassword": "Mighri"]
        // - Headers
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        Alamofire.request(url, method:.post, parameters: params, headers : headers)
            .validate()
            .responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success:
                    print(response.result.value!)
                    let info = response.result.value as! [String : AnyObject]
                    //let mail = info["Mail"] as! String
                    //print(mail)
                    let Objet = (info as! [String : AnyObject])["elements"]
                    let mail = Objet!["Mail"] as! String
                    print(mail)
                    
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    // - Méthode pour l'inscription d'un user
    
    func postIt(parameters: [String : String], url: String)
    {
        // - Headers
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(url, method:.post, parameters: parameters, headers : headers)
            .validate()
            .responseString(completionHandler: { (response) in
                
                switch response.result {
                case .success:
                    print(response)
                case .failure(let error):
                    print(error)
                }
            })
        
    }
    
    
    
    
    
    func postItAny(parameters: [String : Any], url: String)
    {
        // - Headers
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(url, method:.post, parameters: parameters, headers : headers)
            .validate()
            .responseString(completionHandler: { (response) in
                
                switch response.result {
                case .success:
                    print(response)
                case .failure(let error):
                    print(error)
                }
            })
        
    }
    
    
    
    
    
    
    
    
    // MARK: - Load Informations From WebService when a user connect to the app
    func loadInfo(parameters: [String : String], url: String, completionHandler:@escaping (Bool, [Friend]?) -> ()) {
        // - Headers
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(url, method:.post, parameters: parameters, headers : headers)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case let .success(value):
                    
                    if let result = value as? [String: Any] {
                        
                        if let items = result["elements"] as? [[String: Any]] {
                            let user = Mapper<Friend>().mapArray(JSONArray: items )
                            print(items)
                            
                            print(user)
                            
                            //let userId = String(describing:user[0].id)
                            UserDefaults.standard.set(user[0].id, forKey: "Saveid")
                            
                            // UserDefaults.standard.set(user[0], forKey: "SaveUser")
                            
                            
                            UserDefaults.standard.set(user[0].Nom, forKey: "SaveName")
                            UserDefaults.standard.set(user[0].photoURL, forKey: "SavePhoto")
                            UserDefaults.standard.set(user[0].prenom, forKey: "SavePrenom")
                            UserDefaults.standard.set(user[0].email, forKey: "SaveEmail")
                            
                            completionHandler(true, user)
                            
                        } else {
                            completionHandler(false, nil)
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                    completionHandler(false, nil)
                }
        }
        
    }
    
    
    func loadInfoAny(parameters: [String : Any], url: String, completionHandler:@escaping (Bool, [Friend]?) -> ()) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        
        Alamofire.request(url, method:.post, parameters: parameters, headers : headers)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case let .success(value):
                    
                    if let result = value as? [String: Any] {
                        
                        if let items = result["elements"] as? [[String: Any]] {
                            let user = Mapper<Friend>().mapArray(JSONArray: items )
                            print(items)
                            
                            print(user)
                            
                            completionHandler(true, user)
                            
                        } else {
                            completionHandler(false, nil)
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                    completionHandler(false, nil)
                }
        }
        
    }
    
    
    
    
    
    
    func loadEvent(parameters: [String : Any], url: String, completionHandler:@escaping (Bool, [Event]?) -> ()) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        
        Alamofire.request(url, method:.post, parameters: parameters, headers : headers)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case let .success(value):
                    
                    if let result = value as? [String: Any] {
                        
                        if let items = result["events"] as? [[String: Any]] {
                            let event = Mapper<Event>().mapArray(JSONArray: items )
                            print(items)
                            
                            print(event)
                            
                            completionHandler(true, event)
                            
                        } else {
                            completionHandler(false, nil)
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                    completionHandler(false, nil)
                }
        }
        
    }
    
    
    
    func loadInvitation(parameters: [String : Any], url: String, completionHandler:@escaping (Bool, [InvitationFG]?) -> ()) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        
        Alamofire.request(url, method:.post, parameters: parameters, headers : headers)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case let .success(value):
                    
                    if let result = value as? [String: Any] {
                        
                        if let items = result["invitationsFG"] as? [[String: Any]] {
                            let invitation = Mapper<InvitationFG>().mapArray(JSONArray: items )
                            print(items)
                            
                            print(invitation)
                            
                            completionHandler(true, invitation)
                            
                        } else {
                            completionHandler(false, nil)
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                    completionHandler(false, nil)
                }
        }
        
    }
    
    
    
    
    
}
