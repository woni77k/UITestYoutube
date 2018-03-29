//
//  SettingCell.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/28.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
  
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? .darkGray : .white
      
      nameLabel.textColor = isHighlighted ? .white : .black
      
      iconImageView.tintColor = isHighlighted ? .white : .darkGray
    }
  }
  
  var setting: Setting? {
    didSet {
      nameLabel.text = setting?.name.rawValue
      if let imageName = setting?.imageName {
         iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .darkGray
      }
    }
  }
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Setting"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "settings")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(nameLabel)
    addSubview(iconImageView)
    
    NSLayoutConstraint.activate([
      iconImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
      iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      iconImageView.widthAnchor.constraint(equalToConstant: 20),
      iconImageView.heightAnchor.constraint(equalToConstant: 20)
      ])
    
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
      nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      ])
  }
}
