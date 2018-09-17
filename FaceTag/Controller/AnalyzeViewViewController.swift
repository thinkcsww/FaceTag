//
//  AnalyzeViewViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 12..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit
import Firebase

class AnalyzeViewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var faceDetectionView: UIView!
    @IBOutlet weak var imageLabelingView: UIView!
    @IBOutlet weak var analyzeButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    var transferredImage: UIImage?
    var faceImage: VisionImage?
    lazy var vision = Vision.vision()
    let options = VisionFaceDetectorOptions()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting ImagePicker
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        
        //Round the edge of the ui
        roundingUi()
        //When image is taken put it into the circle container
        processTakenImage()
        
        
        options.landmarkType = .all
        options.classificationType = .all
        options.modeType = .accurate
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            faceImage = VisionImage(image: pickedImage)
            photoButton.setImage(pickedImage.resizedImage(newSize: CGSize(width: 82, height: 82)), for: .normal)
            photoButton.layer.cornerRadius = photoButton.frame.size.width / 2
            photoButton.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func analyzeButton(_ sender: Any) {
        let faceDetector = vision.faceDetector(options: options)
//        faceImage = VisionImage(image: UIImage(named: "profileImage")!)
        print("Face Detector Working")
        faceDetector.detect(in: faceImage!) { (features, error) in
            guard error == nil, let features = features, !features.isEmpty else {
                print(error?.localizedDescription)
                return
            }
            for feature in features {
                print("Happiness is \(feature.smilingProbability)")
                print("Happiness is \(feature.rightEyeOpenProbability)")
            }
        }
        
        
        
//        performSegue(withIdentifier: "goToRealAnalyzeView", sender: self)
    }
    @IBAction func photoButton(_ sender: Any) {
        let alert = UIAlertController(title: "사진입력", message: "방법을 선택해주세요.", preferredStyle: .alert)
        
        let takePhotoAction = UIAlertAction(title: "촬영", style: .default) { (alert: UIAlertAction!) in
            self.performSegue(withIdentifier: "goToPhotoView", sender: nil)
        }
        
        let pickPhotoAction = UIAlertAction(title: "가져오기", style: .default) { (alert: UIAlertAction!) in
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        alert.addAction(takePhotoAction)
        alert.addAction(pickPhotoAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //Round the edge of the ui
    func roundingUi() {
        faceDetectionView.layer.cornerRadius = 5.0
        imageLabelingView.layer.cornerRadius = 5.0
        analyzeButton.layer.cornerRadius = 5.0
    }
    
    func processTakenImage() {
        if let takenImage = self.transferredImage as UIImage? {
            faceImage = VisionImage(image: takenImage)
            
            photoButton.setImage(takenImage.resizedImage(newSize: CGSize(width: 82, height: 82)), for: .normal)
            photoButton.layer.cornerRadius = photoButton.frame.size.width / 2
            photoButton.clipsToBounds = true
//            photoButton.transform.rotated(by: CGFloat(Double.pi/4))
            
        }
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

