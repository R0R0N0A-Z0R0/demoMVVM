//
//  userModel.swift
//  demoMVVM
//
//  Created by Nguyen Trung on 8/8/19.
//  Copyright © 2019 Nguyen Trung. All rights reserved.
//

import Foundation

struct UserModel {
    var userName:String!
    var id:Int!
    
    init() {
        self.userName = ""
        self.id = 0
    }
    
    init(object:Any) {
        
        if let dic:Dictionary<String,Any> = object as? Dictionary<String,Any>{
            if let userName = dic["login"] as? String {
                self.userName = userName
            } else {
                self.userName = ""
            }
            
            if let id = dic["id"] as? Int {
                self.id = id
            } else {
                self.id = 0
            }
            
        }else{
            self.userName = ""
            self.id = 0
        }
    }
}
