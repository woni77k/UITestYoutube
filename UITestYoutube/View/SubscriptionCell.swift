//
//  SubscriptionCell.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/28.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
  override func fetchVideos() {
    ApiService.sharedInstance.fetchTSubscriptionFeed(completion: { (videos) in
      self.videos = videos
      self.collectionView.reloadData()
    })
  }
}
