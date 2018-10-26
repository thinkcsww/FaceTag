//
//  SignUpViewController.swift
//  FaceTag
//
//  Created by SunWoong Choi on 22/10/2018.
//  Copyright © 2018 SunWoong Choi. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.becomeFirstResponder()

    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let auth = Auth.auth()
        let id = idTextField.text!
        let password = passwordTextField.text!
        print(id)
        auth.createUser(withEmail: id, password: password, completion: { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "goToSexView", sender: self)
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
