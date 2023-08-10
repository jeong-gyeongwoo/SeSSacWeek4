//
//  VideoTableViewCell.swift
//  SeSSacWeek4
//
//  Created by 정경우 on 2023/08/09.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var thumbnailIamgeView: UIImageView!

    @IBOutlet var contentLable: UILabel!
    @IBOutlet var titleLable: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLable.font = .boldSystemFont(ofSize: 15)
        titleLable.numberOfLines = 0
        contentLable.font = .systemFont(ofSize: 13)
        contentLable.numberOfLines = 2
        thumbnailIamgeView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
