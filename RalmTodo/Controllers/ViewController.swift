//
//  ViewController.swift
//  RalmTodo
//
//  Created by 辻真緒 on 2019/07/30.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var todos:[Todo] = []
    
    fileprivate func reloadTableView() {
        // Realmに接続
        let realm  = try! Realm()
        // Todoの一覧を取得する
        todos = realm.objects(Todo.self).reversed()
        tableView.reloadData()
    }
    
    // 画面が初めて表示された1回だけしか実行されない
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        reloadTableView()
        
    }
    
    // 画面が表示されるたびに、実行される
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }

    @IBAction func didClickAddBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toNext", sender: nil)
        
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    // 何行表示させるのか
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        // 各セルに矢印を返せる
        cell.accessoryType = .disclosureIndicator
        
//        // 各セルに詳細ボタンをつけられる
//         cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // クリックされたTOOを取得する
        let todo = todos[indexPath.row]
        // todoの値を次の画面に返す
        performSegue(withIdentifier: "toNext", sender: todo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toNext" {
            // 次の画面のControllerを取得
            let inputVC = segue.destination as! inputViewController
            
            // 次の画面に選択されたTodoを設定
            inputVC.todo = sender as? Todo
        }
    }
}

