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
    var editedTasks = [Task]()
    
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        let buttonText = tableView.isEditing ? "Done" : "Edit"
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: buttonText, style: .plain, target: self, action: #selector(editButton(_:)))
        
        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
            if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            cell.todoList.isUserInteractionEnabled = tableView.isEditing
            }
        }
        
        if !tableView.isEditing { // Done 버튼을 눌렀을 때
                // 수정된 값으로 기존 tasks 배열 업데이트
                for indexPath in tableView.indexPathsForVisibleRows ?? [] {
                    if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell,
                       let newText = cell.todoList.text, !newText.isEmpty {
                        tasks[indexPath.row].title = newText
                    }
                }
            }
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alertControl = UIAlertController(title: "할 일 추가", message: "", preferredStyle: .alert)
                
                let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
                alertControl.addAction(cancelButton)
                
                let addButton = UIAlertAction(title: "추가", style: .default) { _ in
                    if let textField = alertControl.textFields?.first,
                       let text = textField.text {
                        let newTask = Task(id: self.tasks.count + 1, title: text, isCompleted: false)
                        self.tasks.append(newTask)
                        self.tableView.reloadData()
                    }
                }
                alertControl.addAction(addButton)
                
                alertControl.addTextField { textField in
                    textField.placeholder = "할 일을 입력하세요"
                }
                
                self.present(alertControl, animated: true, completion: nil)
            }
    
    
    
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
        cell.todoList.isUserInteractionEnabled = tableView.isEditing
        
        return cell
    }
    
    // 테이블뷰에서 특정 행이 선택되었을 때, 메서드 호출해 선택 상태 해제
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete // 삭제를 허용하는 스타일
    }
    
    // 삭제 처리
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 삭제할 데이터를 제거합니다.
            tasks.remove(at: indexPath.row)
            
            // 테이블 뷰에서 해당 행을 삭제합니다.
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    

}
