//
//  UIViewController+Safari.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 21.03.2024.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
