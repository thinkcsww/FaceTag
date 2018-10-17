//
//  ProfileViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 17/10/2018.
//  Copyright © 2018 SunWoong Choi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var chartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundUi()
        // Do any additional setup after loading the view.
    }
    
    func roundUi() {
        resultView.layer.cornerRadius = 10.0
        chartView.layer.cornerRadius = 10.0
        resultView.clipsToBounds = true
        chartView.clipsToBounds = true
    }
    


}
