//
//  ProfileControllerViewController.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 06/04/2024.
//

import UIKit

class ProfileControllerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sss(_ sender: UIButton) {
        
        print("nawa")
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
        
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
