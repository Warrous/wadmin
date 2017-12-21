//
//  Constants.swift
//  wadmin
//
//  Created by Gokul on 12/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//
import Foundation

public class Constants
{
    public static let NO_INTERNET_CONNECTION : String = "No internet connection"
    
    public static let NETWORK_ERROR : String  = "Network Error"
    
    public static let ACCESS_TOKEN : String = "access_token"
    
    public static let EXPIRES_IN : String = "expires_in"
    
    public static let TOKEN_TYPE : String = "token_type"
    
    public static let USER_TYPE : String = "user_type"
    
    public static let USER_ROLL_NAME : String = "user_roll_name"
    
    public static let USER_ROLL_TYPE : String = "user_roll_type"
    
    public static let USER_NAME : String = "user_name"
    
    public static let COMPLETE_USERNAME : String = "complete_username"
    
    public static let FIRST_NAME : String = "first_name"
    
    public static let LAST_NAME : String = "last_name"
    
    public static let  PAYLOAD : String  = "pay_load"
    
    public static let LOGIN : String = "login"
    
    public static let SERVER_URL : String = "http://13.59.34.59:8080/"
    
    public static let URL_LOGIN : String =  SERVER_URL + "warrous.ms.auth/warrous.ms.auth.api/api/user/login"
    
    public static let POST : String = "POST"
    
    public static let GET : String = "GET"
    
    public static let SUPER_ADMIN  : String = "SuperAdmin"
    
    public static let GENERAL_MANAGER  : String = "GeneralManager"
    
    public static let VEHICLE_SERVICE_TECHNICIAN  : String = "VehicleServiceTechnician"
    
    public static let SALES_PERSON  : String = "SalesPerson"
    
    public static let VEHICLE_SALES_MANAGER  : String = "VehicleSalesManager"
    
    public static let DEALER_DB  : String = "dealer_db"
    
    public static let ROUTE_SOURCE : String = "WaterFront Park, Sandiego"
    
    public static let ROUTE_DESTINATION : String = "NationalCity, Sandiego"
    
    public static let DEALER_ID  : String = "dealerid"
    
    public static let GOOGLE_MAPS_API : String = "AIzaSyCwHqcp-MYPCz-7xMYiJndYVcDCJ448Vto"
    
    public static let GOOGLE_PLACES_API : String  = "AIzaSyAIdbqyogIAB7cCWBx4-NRoIC8wtqgxuXM"
    
    public static let INTRO_HEADINGS : [String] = ["Get Started","Bluetooth","OBD Adapter","Multiple Cars","Track your trips"]
    
    public static let INTRO_HEADING_LABEL : [String] = ["Do you have the OBD 2 adapter?\n\nIt Connects to your mobile app!\n","Connect to your Bluetooth wireless\n\nOBD 2 uses Bluetooth to tahe to your car\n",
                                                       "Connect to your Bluetooth wireless\n\nOBD 2 uses Bluetooth to tahe to your car\n","Set up another car\n\nyou need one OBD 2 Adapter for each car.\n","And weekly drive score\nThe app gives you more information"]
    public static let INTRO_IMAGES : [String] = ["screen1.png","screen2.png","screen3.png","screen4.png","screen5.png"]
    
    public static let URL_FETCH_GEOFENCE : String = SERVER_URL +  "warrous.ms.obdm/warrous.ms.obdm.api/api/Vehicle/GetGeofences"
    
    public static let URL_FETCH_ALERTS_BASED_ON_CATEGORY : String = SERVER_URL  + "warrous.ms.obdm/warrous.ms.obdm.api/api/Vehicle/GetAlertsListByCateogyId"
    
    public static let URL_FETCH_REPORTS_BASED_ON_DEALER_ID = SERVER_URL + "warrous.ms.org/warrous.ms.org.api/api/org/ReportsByDealerId"
    
    public static let URL_FETCH_OEM_PROGRAMS = SERVER_URL + "warrous.ms.campaigns/warrous.ms.campaigns.api/api/camp/GetPrograms"
    
    public static let URL_FETCH_VEHCILES_BASED_ON_DEALER_ID  = SERVER_URL + "warrous.ms.obdm/warrous.ms.obdm.api/api/Vehicle/GetVehicleDetailsWithParameters" //MakeId=-1&ModelId=-1&YearId=-1&TypeId=
    
    public static let URL_SAMPLE_CAR_SEDAN = "https://www.liahondaofenfield.com/assets/stock/expanded/white/640/2015che026c_640/2015che026c_640_01.jpg"
    
    public static let URL_SAMPLE_CUSTOMER_IMAGE = "https://d2e70e9yced57e.cloudfront.net/wallethub/posts/29912/eric-klinenberg.jpg"
    
    public static let URL_FETCH_CUSTOMERS = SERVER_URL + "warrous.ms.consumer/warrous.ms.consumer.api/api/Consumer/CustomersList"
    
    public static let URL_DELIVERY_TRUCKS = SERVER_URL + "warrous.ms.obdm/warrous.ms.obdm.api/api/Vehicle/GetTransitTruckVehicleDetails"
    
    
    
    
   
    
}
