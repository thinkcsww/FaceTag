//
//  ViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 2018. 9. 3..
//  Copyright © 2018년 SunWoong Choi. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.idTextField.delegate = self
//        self.passwordTextField.delegate = self
//        do {
//            try Auth.auth().signOut()
//        } catch {
//
//        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goToAnalyzeView", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        let auth = Auth.auth()
        let id = idTextField.text!
        let password = passwordTextField.text!
        print(id)
        auth.createUser(withEmail: id, password: password, completion: { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "goToAnalyzeView", sender: self)
            } else {
                if let myError = error?.localizedDescription {
                    print(myError)
                } else {
                    print("ERROR");
                }
        
            }
        })
    }
    

}

