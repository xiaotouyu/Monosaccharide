//
//  DTCircleView.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/8.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

//时间间隔
private let TimeInterval = 2.5

protocol DTCircleViewDelegate {

    func clickCurrentImage(_ currentIndxe: Int)

}

class DTCircleView: UIView {

    fileprivate var contentScrollView: UIScrollView!

    open var delegate: DTCircleViewDelegate?
    open var imageArray: [UIImage?]! {

        //监听图片数组的变化，及时更改显示图
        willSet(newValue){
            self.imageArray = newValue
        }
        //数据源发生改变需要改变scrollView 和currentPage 的数量
        didSet{
            contentScrollView.isScrollEnabled = !(imageArray.count == 1)
            self.pageIndicator.frame = CGRect(x: self.frame.size.width - 20 * CGFloat(imageArray.count), y: self.frame.size.height - 30, width: 20 * CGFloat(imageArray.count), height: 20)
            self.pageIndicator?.numberOfPages = self.imageArray.count
            self.setScrollViewOfImage()
        }
    }

    open var urlImageArray: [String]? {
        //监听图片数组的变化，及时更改显示图
        willSet(newValue){
            self.urlImageArray = newValue
        }

        didSet{
            contentScrollView.isScrollEnabled = !(urlImageArray?.count == 1)
            self.pageIndicator.frame = CGRect(x: self.frame.size.width - 20 * CGFloat((urlImageArray?.count)!), y: self.frame.size.height - 30, width: 20 * CGFloat((urlImageArray?.count)!), height: 20)
            self.pageIndicator?.numberOfPages = (urlImageArray?.count)!
            setScrollViewOfUrlImage()
        }
    }

    fileprivate var indexOfCurrentImage: Int! {

        didSet{
            pageIndicator.currentPage = indexOfCurrentImage
        }
    }

    var currentImageView:   UIImageView!
    var lastImageView:      UIImageView!
    var nextImageView:      UIImageView!

