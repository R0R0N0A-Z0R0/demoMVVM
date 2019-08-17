//
//  ViewController.swift
//  demoMVVM
//
//  Created by Nguyen Trung on 8/8/19.
//  Copyright © 2019 Nguyen Trung. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var searchInputTextField: UITextField!
    
    
    @IBOutlet weak var userTableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var userViewModel = UserViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        doTable()
        doTable2()
        // Do any additional setup after loading the view, typically from a nib.
        userTableView.estimatedRowHeight = 150
        userTableView.rowHeight = 150
    }

    func bindUI(){
        print("bbbbbbbb")
        self.searchInputTextField.rx.text.asObservable().bind(to: self.userViewModel.searchInput).disposed(by: disposeBag)
        
        print("ffffff")
        
        self.userViewModel.searchResult.asObservable().bind(to: self.userTableView.rx.items(cellIdentifier: "Cell", cellType: TableViewCell.self)){
            (index,user,cell) in
            cell.userNameLabel.text = user.userName
            cell.idLabel.text = String(user.id)
            }.disposed(by: disposeBag)
    }
    
    func doTable(){
        userTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            let cell = self?.userTableView.cellForRow(at: indexPath) as? TableViewCell
            cell?.backgroundColor = UIColor.blue
            print("cccccccccccc")
        }).disposed(by: disposeBag)
    }
    
    func doTable2(){
        userTableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            let cell = self?.userTableView.cellForRow(at: indexPath) as? TableViewCell
            if cell?.editingStyle == .delete{
                print("da xoa")
                
                self?.userViewModel.remove
                
            }
        }).disposed(by: disposeBag)
    }
    
    

}

