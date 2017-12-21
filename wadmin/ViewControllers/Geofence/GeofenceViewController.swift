//
//  GeofenceViewController.swift
//  wadmin
//
//  Created by Gokul on 15/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GeofenceViewController: UIViewController {

    @IBOutlet weak var btSubmit: UIButton!
    @IBAction func sliderChange(_ sender: Any)
    {
        
    }
    
 
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var mapView: GMSMapView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btSubmit.layer.cornerRadius = 15
        btSubmit.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgSearch.isUserInteractionEnabled = true
        imgSearch.addGestureRecognizer(tapGestureRecognizer)
       
        //view = mapView
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
        //marker.map = mapView

        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self as! GMSAutocompleteViewControllerDelegate
        present(autocompleteController, animated: true, completion: nil)
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func addMarker(place : GMSPlace)
    {
        let marker = GMSMarker()
        mapView.clear()
        marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.map = mapView
        let circleCenter = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let circ = GMSCircle(position: circleCenter, radius: 1000)
        circ.fillColor = UIColor(red:0.00, green:0.80, blue:0.80, alpha:0.25)
        circ.strokeColor = UIColor(red:0.00, green:0.80, blue:0.80, alpha:1.0)
        //circ.strokeColor = UIColorFromRGB(0x228899)
        circ.strokeWidth = 5
        circ.map = mapView
        
        let camera = GMSCameraPosition.camera(withLatitude : place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 14.0)
        
        mapView.camera = camera
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

    extension GeofenceViewController : GMSAutocompleteViewControllerDelegate
    {
        
        // Handle the user's selection.
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
        {
            print("Place name: \(place.name)")
            print("Place address: \(String(describing: place.formattedAddress))")
            print("Place attributes", place.coordinate)
            print(place)
            self.addMarker(place: place)
            self.dismiss(animated: true, completion: nil)
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            // TODO: handle the error.
            print("Error: ", error.localizedDescription)
        }
        
        // User canceled the operation.
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            self.dismiss(animated: true, completion: nil)
        }
        
        // Turn the network activity indicator on and off again.
        func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    
    }
    


