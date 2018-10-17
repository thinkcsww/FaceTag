//
//  AnalyzeViewViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 12..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit
import Firebase
import Photos

class AnalyzeViewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var faceDetectionView: UIView!
    @IBOutlet weak var imageLabelingView: UIView!
    @IBOutlet weak var analyzeButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    var transferredImage: UIImage?
    var photo: UIImage?
    var images: [UIImage] = []
    var faceImage: VisionImage?
    var labelImage: VisionImage?
    lazy var vision = Vision.vision()
    let faceDectectorOptions = VisionFaceDetectorOptions()
    let labelDetectorOptions = VisionLabelDetectorOptions(confidenceThreshold: 0.5)
    var happiness: CGFloat?
    var labels = [String : Int]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting ImagePicker
        print(labels)
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        
        //Round the edge of the ui
        roundingUi()
        //When image is taken put it into the circle container
        processTakenImage()
        
        
        faceDectectorOptions.landmarkType = .all
        faceDectectorOptions.classificationType = .all
        faceDectectorOptions.modeType = .accurate
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRealAnalyzeView" {
            let previewVC = segue.destination as! RealAnalyzeViewController
            previewVC.images = self.images
            previewVC.happiness = self.happiness
        }
    }
    
    @IBAction func analyzeButton(_ sender: Any) {
        
        
        
//        faceImage = VisionImage(image: UIImage(named: "profileImage")!)
        if faceImage == nil {
            let alert = UIAlertController(title: "알림", message: "분석할 사진을 선택해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            faceDetection()
            
            let alert = UIAlertController(title: "알림", message: "본 작업은 시간이 소요됩니다.\n진행하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (alert: UIAlertAction!) in
                self.GetAlbums()
                self.performSegue(withIdentifier: "goToRealAnalyzeView", sender: self)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
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
    func getAssets(fromCollection collection: PHAssetCollection) -> PHFetchResult<PHAsset> {
        let photosOptions = PHFetchOptions()
        photosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        photosOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
        
        return PHAsset.fetchAssets(in: collection, options: photosOptions)
    }
    
    private func faceDetection() {

        let faceDetector = vision.faceDetector(options: faceDectectorOptions)
        print("Face Detector Working")
        faceDetector.detect(in: self.faceImage!) { (features, error) in
            guard error == nil, let features = features, !features.isEmpty else {
                print(error?.localizedDescription as Any)
                return
            }
            for feature in features {
                self.happiness = feature.smilingProbability
                print("Happiness is \(feature.smilingProbability)")
                print("Happiness is \(feature.rightEyeOpenProbability)")
            }
        }
    }
    
    func GetAlbums() {
        // 앨범 fetch 옵션
        let fetchOptions:PHFetchOptions = PHFetchOptions()
        
        // 앨범들을 fetchedAlbums에 넣는다. ex) 모든사진, 슬로우모션, 스크린샷 앨범 등등이 있고 그중 모든 사진만 받아온다 -> subtype 참고
        let fetchedCollections : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: fetchOptions)
        
        let imageManager = PHCachingImageManager()
        
        fetchedCollections.enumerateObjects { (collection, _, _) in
            
            let result = self.getAssets(fromCollection: collection)
            print("\(String(describing: collection.localizedTitle)): \(result.count)")
            print(result.object(at: 0))
            
            // 원래 넣어야됨 for문 result.count -> 디버깅 빨리하려고 30으로 해놓은거 
            for i in 0 ..< 200 {
                let asset = result.object(at: i)
                imageManager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: nil) { (fetchedImage, _) in
                    // Face Detection 하려면 아래 PNG를 해줘야함
                    let imageData = UIImagePNGRepresentation(fetchedImage!)
                    let realImage = UIImage(data: imageData!)
//                    self.faceImage = VisionImage(image: finalImage!)
                    self.images.append(realImage!)
                    self.labelImage = VisionImage(image: realImage!)
//                    self.imageLabeling()
//                    print(self.labels)
                }
            }
            
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

