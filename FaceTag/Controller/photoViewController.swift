//
//  photoViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 15..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit
import AVFoundation


class photoViewController: UIViewController {

    
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPriviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoveySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoveySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = frontCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
        
    }
    
    func setupPreviewLayer() {
        cameraPriviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPriviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPriviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPriviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPriviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    
    @IBAction func photoButton(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShowPhotoView" {
            let previewVC = segue.destination as! showPhotoViewController
            previewVC.image = self.image
        }
    }
    
}

extension photoViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print("촬영완료")
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "goToShowPhotoView", sender: nil)
            
        }
    }
}
