//
//  ViewController.swift
//  PhotoPicker
//
//  Created by liangqi on 16/3/4.
//  Copyright © 2016年 dailyios. All rights reserved.
//

import UIKit
import Photos

class ZENewStatusewController: UIViewController,PhotoPickerControllerDelegate {
    
    @IBOutlet weak var weaterFellButton: UIButton!
    var selectModel = [PhotoImageModel]()
    var containerView = UIView()
    var model = ZENewStatusModel()
    @IBOutlet weak var textView: UITextView!
    var triggerRefresh = false
    let startY:CGFloat = 150+30+64 // 底部选择图片开始的高度,150:TextView,30:Button,64:Navigation

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.containerView)
        
        self.checkNeedAddButton()
        self.renderView()
    }
    
    @IBAction func weaterFellButtonClick(sender: UIButton) {
        UsefulPickerView.showMultipleColsPicker("今天的天气和心情?", data: [model.weaterArr,model.fellArr], defaultSelectedIndexs: [2,2]) { (selectedIndexs, selectedValues) in
            let str = "天气:"+selectedValues[0] + "  " + "心情:" + selectedValues[1]
            self.weaterFellButton.setTitle(str, forState: .Normal)
            
        }
    }
    @IBAction func leftAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    @IBAction func rightAction(sender: UIBarButtonItem) {
        print(textView.text)
        model.setStatus(textView.text, modelAr: getModelExceptButton())
               
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: 以下为图片选择的代码
    private func checkNeedAddButton(){
        if self.selectModel.count < PhotoPickerController.imageMaxSelectedNum && !hasButton() {
            selectModel.append(PhotoImageModel(type: ModelType.Button, data: nil))
        }
    }
    
    private func hasButton() -> Bool{
        for item in self.selectModel {
            
            if item.type == ModelType.Button {
                return true
            }
        }
        return false
    }
    
    func removeElement(element: String?){
        if let localIdentifier = element {
            for i in 0 ..< self.selectModel.count {
                let model = self.selectModel[i]
                if model.data?.localIdentifier == localIdentifier {
                    self.selectModel.removeAtIndex(i)
                    self.triggerRefresh = true
                    return;
                }
            }
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.barStyle = .Default
        
        if self.triggerRefresh {
            self.triggerRefresh = false
            self.updateView()
        }
        
    }
    
    private func updateView(){
        self.clearAll()
        self.checkNeedAddButton()
        self.renderView()
    }
    
    private func renderView(){
        
        if selectModel.count <= 0 {return;}
        
        let totalWidth = UIScreen.mainScreen().bounds.width
        let space:CGFloat = 10
        let lineImageTotal = 4
        
        let line = self.selectModel.count / lineImageTotal
        let lastItems = self.selectModel.count % lineImageTotal
        
        let lessItemWidth = (totalWidth - (CGFloat(lineImageTotal) + 1) * space)
        let itemWidth = lessItemWidth / CGFloat(lineImageTotal)
        
        for i in 0 ..< line {
            let itemY = CGFloat(i+1) * space + CGFloat(i) * itemWidth
            for j in 0 ..< lineImageTotal {
                let itemX = CGFloat(j+1) * space + CGFloat(j) * itemWidth
                let index = i * lineImageTotal + j
                self.renderItemView(itemX, itemY: itemY, itemWidth: itemWidth, index: index)
            }
        }
        
        // last line
        for i in 0 ..< lastItems {
            let itemX = CGFloat(i+1) * space + CGFloat(i) * itemWidth
            let itemY = CGFloat(line+1) * space + CGFloat(line) * itemWidth
            let index = line * lineImageTotal + i
            self.renderItemView(itemX, itemY: itemY, itemWidth: itemWidth, index: index)
        }
        
        let totalLine = ceil(Double(self.selectModel.count) / Double(lineImageTotal))
        let containerHeight = CGFloat(totalLine) * itemWidth + (CGFloat(totalLine) + 1) *  space
        self.containerView.frame = CGRectMake(0, startY , totalWidth,  containerHeight)
    }
    
    private func renderItemView(itemX:CGFloat,itemY:CGFloat,itemWidth:CGFloat,index:Int){
        let itemModel = self.selectModel[index]
        let button = UIButton(frame: CGRectMake(itemX, itemY, itemWidth, itemWidth))
        button.backgroundColor = UIColor.redColor()
        button.tag = index
        
        if itemModel.type == ModelType.Button {
            button.backgroundColor = UIColor.clearColor()
            button.addTarget(self, action: #selector(eventAddImage), forControlEvents: .TouchUpInside)
            button.contentMode = .ScaleAspectFill
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).CGColor
            button.setImage(UIImage(named: "image_select"), forState: UIControlState.Normal)
        } else {
            button.addTarget(self, action: #selector(eventPreview(_:)), forControlEvents: .TouchUpInside)
            if let asset = itemModel.data {
                let pixSize = UIScreen.mainScreen().scale * itemWidth
             
                PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSizeMake(pixSize, pixSize), contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image, info) -> Void in
                    if image != nil {
                        button.setImage(image, forState: UIControlState.Normal)
                        button.contentMode = .ScaleAspectFill
                        button.clipsToBounds = true
                    }
                })
            }
        }
        self.containerView.addSubview(button)
    }
    
    private func clearAll(){
        for subview in self.containerView.subviews {
            if let view =  subview as? UIButton {
                view.removeFromSuperview()
            }
        }
    }
    
    // MARK: -  button event 选中图片
    func eventPreview(button:UIButton){
        let preview = SinglePhotoPreviewViewController()
        let data = self.getModelExceptButton()
        preview.selectImages = data
        preview.sourceDelegate = self
        preview.currentPage = button.tag
        self.showViewController(preview, sender: nil)
    }
    
    
    func eventAddImage() {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // change the style sheet text color
        alert.view.tintColor = UIColor.blackColor()
        
        let actionCancel = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        let actionCamera = UIAlertAction.init(title: "拍照", style: .Default) { (UIAlertAction) -> Void in
            self.selectByCamera()
        }
        
        let actionPhoto = UIAlertAction.init(title: "从手机照片中选择", style: .Default) { (UIAlertAction) -> Void in
            self.selectFromPhoto()
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionCamera)
        alert.addAction(actionPhoto)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /**
     拍照获取
     */
    private func selectByCamera(){
        // todo take photo task
        self.textView.resignFirstResponder()
    }
    
    /**
     从相册中选择图片
     */
    private func selectFromPhoto(){
        self.textView.resignFirstResponder()
        PHPhotoLibrary.requestAuthorization { (status) -> Void in
            switch status {
            case .Authorized:
                self.showLocalPhotoGallery()
                break
            default:
                self.showNoPermissionDailog()
                break
            }
        }
    }
    
    private func showNoPermissionDailog(){
        let alert = UIAlertController.init(title: nil, message: "没有打开相册的权限", preferredStyle: .Alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func showLocalPhotoGallery(){
        let picker = PhotoPickerController(type: PageType.RecentAlbum)
        picker.imageSelectDelegate = self
        picker.modalPresentationStyle = .Popover
        
        // max select number
        PhotoPickerController.imageMaxSelectedNum = 9
        
        // already selected image num
        let realModel = self.getModelExceptButton()
        PhotoPickerController.alreadySelectedImageNum = realModel.count
        
        self.showViewController(picker, sender: nil)
    }
    
    func onImageSelectFinished(images: [PHAsset]) {
        self.renderSelectImages(images)
    }
    
    private func renderSelectImages(images: [PHAsset]){
        for item in images {
            self.selectModel.insert(PhotoImageModel(type: ModelType.Image, data: item), atIndex: 0)
        }
        
        if self.selectModel.count > PhotoPickerController.imageMaxSelectedNum {
            for i in 0 ..< self.selectModel.count {
                let item = self.selectModel[i]
                if item.type == .Button {
                    self.selectModel.removeAtIndex(i)
                }
            }
        }
        self.renderView()
    }
    
    /**
     - returns: 取出刨去添加button的 纯imagemodel数组
     */
    private func getModelExceptButton()->[PhotoImageModel]{
        var newModels = [PhotoImageModel]()
        for i in 0 ..< self.selectModel.count {
            let item = self.selectModel[i]
            if item.type != .Button {
                newModels.append(item)
            }
        }
        return newModels
    }

    
}

