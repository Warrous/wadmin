//
//  ReportsViewController.swift
//  wadmin
//
//  Created by Gokul on 19/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
import Alamofire
import SwiftyJSON
import ESPullToRefresh

class ReportsViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reportsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportsCell", for: indexPath) as! ReportsCollectionViewCell
        
        reportsCell.tvReportName.text = list[indexPath.row].ReportName
        reportsCell.tvReportDescription.text = list[indexPath.row].ReportDescription
     
        
        
        // geofenceCell.imgGeofence.tintColor = UIColor.white
        
        return reportsCell
    }
    
    
    public var uiActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    

    @IBOutlet weak var reportsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        uiActivityIndicatorView.center = view.center
        uiActivityIndicatorView.isHidden = true
        view.addSubview(uiActivityIndicatorView)
        
        // geofenceCollectionView.refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        reportsCollectionView.es.addPullToRefresh
            {
                [unowned self] in
                self.fetchReports()
                
                
                
        }
        
        self.fetchReports()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var list : [Reports] = []
    
    
    
    public func fetchReports()
    {
        
        self.uiActivityIndicatorView.isHidden = false
        self.uiActivityIndicatorView.startAnimating()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let body = [
            "DealerId" : "1"
        ]
        Alamofire.request(Constants.URL_FETCH_REPORTS_BASED_ON_DEALER_ID, method: .get ,parameters: body, encoding: URLEncoding.default, headers: headers)
            .responseJSON
            { response in
                debugPrint(response)
                self.parseData(JSONData : response.data!)
                self.uiActivityIndicatorView.stopAnimating()
                self.reportsCollectionView.es.stopPullToRefresh()
                // return response
        }
    }
    
    public func parseData(JSONData: Data)
    {
        let jsonArray = JSON(JSONData).array
        list = []
        for reportJson in jsonArray!
        {
            let report = Reports();
            report.ReportId = reportJson["ReportId"].stringValue
            report.ReportName = reportJson["ReportName"].stringValue
            report.ReportDescription = reportJson["ReportDescription"].stringValue
            report.ReportUrl = reportJson["ReportUrl"].stringValue
           
            list.append(report)
            
            
        }
        
        if list.count > 0
        {
            reportsCollectionView.reloadData()
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
