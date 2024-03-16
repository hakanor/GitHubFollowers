//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 13.03.2024.
//

import UIKit

class FollowerListVC: UIViewController {
    
    //MARK: - Properties
    var username: String!
    
    //MARK: - Subviews
    private var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(textLabel)
        textLabel.frame = view.frame
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        Task {
            let followers = try await NetworkProvider.shared.execute(GetFollowersRequest(username: "hakanor", page: 1))
            self.textLabel.text = followers.first?.login
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
