//
//  MenuBar.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/26.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  let cellId = "cellId"
  let imageNames = ["home", "trending", "subscriptions", "account"]
  var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
  var homeController: HomeViewController?
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    
    addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
      collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
    ])

    backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    
    let selectedIndexPath = IndexPath(item: 0, section: 0)
    collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
    
    setupHorizontalBar()
  }
  
  func setupHorizontalBar() {
    let horizontalBarView = UIView()
    horizontalBarView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(horizontalBarView)
//    horizontalBarView.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    
    horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
//    horizontalBarLeftAnchorConstraint?.isActive = true
    NSLayoutConstraint.activate([
        horizontalBarLeftAnchorConstraint!,
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4)
        ])
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let x = CGFloat(indexPath.item) * frame.width / 4
//    horizontalBarLeftAnchorConstraint?.constant = x
//
//    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//      self.layoutIfNeeded()
//    }, completion: nil)
    
    homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell

    cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
    cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width / 4, height: frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class BaseCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  func setupViews() {
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
