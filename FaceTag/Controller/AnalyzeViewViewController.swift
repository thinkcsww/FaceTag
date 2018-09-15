//
//  AnalyzeViewViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 12..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit

class AnalyzeViewViewController: UIViewController {

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var faceDetectionView: UIView!
    @IBOutlet weak var imageLabelingView: UIView!
    @IBOutlet weak var analyzeButton: UIButton!
    
    var image: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceDetectionView.layer.cornerRadius = 5.0
        imageLabelingView.layer.cornerRadius = 5.0
        analyzeButton.layer.cornerRadius = 5.0
        if let takenImage = image {
            
            photoButton.setImage(takenImage.resizedImage(newSize: CGSize(width: 82, height: 82)), for: .normal)
            photoButton.layer.cornerRadius = photoButton.frame.size.width / 2
            photoButton.clipsToBounds = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func analyzeButton(_ sender: Any) {
        performSegue(withIdentifier: "goToRealAnalyzeView", sender: self)
    }
    @IBAction func photoButton(_ sender: Any) {
        performSegue(withIdentifier: "goToPhotoView", sender: nil)
        
    }
    
    

}

extension UIImage {
    
    /// Returns a image that fills in newSize
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Returns a resized image that fits in rectSize, keeping it's aspect ratio
    /// Note that the new image size is not rectSize, but within it.
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
    
}

