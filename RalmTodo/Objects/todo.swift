//
//  todo.swift
//  RalmTodo
//
//  Created by 辻真緒 on 2019/07/30.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import RealmSwift

// オブジェクトを継承したTodoクラスを作成
class Todo: Object {
    // ID （連番）
    @objc dynamic var id: Int = 0
    // タイトル
    @objc dynamic var title: String = ""
    // nilを許容したくないから、?は取り除いた
    // 登録日時
    @objc dynamic var date:Date = Date()
    
}
