//
//  CustomerLookUpViewController.swift
//  wadmin
//
//  Created by Gokul on 20/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
import Alamofire
import SwiftyJSON
import ESPullToRefresh
import Nuke

class CustomerLookUpViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate  {
    
    
    
    var manager = Nuke.Manager.shared
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerCell", for: indexPath) as! CustomerLookUpCollectionViewCell
        
        customerCell.tvCustomerName.text = list[indexPath.row].FullName
        customerCell.tvCustomerEmail.text = list[indexPath.row].PrimaryEmail.lowercased()
        customerCell.tvCustomerPhone.text = "+" + list[indexPath.row].CountryCode + "-" + list[indexPath.row].PhoneNumber
        
        customerCell.tvCustomerCompany.text = list[indexPath.row].CompanyName
        
        customerCell.tvCustomerAddress.text = list[indexPath.row].Address
        
        customerCell.tvCustomerCityCountry.text = list[indexPath.row].City + "" + list[indexPath.row].Country
        
        
        let request = Request(url: URL(string: Constants.URL_SAMPLE_CUSTOMER_IMAGE)!)
        
        manager.loadImage(with : request, into : customerCell.imgCustomer)
        customerCell.imgCustomer.layer.cornerRadius = 25
        customerCell.imgCustomer.clipsToBounds = true
        
        customerCell.view.layer.cornerRadius = 3
        customerCell.view.clipsToBounds = true
        
        
        
        
        return customerCell
    }
    
    public var uiActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    @IBOutlet weak var customerLookUpCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiActivityIndicatorView.center = view.center
        uiActivityIndicatorView.isHidden = true
        
        view.addSubview(uiActivityIndicatorView)
        
        // geofenceCollectionView.refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        customerLookUpCollectionView.es.addPullToRefresh
            {
                [unowned self] in
                self.fetchCustomers()
                
                
                
        }
        
        self.fetchCustomers()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var list : [Customer] = []
    
    
    public func fetchCustomers()
    {
        
        self.uiActivityIndicatorView.isHidden = false
        self.uiActivityIndicatorView.startAnimating()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let body = [
            "DealerId" : "1",
        ]
        Alamofire.request(Constants.URL_FETCH_CUSTOMERS, method: .get ,parameters: body, encoding: URLEncoding.default, headers: headers)
            .responseJSON
            { response in
                debugPrint(response)
                self.parseData(JSONData : response.data!)
                self.uiActivityIndicatorView.stopAnimating()
                self.customerLookUpCollectionView.es.stopPullToRefresh()
                // return response
        }
    }
    
    public func parseData(JSONData: Data)
    {
        let jsonArray = JSON(JSONData).array
        list = []
        for customerJson in jsonArray!
        {
            let customer = Customer();
            
            customer.CustomerId = customerJson["CustomerId"].intValue
            customer.CustomerGuid = customerJson["CustomerGuid"].stringValue
            customer.FullName = customerJson["FullName"].stringValue
            customer.PrimaryEmail = customerJson["PrimaryEmail"].stringValue
            customer.SecondaryEmail = customerJson["SecondaryEmail"].stringValue
            customer.Address = customerJson["Address"].stringValue
            customer.City = customerJson["City"].stringValue
            customer.Country = customerJson["Country"].stringValue
            customer.CountryCode = customerJson["CountryCode"].stringValue
            customer.PhoneNumber = customerJson["PhoneNumber"].stringValue
            customer.CompanyName = customerJson["CompanyName"].stringValue
            
            
            
            
            
            
            list.append(customer)
            
            
        }
     
        if list.count > 0
        {
            customerLookUpCollectionView.reloadData()
        }
        else
        {
            Utility.showSnackbar(content: "No data found")
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
