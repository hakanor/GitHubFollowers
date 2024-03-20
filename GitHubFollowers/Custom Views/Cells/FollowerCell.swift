//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 16.03.2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "FollowerCell"
    private let imageLoader = ImageLoader.shared
    private let networkProvider = NetworkProvider.shared
    
    // MARK: - Subviews
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(follower: Follower) {
        usernameLabel.text = follower.login
        
        // check image cached
        if let image = imageLoader.value(cacheKey: follower.avatarUrl) {
            avatarImageView.image = image
        }
        
        Task {
            //downloand image
            let imageData = try await networkProvider.fetch(follower.avatarUrl)
            let image = UIImage(data: imageData)
            
            //cache image
            imageLoader.insert(urlString: follower.avatarUrl, image: image)
            avatarImageView.image = image
        }
    }
    
    private func configure() {
        [avatarImageView, usernameLabel].forEach(addSubview(_:))
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
