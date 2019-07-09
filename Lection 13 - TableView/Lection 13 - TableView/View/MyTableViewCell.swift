//
//  MyTableViewCell.swift
//  Lection 13 - TableView
//
//  Created by Viacheslav Bilyi on 7/1/19.
//  Copyright © 2019 Viacheslav Bilyi. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

	@IBOutlet weak var myTitleLabel: UILabel!

	func configure(_ task: Task) {
		myTitleLabel.text = task.title
	}

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
