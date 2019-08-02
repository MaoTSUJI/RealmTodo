//
//  inputViewController.swift
//  RalmTodo
//
//  Created by 辻真緒 on 2019/07/30.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit
import RealmSwift

class inputViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    // 前の画面から渡されてきたTODOを受け取る変数
    var todo: Todo? = nil   // 新規で入ってきた場合は、中身はnil!!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if todo != nil {
            button.setTitle("追加", for: .normal) // 各セルから押された時
            textField.text = todo?.title    // Todoの型がそもそも?で指定しているから
        }
        
    }
    
    fileprivate func createNewTodo(_ text: String) {
        // Realmに接続
        let realm = try! Realm()
        
        // データを登録する　Todo.swiftで作成したTodo()クラスのインスタンス化
        let todo = Todo()
        
        // 最大のIDを取得
        let id = getMaxId()
        
        todo.id = id
        todo.title = text   // 引数のtext
        todo.date = Date()
        
        // 作成したTODOを登録する    // こういう構文
        try! realm.write {
            realm.add(todo)
        }
    }
    
    fileprivate func updateTodo(_ text: String) {
        // 更新
        let realm = try! Realm()
        try! realm.write {
            todo?.title = text
        }
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
        // 空文字かどうかチェックする
////        if textField.text == "" {
////        }
//        if let title = textField.text {
//            // textField.textがnilかどうかチェックする
//            // nil出ない場合
//            if textField.text!.isEmpty {
//                    // 空文字出ない場合
//            }
//        }
        
        // オプショナルバインディング　別ver
        // nilかどうかをチェックする
        guard let text = textField.text else {
            // textField.text がnilの場合、      // アプリ側のバグでnilが発生することが稀にある
            // ボタンがクリックされた時のし処理を中断
            return
        }
        // ここ↓のtextは上記条件文で定義したtext = textField.textのこと。
        // すでに剥がしたあとなので、！はいらない
        if text.isEmpty {
            // textField.textが空文字の場合
            // ボタンがクリックされた時の処理を中断
            return
        }
        
        if todo == nil {
            // 新規タスクを追加 // 入力された文字列textをメソッドの引数に与える
            createNewTodo(text)
        } else {
            updateTodo(text)
        }
        
        
        // NavifationControllerの持っている履歴から、1つ前の画面に戻る
        navigationController?.popViewController(animated: true)
        
    }
    // 最大のIDを取得　２種類
    // １つ目：参考演算子を使ったやり方　（見にくいからあまりオススメしない）
    //        let id = (realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1
    
    // ２つ目：最大IDを取得するメソッド
    func getMaxId() -> Int {
        // Realmに接続
        let realm = try! Realm()
        // Todoシートから最大のIDを取得する
        let id = realm.objects(Todo.self).max(ofProperty:"id") as Int?
        
        if id == nil {
            // 最大IDがnil(存在しない)場合、1を返す
            return 1
        } else {
            // 最大IDが存在する場合、最大ID + 1 を返す
            // 新しい番号を与える
            return id! + 1
        }
    }
    
    
    
}
