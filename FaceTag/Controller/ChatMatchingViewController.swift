//
//  ChatMatchingViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 17/10/2018.
//  Copyright © 2018 SunWoong Choi. All rights reserved.
//
import Foundation
import UIKit

class ChatMatchingViewController: UIViewController {

    @IBOutlet weak var tagMatchingView: UIView!
    @IBOutlet weak var moodMatchingView: UIView!
    
    @IBOutlet weak var moodButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundUI()
        

    }
    
    
    @IBAction func tagButton(_ sender: Any) {
        performSegue(withIdentifier: "goToChatRoomView", sender: self)
    }
    
    @IBAction func moodButton(_ sender: Any) {
        print("bye")
    }
    
    func roundUI() {
        print("im working man")
        tagMatchingView.layer.cornerRadius = 10.0
        moodMatchingView.layer.cornerRadius = 10.0
        tagMatchingView.clipsToBounds = true
        moodMatchingView.clipsToBounds = true
    }
    


}
