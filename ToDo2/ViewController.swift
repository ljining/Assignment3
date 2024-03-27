//
//  ViewController.swift
//  ToDo2
//
//  Created by 이유진 on 3/27/24.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tasks = [Task]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tasks.append(Task(id: 1, title: "First", isCompleted: false))

    }


}

struct Task {
    let id: Int
    var title: String
    var isCompleted: Bool
    
    init(id: Int, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //tableView에 할 일 목록 개수 반환(행)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //tableView 각 행의 셀 반환. 텍스트 필드 활성화 및 텍스트 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let task = tasks[indexPath.row]
        cell.todoList.text = task.title
        cell.tappedButton.setTitle("Button", for: .normal)
        cell.todoList.isUserInteractionEnabled = true
        
        return cell
    }
}

