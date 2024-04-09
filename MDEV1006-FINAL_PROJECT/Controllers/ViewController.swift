//
//  ViewController.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 01/04/2024.
//

import UIKit

// LOGIN CONTROLLER

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    //MARK:- ACTIONS
    
    @IBAction func loginAction(_ sender: UIButton) {
        print("Login called")
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! tabBarController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        print("Sign up called")
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! tabBarController
        self.navigationController?.pushViewController(storyboard, animated: true)
 
    }
    
    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        print("did tap image view", sender)
    }
    
    
}

