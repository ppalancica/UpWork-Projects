//
//  LoadinIndicatorCell.swift
//  Reddit-Prototype-iOS
//
//  Created by Pavel Palancica on 12/11/20.
//

import UIKit

class LoadingTableViewCell: UITableViewCell
{
    static let identifier = String(describing: LoadingTableViewCell.self)
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let loaderView = UIActivityIndicatorView()
        loaderView.style = .large
        return loaderView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(activityIndicatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

// MARK: - Helper methods

extension LoadingTableViewCell
{
    func setupConstraints() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
}
