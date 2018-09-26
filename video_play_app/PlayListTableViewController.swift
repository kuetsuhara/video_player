//
//  PlayListTableViewController.swift
//  video_play_app
//
//  Created by Kazutoshi Uetsuhara on 2018/09/20.
//  Copyright © 2018年 Kazutoshi Uetsuhara. All rights reserved.
//

// kit
import UIKit
import AVKit

// pods
import Alamofire
import AlamofireImage
import SVProgressHUD
import SwiftyJSON
import Hex

class PlayListTableViewController: UITableViewController {
    
    private let apiUrl = "https://quipper.github.io/native-technical-exam/playlist.json"
    private let resiterUrl = "https://manage.studysapuri.jp/registration/accounts/new"
    private var resultData :JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call api
        self.getPlaylist()
        
        // Tableview setting
        self.tableView.register(UINib(nibName: "PlayListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // add refresh view
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(PlayListTableViewController.refresh(sender:)), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.white
        
        // navigation bar setting
        self.title = "Movies"
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "0B41A1")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // register button
        let rightBarButtonItem = UIBarButtonItem(title: "Register", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.registerAction))
        rightBarButtonItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        // Tutorial Disp
        var count = 0
        
        if UserDefaults.standard.object(forKey: "visit_count") != nil {
            count = UserDefaults.standard.integer(forKey: "visit_count") + 1
            UserDefaults.standard.set(count, forKey: "visit_count")
        }else{
            count = 1
            UserDefaults.standard.set(count, forKey: "visit_count")
        }
        
        if count == 1 {
            // open tutorial
            super.viewWillAppear(animated)
            let tutorialViewCintroller = TutorialViewController()
            tutorialViewCintroller.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            self.present(tutorialViewCintroller, animated: true, completion: nil)

        }
        
        // disp register alert
        if count % 10 == 0 {
            displayRegisterAlert()
        }
        
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        self.getPlaylist()
    }

    @objc func registerAction(){
        guard let url = URL(string: resiterUrl) else {return}
        UIApplication.shared.open(url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.resultData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // make cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! PlayListTableViewCell
        // set select color
        let selectedBackgroundView: UIView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = selectedBackgroundView
        
        // reset cache image
        cell.thumbImageView.image = UIImage(named: "default_image")
        
        // insert data
        cell.presenterLabel?.text   = self.resultData[indexPath.row]["presenter_name"].stringValue
        cell.titleLabel?.text       = self.resultData[indexPath.row]["title"].stringValue
        cell.descriptionLabel?.text = self.resultData[indexPath.row]["description"].stringValue
        cell.timeLabel?.text        = self.convertDuration(duration: self.resultData[indexPath.row]["video_duration"].intValue)
        
        // get image
        Alamofire.request(self.resultData[indexPath.row]["thumbnail_url"].stringValue).responseImage { response in
            if let image = response.result.value {
                cell.thumbImageView.image = image
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // video play
        let videoUrl = URL(string: self.resultData[indexPath.row]["video_url"].stringValue)
        
        if let url = videoUrl{
            let avPlayer = AVPlayer(url: url)
            let avPlayerViewController = LandscapePlayerViewController()
            avPlayerViewController.player = avPlayer
            self.present(avPlayerViewController, animated: true, completion: nil)
        }
        // clear select color
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    // MARK: - Utility
    func getPlaylist() {
        SVProgressHUD.show() // show indicator
        
        // call api
        Alamofire.request(apiUrl).responseJSON { response in
            
            switch response.result {
            case .success:
                self.resultData = JSON(response.result.value ?? kill)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
                self.displayAlert()
            }
            SVProgressHUD.dismiss() // hide indicator
            self.refreshControl?.endRefreshing() // end refreshview
        }
    }
    
    // msec to [min:sec]
    func convertDuration(duration: Int) -> String{
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute,.hour,.second]
        let outputString = formatter.string(from: TimeInterval(duration/1000)) // duration is msec
        
        return outputString!
    }
    
    // show error alert
    func displayAlert() {
        let title = "Sorry"
        let message = "Connection error\nPlease try again."
        let okText = "OK"
        let taText = "Try again"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)

        let tryAgainButton = UIAlertAction(title: taText, style: UIAlertActionStyle.default) { (action: UIAlertAction!) -> Void in
            self.getPlaylist()
        }
        alert.addAction(okayButton)
        alert.addAction(tryAgainButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    // show resiter alert
    func displayRegisterAlert() {
        let title = "Do you like this app?"
        let message = "If you like this app, please make account"
        let okText = "No thnaks"
        let taText = "Regiter"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
        
        let tryAgainButton = UIAlertAction(title: taText, style: UIAlertActionStyle.default) { (action: UIAlertAction!) -> Void in
            self.registerAction()
        }
        alert.addAction(okayButton)
        alert.addAction(tryAgainButton)
        
        present(alert, animated: true, completion: nil)

    }
    
}
