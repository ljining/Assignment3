//
//  TableViewCell.swift
//  ToDo2
//
//  Created by 이유진 on 3/27/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var todoList: UITextField!
    @IBOutlet weak var tappedButton: UIButton!
    
    @IBAction func checked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
