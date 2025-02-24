//
//  ItemTableViewCell.swift
//  ShoppingListApp
//
//  Created by Christian Do on 2/22/25.
//

import UIKit

// Define a protocol to communicate with the view controller
protocol ItemTableViewCellDelegate: AnyObject {
    func itemTableViewCell(_ cell: ItemTableViewCell, didTapAddWithQuantity quantity: Int)
}

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityTextField: UITextField!  // Outlet for the text field
    
    weak var delegate: ItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Styling for the add button
        addButton.layer.cornerRadius = 5
        addButton.clipsToBounds = true
        // Set default content mode for the image view
        productImageView.contentMode = .scaleAspectFit
        
        // Set default value for quantity text field
        quantityTextField.text = "1"
        quantityTextField.keyboardType = .numberPad  // Allows only numeric input
    }
    
    func configure(with item: ShoppingItem) {
        nameLabel.text = item.name
        priceLabel.text = String(format: "$%.2f", item.price)
        productImageView.image = UIImage(named: item.imageName)
        productImageView.contentMode = .scaleAspectFit  // Ensures proper scaling
        productImageView.clipsToBounds = true  // Prevents overflow
    }
    
    // Action for the add button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        // Read the quantity from the text field
        let quantityText = quantityTextField.text ?? "1"
        let quantity = Int(quantityText) ?? 1  // Fallback to 1 if conversion fails
        delegate?.itemTableViewCell(self, didTapAddWithQuantity: quantity)
    }
}
