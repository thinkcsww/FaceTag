//
//  showPhotoViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 15..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit

class showPhotoViewController: UIViewController {
    
    var image: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let takenImage = image {
            imageView.image = takenImage
            imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAnalyzeView" {
            let previewVC = segue.destination as!
            AnalyzeViewViewController
            previewVC.image = image
        }
    }
    @IBAction func completeButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAnalyzeView", sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
