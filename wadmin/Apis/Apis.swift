//
//  File.swift
//  wadmin
//
//  Created by Gokul on 13/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import Foundation
import Alamofire

public class Apis
{

    
    public static func fetchApiDetails(url : String, body : [String : Any], type : String ) 
        {
           
                    let headers = [
                        "Content-Type": "application/x-www-form-urlencoded"
                    ]
                    if(type.elementsEqual("POST"))
                    {
                        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers : headers)
                            .responseJSON { response in
                                debugPrint(response)
                               // return response
                                
                        }
                        
                    }
                    else
                    {
                        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers : headers)
                            .responseJSON { response in
                                debugPrint(response)
                               // return  response
                        }
                        
                    }
          
            
            }
            
    
}
