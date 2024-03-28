//
//  TableViewCell.swift
//  ToDo2
//
//  Created by 이유진 on 3/27/24.
//

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var todoList: UITextField!
    @IBOutlet weak var tappedButton: UIButton!
    
    @IBAction func checked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        updateTextFieldStyle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateTextFieldStyle()
        todoList.delegate = self // UITextFieldDelegate 설정
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        updateTextFieldStyle()
    }

    func updateTextFieldStyle() {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todoList.text ?? "")
        if tappedButton.isSelected {
            // 체크박스가 선택된 경우 중간 줄을 추가합니다.
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        } else {
            // 체크박스가 선택되지 않은 경우 중간 줄을 제거합니다.
            attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        }
        todoList.attributedText = attributeString
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           tappedButton.isSelected = false // 체크박스의 isSelected 속성을 false로 설정하여 해제
       }
    
}
