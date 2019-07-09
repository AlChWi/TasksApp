//
//  AddTaskTableViewController.swift
//  Lection 13 - TableView
//
//  Created by Alex P on 07/07/2019.
//  Copyright © 2019 Viacheslav Bilyi. All rights reserved.
//

import UIKit



class AddTaskTableViewController: UITableViewController {

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskActivitySwitch: UISwitch!
    
    
//    private var tasks: [Task] = Task.load() {
//        didSet {
//            Task.save(tasks)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        taskTitleTextField.delegate = self
        taskDescriptionTextView.delegate = self
        
        setDateLabel()
    }
    
    private func checkIfSavePossible() {
        if taskTitleTextField.text != "" && taskDescriptionTextView.text != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    private func setDateLabel() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: taskDatePicker.date)
        dateLabel.text = strDate
    }
    
   
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        setDateLabel()
    }
    @IBAction func cancelButtonTouched(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    @IBAction func doneButtonTouched(_ sender: UIBarButtonItem) {
        if let imageData = taskImageView.image?.pngData(), let titleText = taskTitleTextField.text, let description = taskDescriptionTextView.text {
            let task = Task(title: titleText, description: description, isActive: taskActivitySwitch.isOn, image: imageData, date: taskDatePicker.date)
            let source = self.popoverPresentationController?.delegate as! ViewController
            source.saveTask(task: task)
        }
        
//        let imageData = taskImageView.image!.pngData()
//        let task = Task(title: taskTitleTextField.text!, description: taskDescriptionTextView.text!, isActive: true, image: imageData!, date: taskDatePicker.date)
//        let source = self.popoverPresentationController?.delegate as! ViewController
//        source.saveTask(task: task)
        self.dismiss(animated: true)
    }
    @IBAction func addImageTouched(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Image source", message: "Choose an image", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "from photo library", style: .default, handler: {(action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "camera", style: .default, handler: {(action: UIAlertAction) in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(action: UIAlertAction) in
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }

}
extension AddTaskTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkIfSavePossible()
    }
}
extension AddTaskTableViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkIfSavePossible()
    }
}
extension AddTaskTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        taskImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}

