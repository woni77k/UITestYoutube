//
//  ApiService.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/28.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

class ApiService: NSObject {
  static let sharedInstance = ApiService()
  let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
  
  func fetchVideos(completion: @escaping ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
  }
  
  func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
  }
  
  func fetchTSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
  }
  
  func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
    
    let url = URL(string: urlString)
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      
      if error != nil {
        print(error!)
        return
      }
      
      do {
        if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
          
          DispatchQueue.main.async {
            completion(jsonDictionaries.map({return Video(dictionary: $0)}))
          }
          
        }
      } catch let jsonError {
        print(jsonError)
      }
      }.resume()
  }
}


//          let videos = jsonDictionaries.map({return Video(dictionary: $0)})
//          var videos = [Video]()
//
//          for dictionary in jsonDictionaries {
//
//            let video = Video(dictionary: dictionary)
//            //          video.title = dictionary["title"] as? String
//            //          video.thumbnail_image_name = dictionary["thumbnail_image_name"] as? String
//            //          video.number_of_views = dictionary["number_of_views"] as? NSNumber
//            //          video.setValuesForKeys(dictionary)
//
//            //          let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//            //          let channel = Channel()
//            //          channel.setValuesForKeys(channelDictionary)
//            //          channel.name = channelDictionary["name"] as? String
//            //          channel.profile_image_name = channelDictionary["profile_image_name"] as? String
//
//            //          video.channel = channel
//
//            videos.append(video)
//          }

//          let numbersArray = [1,2,3]
//          let doubleNumbersArray = numbersArray.map({return $0 * 2})
//          let stringsArray = numbersArray.map({return "\($0 * 2)"})
//          print(doubleNumbersArray)
// [2,4,6]
// ["2", "4", "6"]
