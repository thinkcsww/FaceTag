//
//  AnalyzeFinishViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 18..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit

class AnalyzeFinishViewController: UIViewController {
    
    @IBOutlet weak var resultExplainView: UIView!
    @IBOutlet weak var resultRankView: UIView!
    @IBOutlet weak var top1View: UIView!
    @IBOutlet weak var top2View: UIView!
    @IBOutlet weak var top3View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make View Corner Round
        roundUI()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func moreButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAnalyzeChartView", sender: self)
    }
    
    func roundUI() {
        resultExplainView.layer.cornerRadius = 5.0
        resultRankView.layer.cornerRadius = 5.0
        top1View.layer.cornerRadius = 5.0
        top2View.layer.cornerRadius = 5.0
        top3View.layer.cornerRadius = 5.0
    }
    


}
