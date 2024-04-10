//
//  SignUpViewController.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 09/04/2024.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- ACTIONS
    @IBAction func signUpAction(_ sender: UIButton) {
        print("Sign up called")
        
        guard !emailField.text!.isEmpty && !passwordField.text!.isEmpty else {
            print("Email or password is empty")
            return
        }
            
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { [self] result, error in
            print("Email - \(emailField.text!)")
            print("Password - \(passwordField.text!)")
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! tabBarController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
    }
}
