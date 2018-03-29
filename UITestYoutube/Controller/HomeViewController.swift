//
//  ViewController.swift
//  UITestYoutube
//
//  Created by SEUNG-WON KIM on 2018/03/26.
//  Copyright © 2018 SEUNG-WON KIM. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  let cellId = "cellId"
  let trendingCellId = "trendingCellId"
  let subscriptionCellId = "subscriptionCellId"
  let titles = ["Home", "Trending", "Subscriptions", "Account"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.isTranslucent = false
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    titleLabel.text = "  Home"
    titleLabel.textColor = .white
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    navigationItem.titleView = titleLabel
    
    setupCollectionView()
    setupMenuBar()
    setupNaviBarButtons()
    
  }
  
  lazy var menuBar: MenuBar = {
    let mb = MenuBar()
    mb.homeController = self
    return mb
  }()
  
  private func setupMenuBar() {
    navigationController?.hidesBarsOnSwipe = true
    
    let redView = UIView()
    redView.translatesAutoresizingMaskIntoConstraints = false
    redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    view.addSubview(redView)
    NSLayoutConstraint.activate([
      redView.topAnchor.constraint(equalTo: view.topAnchor),
      redView.widthAnchor.constraint(equalTo: view.widthAnchor),
      redView.heightAnchor.constraint(equalToConstant: 50)])
    
    
    view.addSubview(menuBar)
    menuBar.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      menuBar.widthAnchor.constraint(equalTo: view.widthAnchor),
      menuBar.heightAnchor.constraint(equalToConstant: 50)])
  }
  
  func setupCollectionView() {
    
    if let flowlayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      flowlayout.scrollDirection = .horizontal
      flowlayout.minimumLineSpacing = 0
    }
    
    collectionView?.backgroundColor = .white
    collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
    collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
    
    collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    
    collectionView?.isPagingEnabled = true
  }
  
  func setupNaviBarButtons() {
    let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
    let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
    
    let moreButton = UIBarButtonItem(image: UIImage(named: "more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    
    navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
  }
  
  @objc func handleSearch() {
    print(1234)
  }
  
  func scrollToMenuIndex(menuIndex: Int) {
    let indexPath = IndexPath(item: menuIndex, section: 0)
    collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    
    setTitleForIndex(index: menuIndex)
  }
  
  private func setTitleForIndex(index: Int) {
    if let titleLabel = navigationItem.titleView as? UILabel {
      titleLabel.text = " \(titles[index])"
    }
  }
  
  lazy var settingsLauncher: SettingsLauncher = {
    let launcher = SettingsLauncher()
    launcher.homeController = self
    return launcher
  }()

  @objc func handleMore() {
    settingsLauncher.showSettings()
  }
  
  func showControllerForSetting(setting: Setting) {
    let dummySettingsViewController = UIViewController()
    dummySettingsViewController.view.backgroundColor = .white
    dummySettingsViewController.navigationItem.title = setting.name.rawValue
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    navigationController?.pushViewController(dummySettingsViewController, animated: true)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
//    print(targetContentOffset.pointee.x / view.frame.width)
    let index = targetContentOffset.pointee.x / view.frame.width
    let indexPath = IndexPath(item: Int(index), section: 0)
    menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    
    setTitleForIndex(index: Int(index))
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let identifier: String
    if indexPath.item == 1 {
      identifier = trendingCellId
    } else if indexPath.item == 2 {
      identifier = subscriptionCellId
    } else {
      identifier = cellId
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height - 50)
  }
}
