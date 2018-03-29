//
//  Extentions.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/26.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomeImageView: UIImageView {
  
  var imageUrlString: String?
  
  func loadImageUsingUrlString(urlString: String) {
    let url = URL(string:urlString)
   
    image = nil
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
      self.image = imageFromCache as? UIImage
      return
    }
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if error != nil {
        print(error!)
        return
      }
      
      DispatchQueue.main.async {
        let imageToCache = UIImage(data: data!)
        
        if self.imageUrlString == urlString {
          self.image = imageToCache
        }
        
        imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
        self.image = imageToCache
      }
      
      }.resume()
  }
}
