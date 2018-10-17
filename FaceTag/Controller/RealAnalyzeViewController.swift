//
//  RealAnalyzeViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 12..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit
import Firebase

class RealAnalyzeViewController: UIViewController {
    
    lazy var vision = Vision.vision()
    
    let labelDetectorOptions = VisionLabelDetectorOptions(confidenceThreshold: 0.5)
    
    var images: [UIImage] = []
    var labels = [String : Int]()
    var labelImage: VisionImage?
    var happiness: CGFloat?
    
    var oneImagePercentace : Double?
    var percentage = 0.0
    
    
    @IBOutlet weak var percentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneImagePercentace = 100.0 / Double(images.count)
        
        for i in 0 ..< images.count {
    
            labelImage = VisionImage(image: images[i])
            imageLabeling()
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAnalyFinishView" {
            let previewVC = segue.destination as! AnalyzeFinishViewController
            previewVC.imageNum = self.images.count
            previewVC.labels = self.labels
            previewVC.happiness = self.happiness
        }
    }
    
    private func imageLabeling() {
        let labelDetector = vision.labelDetector(options: labelDetectorOptions)
        labelDetector.detect(in: self.labelImage!) { (features, error) in
            guard error == nil, let features = features, !features.isEmpty else {
                self.percentage = Double(self.percentage) + self.oneImagePercentace!
                self.percentLabel.text = "\(self.percentage)%"
                print(error?.localizedDescription as Any)
                return
            }
            for label in features {
                if self.labels[label.label] == nil {
                    self.labels[label.label] = 1
                } else {
                    self.labels[label.label] = self.labels[label.label]! + 1
                }
            }
            
            self.percentage = self.percentage + self.oneImagePercentace!
            self.percentLabel.text = "\(self.percentage.rounded(.towardZero))%"
            if(self.percentage >=  99 ) {
                self.percentLabel.text = "100%"
                let alert = UIAlertController(title: "알림", message: "분석이 완료되었습니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: { (alert : UIAlertAction!) in
                    self.performSegue(withIdentifier: "goToAnalyFinishView", sender: self)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            print(self.labels)
            print(self.percentage)
        }
    }
    


}
