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
    
    let leftCell = "left_cell";
    let rightCell = "right_cell"
    
    let leftArrys = [""];
    var rightArrys = [""]
    
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
        UIView.animate(withDuration: 0.2) {
            () in
            self.ModalViewHeight.constant = 1
            self.leftTableView.isHidden = true;
            self.rightTableView.isHidden = true;
            self.modelArrys.removeAll()
            self.view.setNeedsLayout()
             self.view.layoutIfNeeded()
        }
    }
    
    
    func loadJiaData(){
        for i in 0..<2{
            let model = AJModel(title: "left\(i)", subArrys: ["\(i)-\(i)","\(i)-\(i)","\(i)-\(i)"])
            self.modelArrys.append(model)
        }
    }
    

    

    @IBAction func selectorAction(_ sender: UIButton) {
        
        
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

                
                let model = self.modelArrys[0]
                self.rightArrys = model.subArrys
                
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
                
                self.modelArrys = [AJModel.init(title: "单价", subArrys: ["12","333","444"]),AJModel.init(title: "不限", subArrys: ["56757","56","345"])]
                let model = self.modelArrys[0]
                self.rightArrys = model.subArrys
                
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
                self.rightTableView.isHidden = true;
                
                self.ModalViewHeight.constant = self.view.frame.size.height
                
                self.leftTableView.frame = CGRect.init(x: 0, y: 0, width: self.modelView.frame.width, height: 300)
                
                self.modelArrys = [AJModel.init(title: "户型1", subArrys: []),AJModel.init(title: "户型2", subArrys: [])]
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
            return modelArrys.count
        }else{
            return self.rightArrys.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftCell, for: indexPath)
            let model = self.modelArrys[indexPath.row]
            cell.textLabel?.text = model.title
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: rightCell, for: indexPath)
            cell.textLabel?.text = rightArrys[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        
        
        if tableView == self.leftTableView{
            let model = self.modelArrys[indexPath.row]
             let rightDatas = model.subArrys
            self.rightArrys = rightDatas
            let sectionIndex = IndexSet(integer: indexPath.section)
            self.rightTableView.reloadSections(sectionIndex, with: .none)
            print("刷新单left")
        }else{
            print("这是右边",indexPath.row)
            
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
