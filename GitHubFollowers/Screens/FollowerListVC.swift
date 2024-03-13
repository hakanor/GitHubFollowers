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

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let errorMessage):
                let ererrorMessageRaw = errorMessage.rawValue
                self.presentGFAlertOnMainThread(title: ererrorMessageRaw, message: ererrorMessageRaw, buttonTitle: "OK")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
