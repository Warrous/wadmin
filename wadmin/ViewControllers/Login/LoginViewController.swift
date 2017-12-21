//
//  LoginViewController.swift
//  wadmin
//
//  Created by Gokul on 13/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
import Alamofire
import SwiftyJSON
import JWTDecode

class LoginViewController: UIViewController {

    @IBOutlet weak var etUsername: UITextField!
    
    @IBOutlet weak var etPassword: UITextField!
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vlink Login"
        btLogin.layer.cornerRadius = 15
        btLogin.clipsToBounds = true
        activityIndicator.isHidden = true

        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func doLogin(_ sender: Any)
    {
        if(etUsername.text != "" && etPassword.text != "")
        {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            btLogin.isHidden = true
            
            let data = ["username": etUsername.text , "password": etPassword.text ] as [String : Any]
            checkUser(body: data)
           
            
    
        }
        else
        {
            Utility.showSnackbar(content: "Please enter username and password")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func checkUser(body : [String : Any])
    {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        Alamofire.request(Constants.URL_LOGIN, method: .post ,parameters: body, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                debugPrint(response)
                self.parseData(JSONData : response.data!)
                self.btLogin.isHidden = false
                self.activityIndicator.isHidden = true
                if(Utility.getBool(key: Constants.LOGIN))
                {
                    var homeController = HomeViewController()
                    homeController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.present(homeController, animated:true, completion:nil)
                }
                else
                {
                    Utility.showSnackbar(content: "Invalid user roll")
                }
                // return response
                
        }
    }
    
    public func parseData(JSONData: Data)
    {
        do {
            let json = JSON(JSONData)
            
            if(json[Constants.ACCESS_TOKEN].exists())
            {
                //print(Constants.TOKEN_TYPE,json[Constants.TOKEN_TYPE])
                Utility.setString(key: Constants.ACCESS_TOKEN, value: json[Constants.ACCESS_TOKEN].string!)
                Utility.setString(key: Constants.EXPIRES_IN, value: String(json[Constants.EXPIRES_IN].int!))
                Utility.setString(key: Constants.TOKEN_TYPE, value: json[Constants.TOKEN_TYPE].string!)
                let jwtToken = try decode(jwt :  json[Constants.ACCESS_TOKEN].string!)
                print(jwtToken.body)
                let payload = JSON(jwtToken.body)
                Utility.setString(key: Constants.PAYLOAD, value: payload.rawString()!)
                if(payload["UserName"].exists())
                {
                    Utility.setString(key: Constants.USER_NAME, value: payload["UserName"].string!)
                    Utility.setString(key: Constants.FIRST_NAME, value: payload["FirstName"].string!)
                    Utility.setString(key: Constants.LAST_NAME, value: payload["LastName"].string!)
                    Utility.setString(key: Constants.DEALER_ID, value: payload[Constants.DEALER_ID].string!)
                    var type : Int = 0
                    
                    let roles : String = payload["role"].rawString()!
                    var userRoll : String = "";
                    
                    if(roles.contains(Constants.SUPER_ADMIN))
                    {
                        type = 1439
                        userRoll = Constants.SUPER_ADMIN;
                    }
                    else if(roles.contains(Constants.SALES_PERSON))
                    {
                        type = 3;
                        userRoll = Constants.SALES_PERSON;
                    }
                    else if(roles.contains(Constants.VEHICLE_SALES_MANAGER))
                    {
                        type = 4;
                        userRoll = Constants.VEHICLE_SALES_MANAGER;
                    }
                    else if(roles.contains(Constants.VEHICLE_SERVICE_TECHNICIAN))
                    {
                        type = 5;
                        userRoll = Constants.VEHICLE_SERVICE_TECHNICIAN;
                    }
                    else
                    {
                        Utility.showSnackbar(content: "Invalid user Role")
                        return
                    }
                    
                    Utility.setString(key: Constants.USER_ROLL_NAME, value: userRoll)
                    Utility.setInt(key: Constants.USER_TYPE, value: type)
                    Utility.setBool(key: Constants.LOGIN, value: true)
                    
                    
                    
                    

                
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            else
            {
                Utility.showSnackbar(content : "Invalid username or password")
            }
           
        }
        catch
        {
            print(error)
            Utility.showSnackbar(content : "Invalid username or password")
        }
    
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
