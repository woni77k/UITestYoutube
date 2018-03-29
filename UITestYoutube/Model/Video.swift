//
//  Video.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/27.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

class SafeJsonobject: NSObject {
  
  override func setValue(_ value: Any?, forKey key: String) {
    let uppercasedFirstCharacter = String(key.first!).uppercased()
    let range = key.startIndex...key.startIndex
//    let range = key.startIndex...key.startIndex.advancedBy(0)
    let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
//    let selectorString = key.stringByReplacingCharactersInRange(range, withString: uppercasedFirstCharacter)

    let selector = NSSelectorFromString("set\(selectorString):")
    let respons = self.responds(to: selector)

    if !respons {
      return
    }
    setValue(value, forKey: key)
  }
}

class Video: NSObject {
  
  @objc var thumbnail_image_name: String?
  @objc var title: String?
  @objc var number_of_views: NSNumber?
  @objc var uploadDate: NSDate?
  @objc var duration: NSNumber?
  
  @objc var channel: Channel?
  
  override func setValue(_ value: Any?, forKey key: String) {

    if key == "channel" {
      self.channel = Channel()
      self.channel?.setValuesForKeys(value as! [String: AnyObject])
    } else {
      super.setValue(value, forKey: key)
    }
  }
  
  init(dictionary: [String: AnyObject]) {
    super.init()
    setValuesForKeys(dictionary)
  }
}

class Channel: NSObject {
  @objc var name: String?
  @objc var profile_image_name: String?
  
}
