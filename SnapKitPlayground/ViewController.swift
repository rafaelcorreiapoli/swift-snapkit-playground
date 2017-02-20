//
//  ViewController.swift
//  SnapKitPlayground
//
//  Created by Rafael Ribeiro Correia on 2/20/17.
//  Copyright © 2017 Rafael Ribeiro Correia. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

struct Post {
  let imageUrl: String
  let name: String
  let content: String
}


class TweetCell: UICollectionViewCell {
  let imgImage: UIImageView = UIImageView()
  let lblName: UILabel = UILabel()
  let lblContent: UILabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(imgImage)
    self.addSubview(lblName)
    self.addSubview(lblContent)
    imgImage.snp.makeConstraints { (make) in
      make.size.equalTo(100)
      make.left.equalTo(self).offset(10)
      make.top.equalTo(self).offset(10)
    }
    
    lblName.snp.makeConstraints { (make) in
      make.left.equalTo(imgImage.snp.right).offset(20)
      make.top.equalTo(imgImage)
      make.right.equalTo(self).offset(-10)
    }
    lblName.textAlignment = .left
   
    lblContent.numberOfLines = 0
    lblContent.snp.makeConstraints { (make) in
      make.top.equalTo(lblName.snp.bottom).offset(10)
      make.left.right.equalTo(lblName)
      make.bottom.equalTo(self.snp.bottom)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  func config(post: Post) {
    imgImage.kf.setImage(with: URL(string: post.imageUrl)!)
    lblName.text = post.name
    lblContent.text = post.content
  }
  
}
class PostCell: UICollectionViewCell {
  let imgImage: UIImageView = UIImageView()
  let lblName: UILabel = UILabel()
  
  override init(frame: CGRect) {
    print("cell init")
    super.init(frame: frame)
    self.addSubview(imgImage)
    self.addSubview(lblName)
    
    lblName.textColor = UIColor.white
    
    imgImage.snp.makeConstraints { (make) in
      make.edges.equalTo(self.snp.edges)
    }
    
    lblName.snp.makeConstraints { (make) in
      make.bottom.equalTo(self.snp.bottom).offset(-10)
      make.left.equalTo(self.snp.left).offset(10)
      make.right.equalTo(self.snp.right).offset(10)
    }
    
    
  }
  

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func config(post: Post) {
    self.backgroundColor = UIColor.blue
    imgImage.kf.setImage(with: URL(string: post.imageUrl)!)
    lblName.text = post.name
    lblName.textAlignment = .center
  }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
  lazy var posts: [Post] = {
    var temp = [Post]()
    
    for i in 100...200 {
     temp.append(Post(imageUrl: "https://unsplash.it/300x300?image=\(i)", name: "Name", content: "Content Content Content v vContent Content Content Content Content Content Content Content v Content Content"))
    }

    
    
    return temp
  }()
  let cellIdentifier = "PostCell"
  
  
  let flow = UICollectionViewFlowLayout()
  lazy var collectionView: UICollectionView = {
    
    let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flow)
    cv.backgroundColor = UIColor.purple
    cv.register(TweetCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
    cv.dataSource = self
    cv.delegate = self
    return cv
    
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let superview = self.view!
    
    let box = UIView()
    box.backgroundColor = UIColor.red
    superview.addSubview(box)
    box.addSubview(collectionView)
    
    let box2 = UIView()
    box2.backgroundColor = UIColor.green
    superview.addSubview(box2)
    
    
    let box3 = UIView()
    box3.backgroundColor = UIColor.blue
    superview.addSubview(box3)
    box3.layer.cornerRadius = 50
    box3.clipsToBounds = true
    
    
    let box4 = UILabel()
    box4.text = "+"
    box4.font = UIFont(name: "Helvetica", size: 80)
    box4.textColor = UIColor.white
    box4.sizeToFit()
    box3.addSubview(box4)
    
    
    superview.addSubview(box4)
    
    box.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(superview.snp.height).multipliedBy(0.5)
      make.width.equalTo(superview.snp.width)
    }
    
    
    box2.snp.makeConstraints { (make) in
      make.top.equalTo(box.snp.bottom)
      make.height.equalTo(superview.snp.height).multipliedBy(0.5)
      make.width.equalTo(superview.snp.width)
    }
    
    box3.snp.makeConstraints { (make) in
      make.right.equalTo(superview.snp.right).offset(-20)
      make.bottom.equalTo(superview.snp.bottom).offset(-20)
      make.width.equalTo(100)
      make.height.equalTo(100)
    }
    
    box4.snp.makeConstraints { (make) in
      make.center.equalTo(box3)
    }
    
    
    collectionView.snp.makeConstraints { (make) in
      make.edges.equalTo(box)
    }
    
//    let fl = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}


extension ViewController {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TweetCell
    
    cell.config(post: posts[indexPath.row])
    return cell
  }
}

extension ViewController {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let width = collectionView.frame.width
//    return CGSize(width: width, height: 100)
//  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

