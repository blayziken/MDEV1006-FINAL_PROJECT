//
//  TransactionTableViewCell.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 02/04/2024.
//

import UIKit

class transactionTableViewCell: UITableViewCell {
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//            super.init(style: style, reuseIdentifier: reuseIdentifier)
//            // Customize the appearance of the cell
//            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//            self.dateLabel?.textColor = UIColor.red
//            // Add additional customization as needed
//        }
//    
//    required init?(coder aDecoder: NSCoder) {
//           fatalError("init(coder:) has not been implemented")
//       }
    
    // Declare outlets for your UI elements
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var amountLabel: UILabel!
    @IBOutlet public weak var dateLabel: UILabel!
    @IBOutlet public weak var jobLabel: UILabel!
    // Customize initialization if necessary
}

