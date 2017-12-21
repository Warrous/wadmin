//
//  DeliveryActivityListViewController.swift
//  wadmin
//
//  Created by Gokul on 21/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
import Alamofire
import SwiftyJSON
import ESPullToRefresh
import Nuke


class DeliveryActivityListViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return combineList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let deliveryActivityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryActivityCell", for: indexPath) as! DeliveryActivityCollectionViewCell
        
        deliveryActivityCell.tvTruckName.text = combineList[indexPath.row].TruckName
        deliveryActivityCell.tvVehiclesCount.text = "Vehicles : " + "\(combineList[indexPath.row].VehicleCount)"
        deliveryActivityCell.tvDriverName.text = "Driver : " + combineList[indexPath.row].DriverName
        
        deliveryActivityCell.view.layer.cornerRadius = 3
        deliveryActivityCell.view.clipsToBounds = true
        
        return deliveryActivityCell
    }
    
    public var uiActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiActivityIndicatorView.center = view.center
        uiActivityIndicatorView.isHidden = true
        
        view.addSubview(uiActivityIndicatorView)
        
        
        deliveryActivityCollectionView.es.addPullToRefresh
            {
                [unowned self] in
                self.fetchCustomers()
                
                
            }
        
        self.fetchCustomers()

        
    }
    @IBOutlet weak var deliveryActivityCollectionView: UICollectionView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var list : [DeliveryTruck] = []
    
    var combineList : [DeliveryTruck] = []
    
    var vehicleList : [DeliveryTruckVehicle] = []
    
    
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
        Alamofire.request(Constants.URL_DELIVERY_TRUCKS, method: .get ,parameters: body, encoding: URLEncoding.default, headers: headers)
            .responseJSON
            { response in
                debugPrint(response)
                self.parseData(JSONData : response.data!)
                self.uiActivityIndicatorView.stopAnimating()
                self.deliveryActivityCollectionView.es.stopPullToRefresh()
                // return response
        }
    }
    
    public func parseData(JSONData: Data)
    {
        let jsonArray = JSON(JSONData).array
        list = []
        vehicleList = []
        combineList = []
        for truckJson in jsonArray!
        {
            let truck = DeliveryTruck()
            
            truck.TransitTruckId = truckJson["TransitTruckId"].intValue
            truck.TransitTruckTripId = truckJson["TransitTruckTripId"].intValue
            truck.RouteId = truckJson["RouteId"].intValue
            truck.EstimatedDelivery = truckJson["EstimatedDelivery"].stringValue
            truck.RouteId = truckJson["RouteId"].intValue
            truck.VehicleCount = truckJson["VehicleCount"].intValue
            truck.TruckName = truckJson["TruckName"].stringValue
            truck.DriverName = truckJson["DriverName"].stringValue
            truck.Destination = truckJson["Destination"].stringValue
            truck.Origin = truckJson["Origin"].stringValue
            truck.Latitude = truckJson["Latitude"].stringValue
            truck.Longitude = truckJson["Longitude"].stringValue
         
            list.append(truck)
            
            let truckVehlice = DeliveryTruckVehicle()
            
            truckVehlice.TransitTruckId = truckJson["TransitTruckId"].intValue
            truckVehlice.VehicleId = truckJson["VehicleId"].intValue
            truckVehlice.CustomerId = truckJson["CustomerId"].intValue
            truckVehlice.MakeId = truckJson["MakeId"].intValue
            truckVehlice.ModelyearId = truckJson["ModelyearId"].intValue
            truckVehlice.MakemodelId = truckJson["MakemodelId"].intValue
            truckVehlice.DealerId = truckJson["DealerId"].intValue
            truckVehlice.Make = truckJson["Make"].stringValue
            truckVehlice.Year = truckJson["Year"].stringValue
            truckVehlice.Vin = truckJson["Vin"].stringValue
            truckVehlice.Model = truckJson["Model"].stringValue
            truckVehlice.VehicleGuid = truckJson["VehicleGuid"].stringValue
            
            vehicleList.append(truckVehlice)
            
            
            
            
            
            
            
            
            
            
            
        }
        
       
        for i in 0 ..< list.count
        {
            if i==0
            {
                list[i].VehicleCount += 1
                combineList.append(list[i])
            }
            else
            {
                var flag : Int = 0
                
                for j in 0 ..< combineList.count
                {
                    if combineList[j].TransitTruckId == list[i].TransitTruckId
                    {
                        flag = 1;
                        combineList[j].VehicleCount += 1
                    }
                }
                if (flag == 0)
                {
                    list[i].VehicleCount += 1
                    combineList.append(list[i])
                    
                }
                
            }
        }
        
        if combineList.count > 0
        {
            deliveryActivityCollectionView.reloadData()
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
