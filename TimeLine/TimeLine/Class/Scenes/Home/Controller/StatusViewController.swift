//
//  HomeViewController.swift
//  ZETimeLine
//
//  Created by 胡春源 on 16/5/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit



class StatusViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        XTStatusCloud.shareSingleOne.fetchStatusWithPage(page: 0) { (statusArr) in
            
            
            
            
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
