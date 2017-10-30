//
//  ListViewController.swift
//  api_test
//
//  Created by 大野 佑太郎 on 2017/10/04.
//  Copyright © 2017年 大野 佑太郎. All rights reserved.
//

import UIKit
import UIKit
import Alamofire // Alamofireをimport
import SwiftyJSON // SwiftyJSONをimport


class ListViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {
    let table = UITableView()
    var lists:[String] = []
    var searchController = UISearchController()
    var searchResults:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "goからデータを取ってくるよ" // Navigation Barのタイトルを設定

        table.frame = view.frame // tableの大きさをviewの大きさに合わせる
        view.addSubview(table) // viewにtableを乗せる
        table.dataSource = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        table.tableHeaderView = searchController.searchBar

        getArticles()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 文字が入力される度に呼ばれる
    func updateSearchResults(for searchController: UISearchController) {
        self.searchResults = lists.filter{
            // 大文字と小文字を区別せずに検索
            $0.lowercased().contains(searchController.searchBar.text!.lowercased())
        }
        self.table.reloadData()
    }
    
    func getArticles() {
        Alamofire.request("http://localhost:8080/api/hello")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                json["prefectures"].forEach { (_, prefecture) in
                    let list = prefecture["name"].string!
                    self.lists.append(list)
                }
                self.table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return lists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

        
        if searchController.isActive {
            cell.textLabel!.text = "\(searchResults[indexPath.row])"
        } else {
            let article = lists[indexPath.row]
            cell.textLabel?.text = article
        }
        
        return cell
    }
    @IBAction func go(_ sender: Any) {
         performSegue(withIdentifier: "next", sender: nil)
    }
    
    

}
