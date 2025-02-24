import Foundation
import UIKit


// MARK: - HomeViewController

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Sample data for demonstration
    var groups: [ShoppingGroup] = ShoppingData.groups
    
    // A cart dictionary storing items and their quantities.
    var cart: [ShoppingItem: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "HOME"
        
        // Register the class for the header view (no NIB required)
        tableView.register(GroupHeaderView.self, forHeaderFooterViewReuseIdentifier: "GroupHeaderView")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups[section].isExpanded ? groups[section].items.count : 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        let group = groups[indexPath.section]
        let item = group.items[indexPath.row]
        
        // Configure the cell
        cell.configure(with: item)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "GroupHeaderView") as? GroupHeaderView else {
            print("Failed to dequeue header view")
            return nil
        }
        
        let group = groups[section]
        let icon = UIImage(named: group.iconName) // Assuming the icon name is in the group data
        header.configure(with: group.name, itemCount: group.items.count, icon: icon)
        header.titleLabel.numberOfLines = 2  // Allow for two lines
        header.section = section
        header.delegate = self
        
        return header
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0 // Increased height to accommodate two lines in the header
    }
}

// MARK: - GroupHeaderViewDelegate

extension HomeViewController: GroupHeaderViewDelegate {
    func didTapExpandCollapse(in section: Int) {
        // Preserve all properties, including iconName
        groups[section] = ShoppingGroup(name: groups[section].name,
                                        items: groups[section].items,
                                        iconName: groups[section].iconName, // Keep the iconName
                                        isExpanded: !groups[section].isExpanded)
        
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

// MARK: - ItemTableViewCellDelegate

extension HomeViewController: ItemTableViewCellDelegate {
    func itemTableViewCell(_ cell: ItemTableViewCell, didTapAddWithQuantity quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let item = groups[indexPath.section].items[indexPath.row]
        cart[item] = (cart[item] ?? 0) + quantity
        
        // Update badge on the cart tab (assuming it's at index 3)
        if let tabItems = self.tabBarController?.tabBar.items, tabItems.count > 3 {
            let cartTabItem = tabItems[3]
            let totalQuantity = cart.values.reduce(0, +)
            cartTabItem.badgeValue = totalQuantity > 0 ? "\(totalQuantity)" : nil
        }
        
        // Show confirmation alert
        let alert = UIAlertController(title: "Added to Cart",
                                      message: "\(item.name) (\(quantity)) was added to your cart.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

