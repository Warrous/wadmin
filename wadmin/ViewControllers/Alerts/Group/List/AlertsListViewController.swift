//
//  AlertsListViewController.swift
//  wadmin
//
//  Created by Gokul on 18/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
import Alamofire
import SwiftyJSON
import ESPullToRefresh

class AlertsListViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var alertRuleCollectionView: UICollectionView!
    
    public var categoryId : String = "1"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let alertRuleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlertRuleCell", for: indexPath) as! AlertsCollectionViewCell
        
        alertRuleCell.tvAlertName.text = list[indexPath.row].AlertName
        
        if list[indexPath.row].VehicleCount>1
        {
        alertRuleCell.tvApplyVehicles.text = "Apply on " + "\(list[indexPath.row].VehicleCount)" + " vehicles"
        }
        else
        {
        alertRuleCell.tvApplyVehicles.text = "Apply on " + "\(list[indexPath.row].VehicleCount)" + " vehicle"
        }
       
        
        return alertRuleCell
    }
    
    
    
    
    
    
    
    
    
    public var uiActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    public var list : [AlertRule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiActivityIndicatorView.center = view.center
        uiActivityIndicatorView.isHidden = true
        view.addSubview(uiActivityIndicatorView)
        
       // geofenceCollectionView.refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        alertRuleCollectionView.es.addPullToRefresh
            {
                [unowned self] in
                self.fetchAlertRules()



            }
       fetchAlertRules();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func fetchAlertRules()
    {
        
        self.uiActivityIndicatorView.isHidden = false
        self.uiActivityIndicatorView.startAnimating()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let body = [
            "categoryId" : categoryId,
            "DealerId" : "1"
        ]
        Alamofire.request(Constants.URL_FETCH_ALERTS_BASED_ON_CATEGORY, method: .get ,parameters: body, encoding: URLEncoding.default, headers: headers)
            .responseJSON
            { response in
                debugPrint(response)
                self.parseData(JSONData : response.data!)
                self.uiActivityIndicatorView.stopAnimating()
                self.alertRuleCollectionView.es.stopPullToRefresh()
                // return response
        }
    }
    
    public func parseData(JSONData: Data)
    {
        let jsonArray = JSON(JSONData).array
        list = []
        for alertRule in jsonArray!
        {
            let alertItem = AlertRule();
            alertItem.AlertGuid = alertRule["AlertGuid"].stringValue
            alertItem.AlertId = alertRule["AlertId"].intValue
            alertItem.AlertName = alertRule["AlertName"].stringValue
            alertItem.VehicleCount = alertRule["VehicleCount"].intValue
           
            list.append(alertItem)
            
            
        }
        
        if list.count > 0
        {
            alertRuleCollectionView.reloadData()
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
