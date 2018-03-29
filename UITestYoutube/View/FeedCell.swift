//
//  FeedCell.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/28.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
  let cellId = "cellId"
  
  var videos: [Video]?
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.backgroundColor = .white
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  func fetchVideos() {
    
    ApiService.sharedInstance.fetchVideos { (videos) in
      self.videos = videos
      self.collectionView.reloadData()
    }
  }
  
  override func setupViews() {
    super.setupViews()
    
    fetchVideos()
    
    backgroundColor = .brown
    
    addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
      collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
      collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
      ])
    
    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)

  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
    cell.video = videos?[indexPath.item]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (frame.width - 16 - 16) * 9 / 16
    return CGSize(width: frame.size.width, height: height + 16 + 88)
  }
}
