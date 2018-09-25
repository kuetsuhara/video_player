//
//  TutorialViewController.swift
//  video_play_app
//
//  Created by 上津原 一利 [NEXT] on 2018/09/25.
//  Copyright © 2018年 Kazutoshi Uetsuhara. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var skipButton: UIButton!
    

    let img:[String] = ["tutorial_0","tutorial_1","tutorial_2","tutorial_3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // skip button action
        self.skipButton.addTarget(self, action: #selector(buttonEvent(sender:)), for: UIControlEvents.touchUpInside)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let scrollViewSize = self.scrollView.frame
        let s_width = Int(scrollViewSize.size.width)
        let s_height = Int(scrollViewSize.size.height)
        
        for num in 0 ... img.count{
            print(num)
            let imageView = UIImageView()
            let xpoint = s_width * num
            imageView.frame = CGRect(x: xpoint, y: 0, width: s_width - 10, height: s_height)
            imageView.backgroundColor = UIColor.yellow
            self.scrollView.addSubview(imageView)
        }
        
        self.scrollView.contentSize = CGSize(width: s_width * img.count, height: s_height)

    }
    
    @objc func buttonEvent(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
