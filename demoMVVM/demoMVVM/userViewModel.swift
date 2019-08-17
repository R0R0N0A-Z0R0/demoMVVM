//
//  userViewModel.swift
//  demoMVVM
//
//  Created by Nguyen Trung on 8/8/19.
//  Copyright © 2019 Nguyen Trung. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserViewModel:NSObject {
    
    
    
    var searchInput = BehaviorRelay<String?>(value: "")
    var searchResult = BehaviorRelay<[UserModel]>(value: [])
    //var searchResult = [UserModel]()
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        bindingData()
    }
    
    func bindingData(){
        print("aaaaaaaa")
        self.searchInput.asObservable().subscribe(onNext: { (text) in
            if text!.isEmpty {
                self.searchResult.accept([])
            } else
            {
                self.requestJSON(url: "https://api.github.com/search/users?q=\(text!)")
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    func requestJSON(url:String){
        print("xxxxxxxxx.........")
        let url = URL(string: url)
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, res, err) in
            if err == nil {
                print("Resume.........")
                do {
                    if let result:Dictionary<String,Any> = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String,Any>{
                        var userArray:Array<UserModel> = []
                        if let items:Array<Any> = result["items"] as? Array<Any> {
                            for i in items{
                                let user = UserModel(object: i)
                                userArray.append(user)
                            }
                        self.searchResult.accept(userArray)
                        }
                    }
                } catch{}
            }
        }.resume()
    }
    
}
