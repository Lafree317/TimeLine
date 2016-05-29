//
//  StatusCellImageView.swift
//  TimeLine
//
//  Created by 胡春源 on 16/5/29.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class StatusCellImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
