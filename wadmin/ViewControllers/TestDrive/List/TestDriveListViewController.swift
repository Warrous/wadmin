//
//  TestDriveListViewController.swift
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

class TestDriveListViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var testDriveCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let testDriveCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestDriveCell", for: indexPath) as! TestDriveCollectionViewCell
        
        testDriveCell.tvCarName.text = list[indexPath.row].Make + " " + list[indexPath.row].Model
        testDriveCell.tvCarVin.text = list[indexPath.row].Vin.uppercased()
        testDriveCell.tvSourceName.text = Constants.ROUTE_SOURCE
        testDriveCell.tvDestinationName.text = Constants.ROUTE_DESTINATION
        testDriveCell.tvSalesPersonName.text = list[indexPath.row].AssignedTo
        
        testDriveCell.view.layer.cornerRadius = 5
        testDriveCell.view.clipsToBounds = true
        
        
        return testDriveCell
    }
    
    public var uiActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiActivityIndicatorView.center = view.center
        uiActivityIndicatorView.isHidden = true
        
        view.addSubview(uiActivityIndicatorView)
        
        // geofenceCollectionView.refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        testDriveCollectionView.es.addPullToRefresh
            {
                [unowned self] in
                self.fetchTestDrives()
                
                
                
        }
        
        self.fetchTestDrives()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var list : [TestDrive] = []
    
    
    public func fetchTestDrives()
    {
        
        self.uiActivityIndicatorView.isHidden = false
        self.uiActivityIndicatorView.startAnimating()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let body = [
            "DealerId" : "1",
            "MakeId" : "-1",
            "ModelId" : "-1",
            "YearId" : "-1",
            "TypeId" : "-1"
            
        ]
        Alamofire.request(Constants.URL_FETCH_VEHCILES_BASED_ON_DEALER_ID, method: .get ,parameters: body, encoding: URLEncoding.default, headers: headers)
            .responseJSON
            { response in
                debugPrint(response)
                self.parseData(JSONData : response.data!)
                self.uiActivityIndicatorView.stopAnimating()
                self.testDriveCollectionView.es.stopPullToRefresh()
                // return response
        }
    }
    
    public func parseData(JSONData: Data)
    {
        let jsonArray = JSON(JSONData).array
        list = []
        for testDriveJson in jsonArray!
        {
            let testDrive = TestDrive();
            testDrive.VehicleId = testDriveJson["VehicleId"].intValue
            testDrive.VehicleGuid = testDriveJson["VehicleGuid"].stringValue
            testDrive.AssignedTo = testDriveJson["AssignedTo"].stringValue
            testDrive.Latitude = testDriveJson["Latitude"].stringValue
            testDrive.Longitude = testDriveJson["Longitude"].stringValue
            testDrive.Make = testDriveJson["Make"].stringValue
            testDrive.Model = testDriveJson["Model"].stringValue
            testDrive.Year = testDriveJson["Year"].stringValue
            testDrive.Vin = testDriveJson["Vin"].stringValue
            
            
            
            
            list.append(testDrive)
            
            
        }
      
        if list.count > 0
        {
            testDriveCollectionView.reloadData()
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
