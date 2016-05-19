//
//  XTStatusCloud.swift
//  ZENote
//
//  Created by 胡春源 on 16/4/22.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

typealias SaveBlock = (success:Bool,error:NSError?) -> Void
typealias fetchStatusBlock = (statusArr:Array<ZEStatusMdoel>) -> Void
let statusClassName = "StatusTimeLine"
extension AVQuery {

}


class XTStatusCloud: NSObject {
    static let shareSingleOne = XTStatusCloud()
    override init() {
        super.init()
        
    }
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
    
    func fetchStatusWithPage(page:UInt,callBack:fetchStatusBlock) -> Void {
        let query =  AVQuery(className: statusClassName)
        query.orderByAscending("creatAt");
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            var callBackArr:Array<ZEStatusMdoel> = []
            let objectArr = objects as! [AVObject!]
            for object in objectArr {
                let model = ZEStatusMdoel.modelWithDictionary(object.dictionaryForObject() as [NSObject : AnyObject])
                
                callBackArr.append(model!)
            }
            callBack(statusArr: callBackArr)
        }
    }
}