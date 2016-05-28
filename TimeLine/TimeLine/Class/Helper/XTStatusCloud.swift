//
//  XTStatusCloud.swift
//  ZENote
//
//  Created by 胡春源 on 16/4/22.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias SaveBlock = (success:Bool,error:NSError?) -> Void
typealias fetchStatusBlock = (statusArr:Array<StatusMdoel>,error:NSError!) -> Void

let statusClassName = "StatusTimeLine"

class XTStatusCloud: NSObject {
    static let shareSingleOne = XTStatusCloud()
    override init() {
        super.init()
        
    }
    
    /**
     保存新的动态
     
     - parameter dataArr:  图片Data数组
     - parameter context:  文字
     - parameter callBack: 回调bool,error
     */
    func saveNewStatus(dataArr dataArr:Array<NSData>,context:String,callBack:SaveBlock){
        let object = AVObject(className: statusClassName)
        
        var avfileArr:Array<AVFile> = []
        for data in dataArr {
            avfileArr.append(AVFile(data: data))
        }
        
        object.setObject(avfileArr, forKey: "imageArr")
        object.setObject(context, forKey: "context")
        object.saveInBackgroundWithBlock { (success, error) in
            
            callBack(success: success, error: error)
        }
        
    }
    
    /**
     查询最新动态
     
     - parameter page:     页数
     - parameter callBack: 回调Model数组,error
     */
    func fetchStatusWithPage(page page:UInt,callBack:fetchStatusBlock) -> Void {
        let query =  AVQuery(className: statusClassName)
        query.orderByAscending("creatAt");
        query.includeKey("imageArr")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            var modelArr:Array<StatusMdoel> = []
            
            if (error != nil) {
                callBack(statusArr: modelArr, error: error)
                return
            }
            for object in objects {
                let object = object as! AVObject
                let dic = object.dictionaryForObject() as [NSObject : AnyObject]
                let model = StatusMdoel.modelWithJSON(dic)
                modelArr.append(model!)
            }
            callBack(statusArr: modelArr, error: error)
        }
    }
}