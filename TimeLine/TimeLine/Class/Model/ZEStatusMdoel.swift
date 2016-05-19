//
//  XTStatusMdoel.swift
//  ZENote
//
//  Created by 胡春源 on 16/4/23.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ZEStatusMdoel: AVObject {
    var content:String?
    var imageArr:Array<AVFile> = []
    
    internal var parseClassName:String{
        get{
            return "Student"
        }
    }
}
