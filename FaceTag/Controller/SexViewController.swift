//
//  SexViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 17/10/2018.
//  Copyright © 2018 SunWoong Choi. All rights reserved.
//

import UIKit
import Firebase

class SexViewController: UIViewController {

    var userDB: Firestore? = nil
    let userId = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDB = Firestore.firestore()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func menButton(_ sender: Any) {
        
        userDB?.collection("User").document(userId).setData([
            "sex": "m"
        ]) { err in
            if let err = err {
                print("Sex data saving error \(err)")
            } else {
                self.performSegue(withIdentifier: "goToAnalyzeView2", sender: self)
                print("Sex save success")
            }
        }
        
    }
    
    @IBAction func womenButton(_ sender: Any) {
        userDB?.collection("User").document(userId).setData([
            "sex": "w"
        ]) { err in
            if let err = err {
                print("Sex data saving error \(err)")
            } else {
                self.performSegue(withIdentifier: "goToAnalyzeView2", sender: self)
                print("Sex save success")
            }
        }
    }
    
}
