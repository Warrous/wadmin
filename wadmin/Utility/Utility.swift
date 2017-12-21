//
//  Utility.swift
//  wadmin
//
//  Created by Gokul on 12/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar

public class Utility
{

    
    public static func showSnackbar(content : String)
    {
        let message = MDCSnackbarMessage()
        message.text = content
        MDCSnackbarManager.show(message)
    }
    
    public static func setString(key : String,value : String)
    {
        
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        let didSave = preferences.synchronize()
        if !didSave
        {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
    }
    
    public static func getString(key : String) -> String
    {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: key) == nil
        {
            return "";
        }
        else
        {
            return preferences.string(forKey: key)!
        }
        
    }
    
    public static func getInt(key: String) -> Int
    {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: key) == nil
        {
            return 0;
        }
        else
        {
            return preferences.integer(forKey: key)
        }

       
    }
    
    public static func setInt(key : String, value : Int)
    {
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        let didSave = preferences.synchronize()
        if !didSave
        {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
    }
    
    public static func setBool(key : String, value : Bool)
    {
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        let didSave = preferences.synchronize()
        if !didSave
        {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
    }
    
    public static func getBool (key : String) -> Bool
    {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: key) == nil
        {
            return false;
        }
        else
        {
            return preferences.bool(forKey: key)
        }
        
       
    }
    
    public static func generateUserRoles() -> [UserRole]
    {
        var list = [UserRole]()
        let u1 : UserRole = UserRole()
        u1.Name = "Locate vehicle"
        u1.Image = "locate_vehicle.png"
        let u2 : UserRole = UserRole()
        u2.Name = "Test Drive"
        u2.Image = "test_drive_main.png"
        let u3 : UserRole = UserRole()
        u3.Name = "Program & Incentives"
        u3.Image = "programs_incentives.png"
        let u4 : UserRole = UserRole()
        u4.Name = "Customer Lookup"
        u4.Image = "customer_lookup.png"
        let u5 : UserRole = UserRole()
        u5.Name = "Alerts & Notifications"
        u5.Image = "alerts_icon.png"
        let u6 : UserRole = UserRole()
        u6.Name = "Dashboard"
        u6.Image = "dashboard.png"
        let u7 : UserRole = UserRole()
        u7.Name = "Reports"
        u7.Image = "reports.png"
        let u8 : UserRole = UserRole()
        u8.Name = "Settings"
        u8.Image = "settings_main.png"
        let u9 : UserRole = UserRole()
        u9.Name = "Zones"
        u9.Image = "zones_geofence.png"
        let u10 : UserRole = UserRole()
        u10.Name = "Vehicle Diagnostics"
        u10.Image = "diagnostics_1.png"
        let u11 : UserRole = UserRole()
        u11.Name = "Dealer Fleet"
        u11.Image = "dealer_fleet.png"
        let u12 : UserRole = UserRole()
        u12.Name = "Delivery Activity"
        u12.Image = "delivery_activity.png"
        let u13 : UserRole = UserRole()
        u13.Name = "Live Fleet"
        u13.Image = "live.png"
        let u14 : UserRole = UserRole()
        u14.Name = "Pdi"
        u14.Image = "pdi.png"
        let u15 : UserRole = UserRole()
        u15.Name = "Admin"
        u15.Image = "admin.png"
        
        list += [u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15]
        
        return list
        
        
    }
    
    public static func generateGeofences() -> [Geofence]
    {
        var list = [Geofence]()
        
        let g1 = Geofence()
        g1.GeofenceName = "Kukatpally, Hyderabad, Telangana, India"
        g1.Radius = 5000
        g1.GeofenceType = "Circle"
        
        let g2 = Geofence()
        g2.GeofenceName = "GF_Warangal"
        g2.Radius = 0
        g2.GeofenceType = "Polygon"
        
        let g3 = Geofence()
        g3.GeofenceName = "KBHP, Hyderabad, Telangana, India"
        g3.Radius = 350
        g3.GeofenceType = "Circle"
        
        let g4 = Geofence()
        g4.GeofenceName = "HI Tech, Hyderabad, Telangana, India"
        g4.Radius = 700
        g4.GeofenceType = "Circle"
        
        let g5 = Geofence()
        g5.GeofenceName = "GF_GUNTUR"
        g5.Radius = 0
        g5.GeofenceType = "Polygon"
        
        
        list += [g1,g2,g3,g4,g5]
        
        return list
        
    }
    
}
