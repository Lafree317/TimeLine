//
//  SwiftMacro.swift
//  ZETimeLine
//
//  Created by 胡春源 on 16/5/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit


let window       = UIApplication.sharedApplication().windows.first//window
let screenBounds = UIScreen.mainScreen().bounds// 屏幕尺寸
let screenHight  = screenBounds.height//屏幕高度
let screenWidth  = screenBounds.width// 屏幕宽度
let now          = NSDate.init(timeIntervalSinceNow: 0)//当前时间