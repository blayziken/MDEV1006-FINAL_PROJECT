//
//  TransactionItemView.swift
//  MDEV1006-FINAL_PROJECT
//
//  Created by Blaze on 01/04/2024.
//

import UIKit

class TransactionItemView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 10
        
        layer.shadowColor = UIColor(red: 0.403, green: 0.394, blue: 0.867, alpha: 0.3).cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 4)
    }
    
    // Closure to be called when the view is tapped
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call the setupTapGesture method in the initializer
        setupTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Call the setupTapGesture method in the required initializer
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        // Create a UITapGestureRecognizer instance
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // Add the tap gesture recognizer to the custom view
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        // Call the onTap closure when the view is tapped
        onTap?()
    }
}
