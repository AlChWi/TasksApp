//
//  DetailViewController.swift
//  Lection 13 - TableView
//
//  Created by Alex P on 04/07/2019.
//  Copyright © 2019 Viacheslav Bilyi. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func changeTaskActivityStatus(isActive: Bool, indexPath: IndexPath)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isActiveLabel: UILabel!
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var taskActivitySwitch: UISwitch!
    
    
    var taskIsActiveLabel = "Task is active"
    var taskIsNotActiveLabel = "Task is not active"
    var task: Task?
    var indexPath: IndexPath?
    var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskImageView.layer.cornerRadius = 8
        if let task = self.task {
            titleLabel.text = task.title
            descriptionTextField.text = task.description
            taskImageView.image = UIImage(data: task.image)
            setDateLabel(from: task, for: dateLabel)
            setActivityLabel(from: task, for: isActiveLabel)
            taskActivitySwitch.isEnabled = true
            taskActivitySwitch.isOn = task.isActive
        } else {
            titleLabel.text = "Select task"
            descriptionTextField.text = ""
            dateLabel.text = ""
            isActiveLabel.text = ""
            taskActivitySwitch.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    
    private func setDateLabel(from task: Task, for label: UILabel) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: task.date)
        label.text = strDate
    }
    private func setActivityLabel(from task: Task, for label: UILabel) {
        if task.isActive {
            label.text = taskIsActiveLabel
        } else {
            label.text = taskIsNotActiveLabel
        }
    }
  
    @IBAction func taskActivitySwitchValueChanged(_ sender: UISwitch) {
        delegate?.changeTaskActivityStatus(isActive: sender.isOn, indexPath: indexPath!)
    }
}
