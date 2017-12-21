//
//  GeofenceListViewController.swift
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

class GeofenceListViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate{

    

    @IBOutlet weak var geofenceCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let geofenceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeofenceCell", for: indexPath) as! GeofenceCollectionViewCell
        
        geofenceCell.tvGeofenceName.text = list[indexPath.row].GeofenceName.uppercased()
        geofenceCell.tvGeofenceRadius.text = "Radius : " + "\(list[indexPath.row].Radius)"
        geofenceCell.uvGeofence.layer.cornerRadius = 5
    
        geofenceCell.uvGeofence.clipsToBounds = true
        
        
       // geofenceCell.imgGeofence.tintColor = UIColor.white
        
        return geofenceCell
    }
    
    
   
    
    
    

    
    
    public var uiActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    public var list : [Geofence] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
           //list = Utility.generateGeofences()
        
        uiActivityIndicatorView.center = view.center
        uiActivityIndicatorView.isHidden = true
        view.addSubview(uiActivityIndicatorView)
        
       // geofenceCollectionView.refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        geofenceCollectionView.es.addPullToRefresh
        {
            [unowned self] in
            self.fetchGeofences()
            
            
            
        }
        
        self.fetchGeofences()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    public func fetchGeofences()
    {
        
        self.uiActivityIndicatorView.isHidden = false
        self.uiActivityIndicatorView.startAnimating()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let body = [
            "DealerId" : "1"
        ]
        Alamofire.request(Constants.URL_FETCH_GEOFENCE, method: .get ,parameters: body, encoding: URLEncoding.default, headers: headers)
            .responseJSON
            { response in
                debugPrint(response)
               self.parseData(JSONData : response.data!)
               self.uiActivityIndicatorView.stopAnimating()
               self.geofenceCollectionView.es.stopPullToRefresh()
                // return response
            }
    }
    
    public func parseData(JSONData: Data)
    {
        let jsonArray = JSON(JSONData).array
        list = []
        for geofence in jsonArray!
        {
            let geofenceItem = Geofence();
            geofenceItem.GeofenceGuid = geofence["GeofenceGuid"].stringValue
            geofenceItem.GeofenceId = geofence["GeofenceId"].intValue
            geofenceItem.GeofenceName = geofence["GeofenceName"].stringValue
            geofenceItem.Radius = geofence["Radius"].doubleValue
            geofenceItem.Latitude = geofence["Latitude"].doubleValue
            geofenceItem.Longitude = geofence["Longitude"].doubleValue
            
            list.append(geofenceItem)
        
            
        }
        
        if list.count > 0
        {
            geofenceCollectionView.reloadData()
        }
        else
        {
            Utility.showSnackbar(content: "No data found")
        }
        
        
        
    }


}
