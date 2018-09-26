//
//  TutorialViewController.swift
//  video_play_app
//
//  Created by Kazutoshi Uetsuhara on 2018/09/25.
//  Copyright © 2018年 Kazutoshi Uetsuhara. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageControle: UIPageControl!
    
    // image files
    private let img:[String] = ["tutorial_0","tutorial_1","tutorial_2","tutorial_3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        scrollView.delegate = self
        
        // skip button action
        self.skipButton.addTarget(self, action: #selector(buttonEvent(sender:)), for: UIControlEvents.touchUpInside)
        
        // page controle
        self.pageControle.currentPageIndicatorTintColor = UIColor.blue
        self.pageControle.pageIndicatorTintColor = UIColor.gray
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let scrollViewSize = self.scrollView.frame
        let s_width = Int(scrollViewSize.size.width)
        let s_height = Int(scrollViewSize.size.height)
        
        for num in 0 ... img.count-1{
            let imageView = UIImageView()
            let xpoint = s_width * num
            imageView.frame = CGRect(x: xpoint, y: 0, width: s_width, height: s_height)
            imageView.backgroundColor = UIColor.white
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.image = UIImage(named: img[num])
            self.scrollView.addSubview(imageView)
        }
        
        self.scrollView.contentSize = CGSize(width: s_width * img.count, height: s_height)

    }
    
    @objc func buttonEvent(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    


    // MARK: - ScroiiViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        let pageWidth: CGFloat = scrollView.frame.size.width
        let pageNum: CGFloat = scrollView.contentOffset.x / pageWidth
        self.pageControle.currentPage = Int(pageNum)
        
        if pageNum == 3 {
            self.skipButton.setTitle("Go", for: UIControlState.normal)
        }
        
    }


}
