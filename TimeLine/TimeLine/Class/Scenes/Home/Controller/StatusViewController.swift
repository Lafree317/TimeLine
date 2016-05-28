//
//  HomeViewController.swift
//  ZETimeLine
//
//  Created by 胡春源 on 16/5/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit


let StatusCellId = "StatusCellId"
class StatusViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ZETableViewModel()
    let model = ZEStatusVCModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSomething()
        getData()
        
    }
    
    /**
     加载ViewModel,Model 刷新数据
     */
    func layoutSomething(){
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        viewModel.sectionCount = 1
        viewModel.cellHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib.init(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: StatusCellId)
        weak var weakSelf = self
        viewModel.cellRender = { indexPath,tablleView in
            let cell = tablleView.dequeueReusableCellWithIdentifier(StatusCellId, forIndexPath: indexPath) as! StatusCell
            cell.setDate(weakSelf!.model.dataArr[indexPath.row])
            return cell
        }
        viewModel.cellSlect = { indexPath,tablleView in
            print(weakSelf!.model.dataArr[indexPath.row].context)
        }
    }
    
    /**
     加载数据
     */
    func getData(){
//        ZEHud.sharedInstance.showHud()
        model.getData(0) { (success, status) in
            self.viewModel.rawCount = self.model.dataArr.count
            if success {
                self.tableView.reloadData()
                ZEHud.sharedInstance.showSuccess(status)
            }else{
                ZEHud.sharedInstance.showError(status)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }


}
