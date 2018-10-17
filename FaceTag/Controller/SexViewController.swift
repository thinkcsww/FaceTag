//
//  SexViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 17/10/2018.
//  Copyright © 2018 SunWoong Choi. All rights reserved.
//

import UIKit

class SexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func menButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAnalyzeView2", sender: self)
    }
    
    @IBAction func womenButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAnalyzeView2", sender: self)
    }
    
}
