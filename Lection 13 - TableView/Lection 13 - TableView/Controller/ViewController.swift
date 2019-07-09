//
//  ViewController.swift
//  Lection 13 - TableView
//
//  Created by Viacheslav Bilyi on 7/1/19.
//  Copyright © 2019 Viacheslav Bilyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var myTableView: UITableView!

	private var tasks: [Task] = Task.load() {
		didSet {
			Task.save(tasks)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
        
        splitViewController?.preferredDisplayMode = .allVisible
        myTableView.tableFooterView = UIView()
        
		myTableView.dataSource = self
		myTableView.delegate = self

		let nib = UINib(nibName: "XibTableViewCell", bundle: nil)
		myTableView.register(nib, forCellReuseIdentifier: "xibCellID")

	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myTableView.reloadData()
    }
    
    func saveTask(task: Task) {
        self.tasks.append(task)
        self.myTableView.reloadData()
    }
    
    @IBAction func addButtonTouched(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addTaskNavVCID")
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = self
        self.present(vc, animated: true)
      vc.popoverPresentationController?.barButtonItem = sender
    }
}

// MARK: - Configure Table -
extension ViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return tasks.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "xibCellID", for: indexPath) as! XibTableViewCell

		cell.configure(tasks[indexPath.row])
        cell.delegate = self
		return cell
		
//		let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellID", for: indexPath) as! MyTableViewCell
//
//		cell.configure(tasks[indexPath.row])
//
//		return cell
	}
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewControllerID") as? DetailViewController  {
            vc.task = tasks[indexPath.row]
            vc.indexPath = indexPath
            vc.delegate = self
            splitViewController?.showDetailViewController(vc, sender: nil)

        }
//        let cell = tableView.cellForRow(at: indexPath)
//        if cell?.accessoryType == .checkmark {
//            cell?.accessoryType = .none
//        } else {
//        cell?.accessoryType = .checkmark
//        }
    }
}

extension ViewController: XibTableViewCellDelegate {
    func didChangeActivity(_ cell: XibTableViewCell, isActive: Bool) {
        if let indexPath = myTableView.indexPath(for: cell) {
            tasks[indexPath.row].isActive = isActive
            Task.save(tasks)
        }
    }
}
extension ViewController: UIPopoverPresentationControllerDelegate {
    
}
extension ViewController: DetailViewControllerDelegate {
    func changeTaskActivityStatus(isActive: Bool, indexPath: IndexPath) {
       tasks[indexPath.row].isActive = isActive
        Task.save(tasks)
        myTableView.reloadData()
    }
}
