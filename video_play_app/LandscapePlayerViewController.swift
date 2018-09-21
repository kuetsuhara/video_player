//
//  LandscapePlayerViewController.swift
//  video_play_app
//
//  Created by Kazutoshi Uetsuhara on 2018/09/21.
//  Copyright © 2018年 Kazutoshi Uetsuhara. All rights reserved.
//

import UIKit
import AVKit

class LandscapePlayerViewController: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.player?.play()
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
