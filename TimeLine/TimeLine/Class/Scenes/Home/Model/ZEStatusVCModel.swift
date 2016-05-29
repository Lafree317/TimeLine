//
//  HomeModel.swift
//  ZETimeLine
//
//  Created by 胡春源 on 16/5/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit


protocol StatusProtocol{
    
}

extension StatusProtocol where Self:ZEStatusVCModel {
    
}

typealias ModelBlock = (success:Bool,status:String) -> Void

let str_error = "查找动态出错"
let str_noData = "没有新内容了"
let str_success = "刷新成功"

class ZEStatusVCModel: NSObject,StatusProtocol {
    
    var dataArr:Array<StatusMdoel> = []
    
    
    func getData(page:UInt,block:ModelBlock){
        
        XTStatusCloud.shareSingleOne.fetchStatusWithPage(page: page) { (statusArr, error) in
            
            if error != nil {
                block(success: false, status: str_error)
                return;
            }
            
            if (statusArr.count == 0) {
                block(success: true, status: str_noData)
                return;
            }
            
            
            self.dataArr += statusArr
            block(success: true, status: str_success)
        }
    }
}

protocol CellProtocol {
    func imageTap()
}

extension StatusCellImageView:CellProtocol{
    
    func imageTap() {
        
    }
}
