//
//  HomeViewController.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 01/04/2024.
//

import FirebaseCore
import UIKit
import Firebase
import FirebaseFirestore

class homeViewController: UIViewController, UITableViewDelegate {
    
    @Published var transactions: [TransactionModel] = []
    var db: Firestore!
    @IBOutlet weak var transactionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionTableView.register(transactionTableViewCell.self, forCellReuseIdentifier: "transactionCell")
        
        // Set up table view
        transactionTableView.dataSource = self
        transactionTableView.delegate = self
        
        // FETCH TRANSACTIONS
        self.db = Firestore.firestore()
        let ref = db.collection("transactions")
        fetchTransactions(from: ref) { [weak self] transactions in
            // Update the transactions array
            self?.transactions = transactions
            // Reload table view to display the items based on transactions
            self?.transactionTableView.reloadData()
            print("Transactions fetched: \(transactions.count)")
        }
    }
    
    func fetchTransactions(from collectionRef: CollectionReference, completion: @escaping ([TransactionModel]) -> Void) {
        collectionRef.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion([])
                return
            }
            
            var fetchedTransactions: [TransactionModel] = []
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    var amount: Double = 0
                    
                    // handling the case where amount might be a string
                    if let amountValue = data["amount"] {
                        if let amountDouble = amountValue as? Double {
                            amount = amountDouble
                        } else if let amountString = amountValue as? String, let amountDouble = Double(amountString) {
                            amount = amountDouble
                        }
                    }
                    
                    let category = data["category"] as? String ?? ""
                    let id = data["id"] as? String ?? "" // Firebase id
                    let note = data["note"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let userId = data["userId"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    
                    let transaction = TransactionModel(amount: amount, category: category, id: id, note: note, type: type, userId: userId, date: date)
                    
                    fetchedTransactions.append(transaction)
                }
                // Call the completion handler with fetched transactions
                completion(fetchedTransactions)
            } else {
                completion([])
            }
        }
    }
}

extension homeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    // Display each transaction cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)
        let transaction = transactions[indexPath.row]
    
        let formattedAmount: String
        if transaction.amount.truncatingRemainder(dividingBy: 1) == 0 {
            // If the amount is an integer, remove the decimal part
            formattedAmount = String(format: "%.0f", transaction.amount)
        } else {
            // If the amount is a double, keep it as is
            formattedAmount = String(transaction.amount)
        }
        
        cell.textLabel?.text = "\(formattedAmount) - \(transaction.category)"
        return cell
    }
}

extension homeViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected at index: \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedTransaction = transactions[indexPath.row]
        
        // Instantiate the detailViewController
        let detailController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        
        // Set the transaction property
        detailController.transaction = selectedTransaction
        
        // Push the detailViewController onto the navigation stack
        navigationController?.pushViewController(detailController, animated: true)

    }
}

