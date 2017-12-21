//
//  ProgramsAndIncentivesViewController.swift
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

class ProgramsAndIncentivesViewController: BaseViewController , UICollectionViewDataSource, UICollectionViewDelegate {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let programCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramsCell", for: indexPath) as! ProgramsAndIncentivesCollectionViewCell
        
        programCell.tvProgramName.text = list[indexPath.row].ProgramName
        programCell.tvProgramAbout.text = list[indexPath.row].ProgramDescription
        programCell.view.layer.cornerRadius = 3
        programCell.view.clipsToBounds = true
        
        
        
        // geofenceCell.imgGeofence.tintColor = UIColor.white
        
        return programCell
    }
    
    public var uiActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiActivityIndicatorView.center = view.center
        uiActivityIndicatorView.isHidden = true
        view.addSubview(uiActivityIndicatorView)
        
        // geofenceCollectionView.refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        programsCollectionView.es.addPullToRefresh
            {
                [unowned self] in
                self.fetchPrograms()
                
                
            }
        
        self.fetchPrograms()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var programsCollectionView: UICollectionView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var list : [OemPrograms] = []
    
    
    public func fetchPrograms()
    {
        
        self.uiActivityIndicatorView.isHidden = false
        self.uiActivityIndicatorView.startAnimating()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let body = [ 
          
            "OrgId" : "4",
            "PortalName" : "Owner and Warranty Operations",
            "LangCode" : "eng"
            
        ]
        Alamofire.request(Constants.URL_FETCH_OEM_PROGRAMS, method: .get ,parameters: body, encoding: URLEncoding.default, headers: headers)
            .responseJSON
            { response in
                debugPrint(response)
                self.parseData(JSONData : response.data!)
                self.uiActivityIndicatorView.stopAnimating()
                self.programsCollectionView.es.stopPullToRefresh()
                // return response
        }
    }
    
    public func parseData(JSONData: Data)
    {
        let jsonArray = JSON(JSONData).array
        list = []
        for programJson in jsonArray!
        {
            let program = OemPrograms();
            program.ProgramId = programJson["ProgramId"].intValue
            program.ProgramName = programJson["ProgramName"].stringValue
            program.ProgramDescription = programJson["ProgramDescription"].stringValue
          
            
            list.append(program)
            
            
        }
        
        if list.count > 0
        {
            programsCollectionView.reloadData()
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
