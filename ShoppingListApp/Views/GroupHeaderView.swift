import UIKit

protocol GroupHeaderViewDelegate: AnyObject {
    func didTapExpandCollapse(in section: Int)
}

class GroupHeaderView: UITableViewHeaderFooterView {
    var titleLabel: UILabel!
    var itemCountLabel: UILabel!
    var expandCollapseButton: UIButton!
    var groupIconImageView: UIImageView!
    
    var section: Int = 0
    weak var delegate: GroupHeaderViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Change the header background color
        contentView.backgroundColor = UIColor.systemBlue
        
        // Configure group icon (you can use any image for the group icon)
        groupIconImageView = UIImageView()
        groupIconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(groupIconImageView)
        
        // Configure titleLabel (group name)
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        
        // Configure item count label
        itemCountLabel = UILabel()
        itemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        itemCountLabel.textColor = .green // Set a different color for item count
        contentView.addSubview(itemCountLabel)
        
        // Configure expand/collapse button (3 dots)
        expandCollapseButton = UIButton(type: .system)
        expandCollapseButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(systemName: "ellipsis") {
            expandCollapseButton.setImage(image, for: .normal)
            expandCollapseButton.tintColor = .white
        }
        contentView.addSubview(expandCollapseButton)
        
        // Add constraints for layout
        NSLayoutConstraint.activate([
            // Group icon
            groupIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            groupIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            groupIconImageView.widthAnchor.constraint(equalToConstant: 30),
            groupIconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            // Title label (group name)
            titleLabel.leadingAnchor.constraint(equalTo: groupIconImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: expandCollapseButton.leadingAnchor, constant: -10),
            
            // Item count label
            itemCountLabel.leadingAnchor.constraint(equalTo: groupIconImageView.trailingAnchor, constant: 10),
            itemCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            itemCountLabel.trailingAnchor.constraint(equalTo: expandCollapseButton.leadingAnchor, constant: -10),
            
            // Expand/collapse button (3 dots)
            expandCollapseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            expandCollapseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            expandCollapseButton.widthAnchor.constraint(equalToConstant: 30),
            expandCollapseButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Setup button action
        expandCollapseButton.addTarget(self, action: #selector(expandCollapseTapped(_:)), for: .touchUpInside)
    }
    
    @objc func expandCollapseTapped(_ sender: UIButton) {
        delegate?.didTapExpandCollapse(in: section)
    }
    
    func configure(with groupName: String, itemCount: Int, icon: UIImage?) {
        titleLabel.text = groupName
        itemCountLabel.text = "Items: \(itemCount)"
        groupIconImageView.image = icon
    }
}

