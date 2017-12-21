//
//  FirstViewController.swift
//  wadmin
//
//  Created by Gokul on 12/12/17.
//  Copyright © 2017 warrous. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tvFirstView: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tvFirstView.text = Constants.NO_INTERNET_CONNECTION
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

