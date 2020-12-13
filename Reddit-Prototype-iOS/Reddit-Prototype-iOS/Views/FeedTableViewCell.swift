//
//  FeedTableViewCell.swift
//  Reddit-Prototype-iOS
//
//  Created by Pavel Palancica on 12/11/20.
//

import UIKit
import Nuke

private struct PaddingConstants
{
    static let top: CGFloat = 0.0
    static let left: CGFloat = 20.0
    static let right: CGFloat = 20.0
}

private struct HeightConstants
{
    static let titleLabelHeight: CGFloat = 80.0
    static let socialStatsViewHeight: CGFloat = 60.0
    static let separatorViewHeight: CGFloat = 12.0
    static let defaultImageHeight: CGFloat = 200.0
}

class FeedTableViewCell: UITableViewCell
{
    static let identifier = String(describing: FeedTableViewCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    private lazy var socialStatsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    private lazy var commentsNumberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    private lazy var bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 235.0 / 255.0,
                                       green: 235.0 / 255.0,
                                       blue: 235.0 / 255.0, alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(thumbnailImageView)
        
        contentView.addSubview(socialStatsView)
        socialStatsView.addSubview(scoreLabel)
        socialStatsView.addSubview(commentsNumberLabel)
        
        contentView.addSubview(bottomSeparatorView)
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
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: PaddingConstants.top),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: PaddingConstants.left),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: -PaddingConstants.right),
            titleLabel.heightAnchor.constraint(equalToConstant: HeightConstants.titleLabelHeight)
        ])
        
        // Thumbnail Image View
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //constant: PaddingConstants.top
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: socialStatsView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                        constant: PaddingConstants.left),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                         constant: -PaddingConstants.right)
        ])
        
        // Social Stats View
        socialStatsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            socialStatsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                     constant: PaddingConstants.left),
            socialStatsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                   constant: -PaddingConstants.right),
            socialStatsView.bottomAnchor.constraint(equalTo: bottomSeparatorView.topAnchor),
            socialStatsView.heightAnchor.constraint(equalToConstant: HeightConstants.socialStatsViewHeight)
        ])
        
        // Score Label
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: socialStatsView.leadingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: socialStatsView.topAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: socialStatsView.bottomAnchor)
        ])

        // Coments Number Label
        commentsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            commentsNumberLabel.trailingAnchor.constraint(equalTo: socialStatsView.trailingAnchor),
            commentsNumberLabel.topAnchor.constraint(equalTo: socialStatsView.topAnchor),
            commentsNumberLabel.bottomAnchor.constraint(equalTo: socialStatsView.bottomAnchor)
        ])
        
        // Bottom Separator View
        bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                         constant: PaddingConstants.left),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                          constant: -PaddingConstants.right),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: HeightConstants.separatorViewHeight)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with viewModel: FeedItemViewModel) {
        titleLabel.text = viewModel.title
        scoreLabel.text = "\(viewModel.score) Score"
        commentsNumberLabel.text = "\(viewModel.commentsNumber) Comments"
        
        if let imageURL = URL(string: viewModel.thumbnail) {
            Nuke.loadImage(with: imageURL, into: thumbnailImageView)
        }
    }
}
