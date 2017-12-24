//
//  GKTimeItemView.swift
//  demo
//
//  Created by Apple on 2017/12/24.
//  Copyright © 2017年 郭凯. All rights reserved.
//

import UIKit


class GKTimeItemView: UIView {
    let cellID = "cellId"
    
    var startTime : Int64
    var endTime : Int64
    var centerlable : UILabel?
    var collectionView : UICollectionView?
    var scrollIndexPath : IndexPath?
    var count : Int64
    
     init(frame: CGRect,startTime:Int64,endTime:Int64) {
        self.startTime = startTime
        self.endTime = endTime
        self.count = 20
        super.init(frame: frame)
        
        setUpCollectionView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GKTimeItemView : UICollectionViewDataSource,UICollectionViewDelegate{

    fileprivate func setUpCollectionView(){
        let layout = UICollectionViewFlowLayout()
        let itemW = self.frame.width/3.0
        let itemH = self.frame.height
        print(itemW)
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.collectionView = collectionView
        collectionView.register(UINib(nibName: "GKTimeCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.red
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        addSubview(collectionView)
        
        let leftSwift = UISwipeGestureRecognizer(target: self, action: #selector(swipleft))
        leftSwift.direction = .left
        
        let rightSwift = UISwipeGestureRecognizer(target: self, action: #selector(swipright))
         rightSwift.direction = .right
        
        collectionView.addGestureRecognizer(leftSwift)
        collectionView.addGestureRecognizer(rightSwift)
        
        setUpCenterView()
    }
    
    
    fileprivate func setUpCenterView(){
        let width = self.frame.width/3.0
        let rect = CGRect(x: width, y: 0, width: width, height: self.frame.height)
        
        let centetView = UIView(frame: rect)
        centetView.layer.cornerRadius = 5
        centetView.backgroundColor = UIColor.purple
        centetView.isUserInteractionEnabled = false
        addSubview(centetView)
        
        let centerLabel = UILabel(frame: centetView.bounds)
        self.centerlable = centerLabel
        centetView.addSubview(centerLabel)
        centerLabel.text = "1"
        centerLabel.textAlignment = .center
  
    }
    
    
    @objc fileprivate func swipleft(){

        let visibleItem  = collectionView?.indexPathsForVisibleItems.sorted()
        let scrollIndex = visibleItem?.last
        scrollToIndexPath(indexPath: scrollIndex!)
        print("左边")
    }
    
     @objc fileprivate func swipright(){
        print("右边")
        let visibleItem  = collectionView?.indexPathsForVisibleItems.sorted()
        let scrollIndex = IndexPath(row: (visibleItem![0].row), section: 0)
        print(scrollIndex)
        scrollToIndexPath(indexPath: scrollIndex)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GKTimeCell
        cell.timeLabel.text = "\(indexPath.row)"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToIndexPath(indexPath: indexPath)
    }
    
    fileprivate func scrollToIndexPath(indexPath:IndexPath){
        if indexPath.row + 1 == count||indexPath.row==0 {
            return
        }
        
        let scroIndexPath = IndexPath(row: indexPath.row+1, section: 0)
        self.scrollIndexPath = scroIndexPath
        collectionView?.scrollToItem(at: scroIndexPath, at: .right, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            self.centerlable?.text = "\(indexPath.row)"
        }
    }

}



