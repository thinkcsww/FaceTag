//
//  AnalyzeViewViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 12..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit

class AnalyzeViewViewController: UIViewController {

    @IBOutlet weak var faceDetectionView: UIView!
    @IBOutlet weak var imageLabelingView: UIView!
    @IBOutlet weak var analyzeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        faceDetectionView.layer.cornerRadius = 5.0
        imageLabelingView.layer.cornerRadius = 5.0
        analyzeButton.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func analyzeButton(_ sender: Any) {
        performSegue(withIdentifier: "goToRealAnalyzeView", sender: self)
    }
    

}
