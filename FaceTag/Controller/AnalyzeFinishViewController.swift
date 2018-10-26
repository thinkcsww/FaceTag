//
//  AnalyzeFinishViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 18..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit
import Firebase

class AnalyzeFinishViewController: UIViewController {
    
    @IBOutlet weak var resultExplainView: UIView!
    @IBOutlet weak var resultRankView: UIView!
    @IBOutlet weak var top1View: UIView!
    @IBOutlet weak var top2View: UIView!
    @IBOutlet weak var top3View: UIView!
    
    @IBOutlet weak var top1Label: UILabel!
    @IBOutlet weak var top2Label: UILabel!
    @IBOutlet weak var top3Label: UILabel!
    
    @IBOutlet weak var top1ValueLabel: UILabel!
    @IBOutlet weak var top2ValueLabel: UILabel!
    @IBOutlet weak var top3ValueLabel: UILabel!
    
    var labels = [String : Int]()
    let userId = Auth.auth().currentUser!.uid
    var happiness: CGFloat?
    var imageNum: Int?
    var labelDB: Firestore? = nil
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // save status that this user is already analyzed.
        userDefaults.set(true, forKey: Constants.labeled)
        // Assign labels value
        assignLabelsValue()
        // Make View Corner Round
        roundUI()
        //Save
        saveLabelsInDB()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func assignLabelsValue() {
        
        let labelSorted = labels.sorted(by: { $0.value > $1.value })
        
        top1Label.text? = labelSorted[0].key
        top2Label.text? = labelSorted[1].key
        top3Label.text? = labelSorted[2].key
        
        top1ValueLabel.text? = "\(labelSorted[0].value)"
        top2ValueLabel.text? = "\(labelSorted[1].value)"
        top3ValueLabel.text? = "\(labelSorted[2].value)"
        
    }
    private func saveLabelsInDB() {
        labelDB = Firestore.firestore()
        labelDB?.collection("Label").document(userId).setData(labels) { err in
            if let err = err {
                print("Error writing document \(err)")
            } else {
                print("Document writing success")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAnalyzeChartView" {
            let previewVC = segue.destination as! AnalyzeChartViewController
            previewVC.labels = self.labels
            previewVC.imageNum = self.imageNum
        }
    }
    @IBAction func moreButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAnalyzeChartView", sender: self)
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        let mainTabBarController = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        present(mainTabBarController, animated: true, completion: nil)
        
    }
    func roundUI() {
        resultExplainView.layer.cornerRadius = 5.0
        resultRankView.layer.cornerRadius = 5.0
        top1View.layer.cornerRadius = 5.0
        top2View.layer.cornerRadius = 5.0
        top3View.layer.cornerRadius = 5.0
    }
    


}
