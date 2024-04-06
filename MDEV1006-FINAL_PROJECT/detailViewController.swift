//
//  detailViewController.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 04/04/2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class detailViewController: UIViewController {
    var transaction: TransactionModel?
    
    //MARK: IB OUTLETS
    @IBOutlet weak var transactionAmount: UITextField!
    @IBOutlet weak var transactionNote: UITextField!
    @IBOutlet weak var transactionCategory: UITextField!
    @IBOutlet weak var transactionDate: UITextField!
    
    //MARK: IB ACTIONS
    
    //Edit transaction in database
    @IBAction func editBtn(_ sender: UIButton) {
        // Ensure transaction is not nil
        guard let transaction = transaction else {
            self.showErrorAlert()
            return
        }
        
        let amount = Double(transactionAmount.text ?? "0")
        
        var transactionData = [
            "amount": amount as Any,
            "note": transactionNote.text ?? "",
            "category": transactionCategory.text ?? "",
            "date": transactionDate.text ?? ""
        ]
        
        // Update the document in the collection
        let db = Firestore.firestore()
        let transactionRef = db.collection("transactions").document(transaction.id)
        
        transactionRef.updateData(transactionData) { error in
            if let error = error {
                print("Error updating document: \(error)")
                self.showErrorAlert()
            } else {
                print("Document successfully updated")
                self.showSuccessAlert()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let transaction = transaction {
            print("Firebase ID = \(transaction.id)")
            transactionAmount.text = String(transaction.amount)
            transactionNote.text = transaction.note
            transactionCategory.text = transaction.category
            transactionDate.text = transaction.date
        }
    }
    
    // Helper method to show success alerts
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