    var pageIndicator:      UIPageControl!          //页数指示器
    var timer:              Timer?                //计时器

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, loaclImageArray: [UIImage?]!) {
        self.init(frame: frame)
        imageArray = loaclImageArray
        indexOfCurrentImage = 0
        setUpCircleView()
    }

    convenience init(frame: CGRect, urlImageArray: [String]?) {
        self.init(frame: frame)
        self.urlImageArray = urlImageArray
        indexOfCurrentImage = 0
        setUpCircleView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpCircleView(){
        contentScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        contentScrollView.contentSize = CGSize(width: frame.width * 3, height: 0)
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsHorizontalScrollIndicator = false
        addSubview(contentScrollView)

        currentImageView = UIImageView()
        currentImageView.frame = CGRect(x: frame.width, y: 0, width: frame.width, height: frame.height)
        currentImageView.isUserInteractionEnabled = true
        currentImageView.contentMode = UIViewContentMode.scaleAspectFill
        currentImageView.clipsToBounds = true
        contentScrollView.addSubview(currentImageView)

        //添加点击事件
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(DTCircleView.imageTapAction(_:)))
        currentImageView.addGestureRecognizer(imageTap)

        lastImageView = UIImageView()
        lastImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        lastImageView.contentMode = UIViewContentMode.scaleAspectFill
        lastImageView.clipsToBounds = true
        contentScrollView.addSubview(lastImageView)

        nextImageView = UIImageView()
        nextImageView.frame = CGRect(x: frame.width * 2, y: 0, width: frame.width, height: frame.height)
        nextImageView.contentMode = UIViewContentMode.scaleAspectFill
        nextImageView.clipsToBounds = true
        contentScrollView.addSubview(nextImageView)

        if imageArray != nil{
            setScrollViewOfImage()
             pageIndicator = UIPageControl(frame: CGRect(x: frame.width/2-20 * CGFloat(urlImageArray!.count)/2, y: frame.height-30, width: 20 * CGFloat(urlImageArray!.count), height: 20))
            pageIndicator.numberOfPages = imageArray.count
        }

        if urlImageArray != nil {
            setScrollViewOfUrlImage()
            pageIndicator = UIPageControl(frame: CGRect(x: frame.width/2-20 * CGFloat(urlImageArray!.count)/2, y: frame.height-30, width: 20 * CGFloat(urlImageArray!.count), height: 20))
            pageIndicator.numberOfPages = urlImageArray!.count
        }
        contentScrollView.setContentOffset(CGPoint(x: frame.width, y: 0), animated: false)

        //设置分页指示器
        pageIndicator.hidesForSinglePage = true
        pageIndicator.backgroundColor = UIColor.clear
        self.addSubview(pageIndicator)

        //设置计时器
//        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval, target: self, selector: #selector(DTCircleView.timerAction), userInfo: nil, repeats: true)
    }

    func setScrollViewOfImage(){

        currentImageView.image = imageArray[indexOfCurrentImage]
        nextImageView.image = imageArray[getNextImageIndex(indexOfCurrentImage: indexOfCurrentImage)]
        lastImageView.image = imageArray[getLastImageIndex(indexOfCurrentImage: indexOfCurrentImage)]
    }
    func setScrollViewOfUrlImage(){

        currentImageView.kf.setImage(with: URL(string: (urlImageArray?[indexOfCurrentImage])!))
        nextImageView.kf.setImage(with: URL(string: (urlImageArray?[getNextImageIndex(indexOfCurrentImage: indexOfCurrentImage)])!))
        nextImageView.kf.setImage(with: URL(string: (urlImageArray?[getLastImageIndex(indexOfCurrentImage: indexOfCurrentImage)])!))
    }

    // 得到上一张图片的下标
    fileprivate func getLastImageIndex(indexOfCurrentImage index: Int) -> Int{
        let tempIndex = index - 1
        if tempIndex == -1 {
            if imageArray != nil {
                return imageArray.count - 1
            }
            if urlImageArray != nil {
                return (urlImageArray?.count)! - 1
            }
        }else{
            return tempIndex
        }
        return 0
    }

    // 得到下一张图片的下标
    fileprivate func getNextImageIndex(indexOfCurrentImage index: Int) -> Int
    {
        let tempIndex = index + 1
        if imageArray != nil {
            return tempIndex < imageArray.count ? tempIndex : 0
        }
        if urlImageArray != nil {

            return tempIndex < urlImageArray!.count ? tempIndex : 0
        }
        return 0
    }
    func imageTapAction(_ tap: UITapGestureRecognizer){
        delegate?.clickCurrentImage(indexOfCurrentImage)
    }

    //事件触发方法
    func timerAction() {

        contentScrollView.setContentOffset(CGPoint(x: self.frame.size.width*2, y: 0), animated: true)
    }

}
extension DTCircleView: UIScrollViewDelegate{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        //如果用户手动拖动到了一个整数页的位置就不会发生滑动了 所以需要判断手动调用滑动停止滑动方法
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.x
        if offset == 0 {
            self.indexOfCurrentImage = self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }else if offset == self.frame.size.width * 2 {
            self.indexOfCurrentImage = self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }
        // 重新布局图片
        if imageArray != nil {
            setScrollViewOfImage()
        }
        if urlImageArray != nil {
            setScrollViewOfUrlImage()
        }
        //布局后把contentOffset设为中间
        scrollView.setContentOffset(CGPoint(x: frame.width, y: 0), animated: false)

        //重置计时器
        if timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval, target: self, selector: #selector(DTCircleView.timerAction), userInfo: nil, repeats: true)
        }
    }

    //时间触发器 设置滑动时动画true，会触发的方法
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //        print("animator", terminator: "")
        self.scrollViewDidEndDecelerating(contentScrollView)
    }

}




