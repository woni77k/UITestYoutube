//
//  VideoCell.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/26.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    return imageView
  }()
  
  override var isHighlighted: Bool {
    didSet {
      imageView.tintColor = isHighlighted ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
  }
  
  override var isSelected: Bool {
    didSet {
      imageView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
  }
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 20),
      imageView.heightAnchor.constraint(equalToConstant: 20)
      ])
  }
}

class VideoCell: BaseCell {
  
  var video: Video? {
    didSet {

      setupThumbnailImage()
      titleLabel.text = video?.title
      
      setupProfileImage()
      subtitleTextView.text = video?.channel?.name
      
      if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let subtitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!)"
        subtitleTextView.text = subtitleText
      }
      
      // measure title text
      if let title = video?.title {
        let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)], context: nil)
        
        if estimatedRect.size.height > 20 {
          titleLabelHeightConstraint?.constant = 44
        } else {
          titleLabelHeightConstraint?.constant = 28
        }
      }
    }
  }
  
  func setupThumbnailImage() {
    if let thumbnailImageUrl = video?.thumbnail_image_name {
      thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
    }
  }
  
  func setupProfileImage() {
    if let profileImageUrl = video?.channel?.profile_image_name {
      userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
    }
  }
  
  let thumbnailImageView: CustomeImageView = {
    let imageView = CustomeImageView()
    imageView.backgroundColor = .lightGray
    imageView.image = UIImage(named: "sara")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let userProfileImageView: CustomeImageView = {
    let imageView = CustomeImageView()
    imageView.backgroundColor = .lightGray
    imageView.image = UIImage(named: "oly")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Taylor Swift - Blank Space"
    label.numberOfLines = 2
    return label
  }()
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "TaylorSwift - 1,000,443,535 views - 2 years"
    textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
    textView.textColor = .lightGray
    return textView
  }()
  
  var titleLabelHeightConstraint: NSLayoutConstraint?
  
  override func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    NSLayoutConstraint.activate([
      thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
      thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      thumbnailImageView.bottomAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: -8)])
    
    NSLayoutConstraint.activate([
      userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
      userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
      userProfileImageView.widthAnchor.constraint(equalToConstant: 44),
      userProfileImageView.heightAnchor.constraint(equalToConstant: 44)])
    
    titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
    titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
    titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 44)
    
    NSLayoutConstraint.activate([
      subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      subtitleTextView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8),
      subtitleTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
//      subtitleTextView.heightAnchor.constraint(equalToConstant: 22)])
      subtitleTextView.bottomAnchor.constraint(equalTo: separatorView.topAnchor)])
    
    NSLayoutConstraint.activate([
      separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      separatorView.heightAnchor.constraint(equalToConstant: 1)])
  }
}
