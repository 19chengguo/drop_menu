//
//  AJModel.swift
//  AJSeletor
//
//  Created by ChengGuoTech || CG-005 on 2020/10/19.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import Foundation

struct AJModel {
    var title:String
    var subItems:[Items]
    var isSelected: Bool
}


struct Items{
    var isChecked:Bool
    var subTitle: String
    
}
