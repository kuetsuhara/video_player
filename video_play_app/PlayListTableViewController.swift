//
//  PlayListTableViewController.swift
//  video_play_app
//
//  Created by 上津原 一利 [NEXT] on 2018/09/20.
//  Copyright © 2018年 Kazutoshi Uetsuhara. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SVProgressHUD
import SwiftyJSON

class PlayListTableViewController: UITableViewController {
    
    let apiUrl = "https://gist.githubusercontent.com/sa2dai/04da5a56718b52348fbe05e11e70515c/raw/60a93bd0191a66141cab185a1b814a9828ab12a2/code_test_iOS.json"
    
    var resultData :JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // call api
        self.allPlaylistApi()
        
        self.tableView.register(UINib(nibName: "PlayListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.rowHeight = 300
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! PlayListTableViewCell
        
        // insert data
        cell.presenterLabel?.text = self.resultData[indexPath.row]["presenter_name"].stringValue
        cell.titleLabel?.text = self.resultData[indexPath.row]["title"].stringValue
        cell.descriptionLabel?.text = self.resultData[indexPath.row]["description"].stringValue
        
        // get image
        Alamofire.request(self.resultData[indexPath.row]["thumbnail_url"].stringValue).responseImage { response in
            if let image = response.result.value {
                print("image downloaded: \(image)")
                cell.thumbImageView.image = image
            }
        }
        
//        cell.thumbImageView.image = Alamofire.
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Call API
    func allPlaylistApi() {
        SVProgressHUD.show() // indicator show
        
        // call api
        Alamofire.request(apiUrl).responseJSON { response in
            
            switch response.result {
            case .success:
                self.resultData = JSON(response.result.value ?? kill)
                print("JSON: \(self.resultData)")
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
            SVProgressHUD.dismiss()
        }

    }
    
}
