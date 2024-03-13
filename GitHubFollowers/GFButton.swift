//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 12.03.2024.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom Code Here
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom init method
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configureUI()
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        
        titleLabel?.textColor = .white
        // forTextStyle -> dynamic type (support for dark & light mode)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
}
