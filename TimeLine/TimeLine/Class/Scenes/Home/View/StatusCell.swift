//
//  StatusCell.swift
//  ZETimeLine
//
//  Created by 胡春源 on 16/5/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    @IBOutlet weak var labelTopConstranints: NSLayoutConstraint!
    
    @IBOutlet weak var buttomImageView: UIImageView!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var imageHight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 这样可以变换cell高度
        let randomNumber = Int.random(0, 1)
        if randomNumber == 0 {
            labelTopConstranints.constant = 100
            self.layoutIfNeeded()
        }
    }
    func setDate(news:StatusMdoel){
        contextLabel.text = news.context
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
