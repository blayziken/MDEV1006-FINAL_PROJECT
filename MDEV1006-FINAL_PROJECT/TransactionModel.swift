//
//  TransactionModel.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 02/04/2024.
//

import Foundation

struct TransactionModel: Identifiable, Decodable, Hashable {
    var amount: Int
    var category: String
    var id: String
    var note: String
    var type: String
    var userId: String
    var date: String
}
