//
//  ZENewStatusModel.swift
//  ZENote
//
//  Created by 胡春源 on 16/4/27.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import Photos

class ZENewStatusModel: NSObject {
    
    /**
     保存图片的model封装
     
     - parameter text:    textView.text
     - parameter modelAr: PhotoImageModel数组
     */
    func setStatus(text:String,modelAr:[PhotoImageModel]){
        // 存储图片data的数组
        var imageArr:Array<NSData> = []
        
        
        let globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        // 创建信号量,初始化为0,碰到wait会停住,等有signal响应了才会执行下一步
        let semaphore =  dispatch_semaphore_create(0)
       
        // 开辟新线程
        dispatch_async(globalQueue, { () -> Void in
            // 遍历第三方model数组
            for i in 0..<modelAr.count {
                
                // 一些第三方需要的参数
                let model = modelAr[i]
                let options = PHImageRequestOptions()
                options.networkAccessAllowed = true
                
                
                // 取出图片的方法
                PhotoImageManager.sharedManager.requestImageDataForAsset(model.data!, options: options, resultHandler: { (data, dataUTI, oritation, info) -> Void in
                    if let data = data {
                        // 操作成功,取出data存到我要用的数组里
                        imageArr.append(data)
                        //加1,可以执行下一次for循环了
                        dispatch_semaphore_signal(semaphore)
                        
                    }
                })
     
                // 减一,挡住,等有signal时才会执行下一次for循环
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            }

            // for循环里面的所有block都执行完了
            XTStatusCloud.shareSingleOne.saveNewStatus(dataArr: imageArr, context: text) { (success, error) in
                
            }
        })

    }
    let weaterArr = [
        "云",
        "雨",
        "晴",
        "雪",
        "雾",
        "风",
    ]
    let fellArr = [
        "生气",
        "伤心",
        "开心",
        "担忧",
        "害怕",
        "其他"
        
    ]
    
            


    

}
