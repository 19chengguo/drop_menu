//
//  ViewController.swift
//  AJSeletor
//
//  Created by ChengGuoTech || CG-005 on 2020/10/19.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    

    @IBOutlet weak var navBar: UIStackView!
    @IBOutlet weak var modelView: UIView!
    
    @IBOutlet weak var ModalViewHeight: NSLayoutConstraint!
    
    var isShowModel : Bool = false
    var isClickMenu: Bool = false
    var isRepeatChoose: Int = 0
    
    let leftCell = "left_cell";
    let rightCell = "right_cell"
    
    var rightArrys = [Items]();
    
    
    var modelArrys = [AJModel]()
    
    lazy var leftTableView : UITableView = {
        let tab = UITableView(frame: CGRect.init(x: 0, y: 0, width: self.modelView.frame.width / 2, height: 300), style: .plain)
        tab.delegate = self;
        tab.dataSource = self;
        tab.register(UITableViewCell.self, forCellReuseIdentifier: leftCell)
        tab.isHidden = true;
        return tab
    }()
    
    
    lazy var rightTableView: UITableView = {
        let tab = UITableView(frame: CGRect.init(x: self.modelView.frame.width/2, y: 0, width:self.modelView.frame.width / 2 , height: 300), style: .plain)
        tab.delegate = self;
        tab.dataSource = self;
        tab.isHidden = true;
        tab.register(UITableViewCell.self, forCellReuseIdentifier: rightCell)
        return tab
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.modelView.addSubview(self.leftTableView)
        self.modelView.addSubview(self.rightTableView)
        
        let g = UITapGestureRecognizer.init(target: self, action: #selector(showModel))
        g.delegate = self
        self.modelView.addGestureRecognizer(g)
            
        
    }
    
    @objc func showModel(){
        self.isShowModel = !self.isShowModel
        self.isClickMenu = !self.isClickMenu
        self.isRepeatChoose = 0
        self.modelArrys.removeAll()
        self.rightArrys.removeAll()
        UIView.animate(withDuration: 0.2) {
            () in
            self.ModalViewHeight.constant = 1
            self.leftTableView.isHidden = true;
            self.rightTableView.isHidden = true;
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    
    func loadJiaData(){
        for i in 0..<2{
            let model = AJModel(title: "left", subItems: [
            Items.init(isChecked: false, subTitle: "left - \(i)"),
            Items.init(isChecked: false, subTitle: "left - \(i)"),
            Items.init(isChecked: false, subTitle: "left - \(i)"),
            ], isSelected: false)
            
            self.modelArrys.append(model)
        }
        
        print(self.modelArrys)
    }
    

    

    @IBAction func selectorAction(_ sender: UIButton) {
        
        if self.isShowModel && self.isRepeatChoose == sender.tag {
            print("重复选择开始关闭")
            showModel()
            return
        }
        
        //如果已经打开model，进行menu切换操作
        if self.isClickMenu {
            print("此时model出来了，开始切换menu",self.isClickMenu,sender.tag)
            
            if modelArrys.count > 0{
                modelArrys.removeAll()
            }
            switchByType(sender.tag)
            return
        }
        
        self.isShowModel = !self.isShowModel
        self.isClickMenu = !self.isClickMenu
        switchByType(sender.tag)
    }
    
    
    func switchByType(_ type: Int){
        
        let tag = type
        self.isRepeatChoose = tag

        switch tag {
        case 1:
            loadOne()
        case 2:
            loadTwo()
        case 3:
            loadThree()
        case 4:
            loadFive()
        default:
            fatalError()
        }
        
        
    }
    
    func loadOne(){
 
        
        if isShowModel {
            UIView.animate(withDuration: 0.2) {
                () in
                self.leftTableView.isHidden = false;
                self.rightTableView.isHidden = false;
                self.ModalViewHeight.constant = self.view.frame.size.height
                
                self.loadJiaData()

                //拿到ajmodel 子属性
                let model = self.modelArrys[0].subItems
                self.rightArrys = model
                
                self.leftTableView.reloadData();
                self.rightTableView.reloadData()
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func loadTwo(){
 
        if isShowModel {
            UIView.animate(withDuration: 0.2) {
                () in
                self.rightTableView.isHidden = false;
                self.leftTableView.isHidden = false;
                self.ModalViewHeight.constant = self.view.frame.size.height

                
                let tempStrs = ["单价","不限"];
                var index = 0
                var tempModelArry = [AJModel]()
                for i in tempStrs{
                    let model = AJModel(title: i, subItems: [
                    Items.init(isChecked: false, subTitle: "right - \(index)"),
                    Items.init(isChecked: false, subTitle: "right - \(index)"),
                    Items.init(isChecked: false, subTitle: "right - \(index)"),
                    ], isSelected: false)
                    
                    index += 1
                    tempModelArry.append(model)
                }
                
                self.modelArrys = tempModelArry
                let model = self.modelArrys[0].subItems
                self.rightArrys = model
                
                self.leftTableView.reloadData();
                self.rightTableView.reloadData()
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func loadThree(){
 
        if isShowModel {
            UIView.animate(withDuration: 0.2) {
                () in
                self.leftTableView.isHidden = false;
                self.rightTableView.isHidden = true
                self.ModalViewHeight.constant = self.view.frame.size.height
                
                self.leftTableView.frame = CGRect.init(x: 0, y: 0, width: self.modelView.frame.width, height: 300)
                                
                let tempStrs = ["户型1","户型2"];
                var index = 0
                var tempModelArry = [AJModel]()
                for i in tempStrs{
                    let model = AJModel.init(title: i, subItems: [], isSelected: false)
                    index += 1
                    tempModelArry.append(model)
                }
                self.modelArrys = tempModelArry
                   
                
                self.leftTableView.reloadData()
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func loadFive(){
        
    }
    
}
 
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.leftTableView {
            return  self.leftTableView.isHidden == false ? modelArrys.count : 0
        }else{
            return self.rightTableView.isHidden == false ? self.rightArrys.count  : 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftCell, for: indexPath)
            let model = self.modelArrys[indexPath.row]
            
            if model.isSelected {
                cell.textLabel?.textColor = UIColor.lightGray;
            }
            
            cell.textLabel?.text = model.title
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: rightCell, for: indexPath)
            
            
            let model  = self.rightArrys[indexPath.row];
            
            if model.isChecked {
                cell.textLabel?.textColor = UIColor.red;
            }else{
                cell.textLabel?.textColor = UIColor.black
            }
            
            
            cell.textLabel?.text = model.subTitle
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //针对户型
        if tableView == self.leftTableView && self.rightTableView.isHidden {
            print("left 选取单个",indexPath.row)
            
            return
        }
        //两栏事件
        if tableView == self.leftTableView{
            let model = self.modelArrys[indexPath.row]
            let rightDatas = model.subItems
            self.rightArrys = rightDatas
            let sectionIndex = IndexSet(integer: indexPath.section)
            self.rightTableView.reloadSections(sectionIndex, with: .none)
            print("刷新单left",indexPath)
        }else{
            
            var model = self.rightArrys[indexPath.row]
            model.isChecked = !model.isChecked
            
            
            self.rightArrys[indexPath.row] = model
            
            self.rightTableView.reloadRows(at: [indexPath], with: .none)
            
            print("这是右边",self.rightArrys[indexPath.row])
            
        }
    }
    
}

extension ViewController:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.leftTableView) == true {
            return false
        }
        
        if touch.view?.isDescendant(of: self.rightTableView) == true{
            return false
        }else{
             return true
        }
    }
}
