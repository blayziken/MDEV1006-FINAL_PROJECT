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

import UIKit

class homeViewController: UIViewController, UITableViewDelegate {
    
    @Published var transactions: [TransactionModel] = []
    var db: Firestore!
    @IBOutlet weak var transactionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cell class
//        transactionTableView.register(UINib(nibName: "transactionTableViewCell", bundle: nil), forCellReuseIdentifier: "transactionCell")
//
        transactionTableView.register(transactionTableViewCell.self, forCellReuseIdentifier: "transactionCell")

        // Set up table view
        transactionTableView.dataSource = self
        
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
                    
                    let amount = data["amount"] as? Int ?? 0
                    let category = data["category"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)
                let transaction = transactions[indexPath.row]
                // Configure the cell with transaction data
                // For example:
                cell.textLabel?.text = "\(transaction.amount) - \(transaction.category)"
                return cell
        
//        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! transactionTableViewCell
//        
//        // Configure the cell with transaction data
//        let transaction = transactions[indexPath.row]
//        cell.titleLabel.text = transaction.category
////        cell.amountLabel.text = "+CAD \(transaction.amount)"
////        cell.dateLabel.text = transaction.date
////        cell.jobLabel.text = transaction.category
//        
//        return cell
    }
}
