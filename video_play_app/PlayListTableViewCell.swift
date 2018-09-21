//
//  PlayListTableViewCell.swift
//  video_play_app
//
//  Created by Kazutoshi Uetsuhara on 2018/09/21.
//  Copyright © 2018年 Kazutoshi Uetsuhara. All rights reserved.
//

import UIKit

class PlayListTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var presenterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.timeLabel.backgroundColor = UIColor.black

        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.timeLabel.backgroundColor = UIColor.black
    }

}
