//
//  XibTableViewCell.swift
//  Lection 13 - TableView
//
//  Created by Viacheslav Bilyi on 7/1/19.
//  Copyright © 2019 Viacheslav Bilyi. All rights reserved.
//

import UIKit

protocol XibTableViewCellDelegate: class {
    func didChangeActivity(_ cell: XibTableViewCell, isActive: Bool)
}
class XibTableViewCell: UITableViewCell {

	@IBOutlet weak var xibTitleLabel: UILabel!
	@IBOutlet weak var xibDescriptionLabel: UILabel!

	private var task: Task?
    weak var delegate: XibTableViewCellDelegate?

	func configure(_ task: Task) {
		self.task = task
		xibTitleLabel.text = task.title
		xibDescriptionLabel.text = task.description
        if task.isActive {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
	}


}
