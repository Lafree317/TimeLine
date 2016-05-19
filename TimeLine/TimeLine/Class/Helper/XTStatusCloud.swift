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
typealias fetchStatusBlock = (statusArr:Array<ZEStatusMdoel>) -> Void

let statusClassName = "StatusTimeLine"

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
    
    func fetchStatusWithPage(page page:UInt,callBack:fetchStatusBlock) -> Void {
        let query =  AVQuery(className: statusClassName)
        query.orderByAscending("creatAt");
        query.includeKey("imageArr")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            for object in objects {
                let object = object as! AVObject
                print(object["context"])
                print(object["imageArr"])
                let dic = object.dictionaryForObject() as [NSObject : AnyObject]
         
                let model = ZEStatusMdoel(className: statusClassName)
                
                let mdoel = ZEStatusMdoel(className:statusClassName, dictionary: dic)
                print(mdoel["context"])
                print(mdoel["imageArr"])
                
//                let json = JSON(object.dictionaryForObject())
//                let context = json["context"].stringValue
//                let imageArr = json["imageArr"]
//                let avfileDic = imageArr[0].dictionaryObject
//                
//                let avobject =  AVObject(dictionary: avfileDic)
//                let avfile = AVFile(AVObject:avobject)
                

            }
        }
    }
}