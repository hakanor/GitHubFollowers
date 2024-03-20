//
//  GFTextField.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 12.03.2024.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor // always use CoreGraphic colors dealing with borderColor
        
        textColor = .label
        tintColor = .label // curser color
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2) // dynamic Type (dark & light mode)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        
        placeholder = "Enter a username"
    }
}
