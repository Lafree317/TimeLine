//
//  ZERundom.swift
//  TimeLine
//
//  Created by 胡春源 on 16/5/21.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

public extension Int {
    /// SwiftRandom extension
    public static func random(range: Range<Int>) -> Int {
        return random(range.endIndex, range.startIndex)
    }
    
    /// SwiftRandom extension
    public static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}
public extension Float {
    /// SwiftRandom extension
    public static func random(lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}