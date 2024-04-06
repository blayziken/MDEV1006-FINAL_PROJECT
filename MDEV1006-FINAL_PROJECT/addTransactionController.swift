//
//  km.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 02/04/2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class addTransactionController: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var amountOutlet: UITextField!
    @IBOutlet weak var noteOutlet: UITextField!
    @IBOutlet weak var categoryOutlet: UITextField!
    @IBOutlet weak var dateOutlet: UITextField!
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    //MARK: IB ACTIONS
    
    // CREATE TRANSACTION DOCUMENT
    @IBAction func saveBtn(_ sender: UIButton) {
        
        var transactionData: [String: Any] = [
            "amount": Double(amountOutlet.text ?? "0") ?? 0,
            "note": noteOutlet.text ?? "",
            "category": categoryOutlet.text ?? "None",
            "date": dateOutlet.text ?? dateFormatter
        ]
        
        // Add transaction document to Firestore
        let transactionRef = db.collection("transactions").document()
        
        let documentID = transactionRef.documentID
        transactionData["id"] = documentID
        
        db.collection("transactions").document(documentID).setData(transactionData) { error in
            if let error = error {
                print("Error updating transaction with ID field: \(error.localizedDescription)")
                self.showErrorAlert()

            } else {
                print("Transaction updated with ID field successfully!")
                self.showSuccessAlert()
                self.clearFields()
            }
        }
    }
    
    @IBAction func clearBtn(_ sender: UIButton) {
        // CLEAR ALL FIELDS ON THE SCREEN
        self.clearFields()
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    // Helper method to clear all text fields
    private func clearFields() {
        amountOutlet.text = ""
        noteOutlet.text = ""
        categoryOutlet.text = ""
        dateOutlet.text = ""
    }
    
    // Helper method to show success alert
    private func showSuccessAlert() {
        let alertController = UIAlertController(title: "Success", message: "Transaction added successfully!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Something went wrong, please try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
