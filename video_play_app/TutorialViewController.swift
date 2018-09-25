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
    
    var scrollScreenHeight:CGFloat!
    var scrollScreenWidth:CGFloat!
    
    let img:[String] = ["tutorial_0","tutorial_1","tutorial_2","tutorial_3"]
    
    var imageWidth:CGFloat!
    var imageHeight:CGFloat!
    var screenSize:CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // skip button action
        self.skipButton.addTarget(self, action: #selector(buttonEvent(sender:)), for: UIControlEvents.touchUpInside)
        
        // scrollview setting
        
        screenSize = UIScreen.main.bounds
        scrollScreenWidth = screenSize.width
        
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
