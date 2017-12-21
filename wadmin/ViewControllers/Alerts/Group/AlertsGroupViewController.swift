//
//  AlertsGroupViewController.swift
//  wadmin
//
//  Created by Gokul on 20/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import UIKit
import PageMenu

class AlertsGroupViewController: UIViewController , CAPSPageMenuDelegate
{

   
    var controllerArray : [UIViewController] = []
    
    public var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
   
        
        let controller1 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller1.title = "Speed"
        controllerArray.append(controller1)
        let controller2 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller2.title = "Geofence"
        controllerArray.append(controller2)
        let controller3 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller3.title = "Mileage"
        controllerArray.append(controller3)
        
        let controller4 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller4.title = "Theft"
        controllerArray.append(controller4)
        
        let controller5 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller5.title = "Delivery"
        controllerArray.append(controller5)
        
        let controller6 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller6.title = "DTC"
        controllerArray.append(controller6)
        
        let controller7 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller7.title = "Billing"
        controllerArray.append(controller7)
        
        let controller8 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller8.title = "Vehicle"
        controllerArray.append(controller8)
        
        let controller9 : AlertsListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertsListViewController") as! AlertsListViewController
        controller9.title = "Customer Status"
        controllerArray.append(controller9)
        
        
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
           
            .scrollMenuBackgroundColor(UIColor(red:0.08, green:0.09, blue:0.17, alpha:1.0)),
          
            .selectionIndicatorColor(UIColor(red:1.00, green:0.39, blue:0.00, alpha:1.0)),
            .addBottomMenuHairline(false),
            .menuItemFont(UIFont(name: "Hiragino Sans w6", size: 18.0)!),
            
            .menuHeight(60.0),
            .menuMargin (25.0),
            .selectionIndicatorHeight(3.0),
            
            .menuItemWidthBasedOnTitleTextWidth(true),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.white),
           
            
           
            CAPSPageMenuOption.centerMenuItems(true)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
       
        
        // Optional delegate
        pageMenu!.delegate = self
        
        
         self.addChildViewController(self.pageMenu!)
      
        
      
        
        self.view.addSubview(pageMenu!.view)
    }
    
    
    func willMoveToPage(_ controller: UIViewController, index: Int)
    {
        print(" will move ",index)
        pageMenu?.moveToPage(index)
        pageMenu?.moveSelectionIndicator(index)
        
        let objectController = controller as! AlertsListViewController
        
        if index == 1
        {
            objectController.categoryId = "3"
        }
        else if index == 2
        {
            objectController.categoryId = "2"
        }
        else
        {
            objectController.categoryId = "\(index+1)"
        }
        
        
        
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int)
    {
        print(" did move ",index)
        
        
        
        
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

}
