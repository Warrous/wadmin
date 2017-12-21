//
//  VehiclesViewController.swift
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
import Nuke
import Foundation

class VehiclesViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var etSearch: UITextField!
    
    var changedList : [Vehicle] = []
    var orginalList : [Vehicle] = []
    
    @IBAction func textChangeListener(_ sender: Any)
    {
        if etSearch.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && list.count > 0
        {
            changedList = []
            let searchString = etSearch.text?.trimmingCharacters(in : .whitespacesAndNewlines).lowercased()
            for item in orginalList
            {
                let content = item.Model + " " + item.Make + " " + item.Year + " " + item.Type + " " + item.Vin + " " + item.Model + " " +
                    item.Year + " " + item.Make + " " + item.Type + " " + item.Vin + " " + item.Make + " " + item.Model + " " + item.Year + " " +
                    item.Make + " " + item.Type + " " + item.Year + " " + item.Vin +
                    item.Model + " " + item.Type
                
                if (content.lowercased().range(of : searchString!)) != nil
                {
                    changedList.append(item)
                }
            }
            if changedList.count > 0
            {
                list = changedList
                vehicleCollectionView.reloadData()
            }
            else
            {
                list = changedList
                vehicleCollectionView.reloadData()
            }
        }
        else
        {
            list = orginalList
            vehicleCollectionView.reloadData()
        }
    }
    var manager = Nuke.Manager.shared
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vehicleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleCell", for: indexPath) as! VehicleCollectionViewCell
        
        vehicleCell.tvCarName.text = list[indexPath.row].Model
        vehicleCell.tvVehicleVin.text = list[indexPath.row].Vin.uppercased()
        vehicleCell.tvVehicleYear.text = list[indexPath.row].Year
        vehicleCell.tvVehicleMake.text = list[indexPath.row].Make.uppercased()
        vehicleCell.tvVehicleType.text = list[indexPath.row].Type
        
        //vehicleCell.imgCar.image = nil
        vehicleCell.imgCar.layer.cornerRadius = 20
        
        let request = Request(url: URL(string: Constants.URL_SAMPLE_CAR_SEDAN)!)
    
        manager.loadImage(with : request, into : vehicleCell.imgCar)
         vehicleCell.imgCar.layer.cornerRadius = 25
         vehicleCell.imgCar.clipsToBounds = true
        
        vehicleCell.view.layer.cornerRadius = 5
        vehicleCell.view.clipsToBounds = true
      
        
        
        // geofenceCell.imgGeofence.tintColor = UIColor.white
        
        return vehicleCell
    }
    
     public var uiActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiActivityIndicatorView.center = view.center
        uiActivityIndicatorView.isHidden = true
      
        view.addSubview(uiActivityIndicatorView)
        
        // geofenceCollectionView.refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        vehicleCollectionView.es.addPullToRefresh
            {
                [unowned self] in
                self.fetchVehicles()
                
                
                
        }
        
        self.fetchVehicles()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var vehicleCollectionView: UICollectionView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
     var list : [Vehicle] = []
    
    
    public func fetchVehicles()
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
                self.vehicleCollectionView.es.stopPullToRefresh()
                // return response
        }
    }
    
    public func parseData(JSONData: Data)
    {
        let jsonArray = JSON(JSONData).array
        list = []
        for vehicleJson in jsonArray!
        {
            let vehicle = Vehicle();
            vehicle.VehicleId = vehicleJson["VehicleId"].stringValue
            vehicle.VehicleGuid = vehicleJson["VehicleGuid"].stringValue
            vehicle.Type = vehicleJson["Type"].stringValue
            vehicle.Latitude = vehicleJson["Latitude"].stringValue
            vehicle.Longitude = vehicleJson["Longitude"].stringValue
            vehicle.Make = vehicleJson["Make"].stringValue
            vehicle.Model = vehicleJson["Model"].stringValue
            vehicle.Year = vehicleJson["Year"].stringValue
            vehicle.Vin = vehicleJson["Vin"].stringValue
            
            
            
            
            list.append(vehicle)
            
            
        }
        orginalList = list
        if list.count > 0
        {
            vehicleCollectionView.reloadData()
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
