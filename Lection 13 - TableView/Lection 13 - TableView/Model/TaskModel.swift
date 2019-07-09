//
//  TaskModel.swift
//  Lection 13 - TableView
//
//  Created by Viacheslav Bilyi on 7/1/19.
//  Copyright © 2019 Viacheslav Bilyi. All rights reserved.
//

import Foundation

class Task: Codable {
	var title: String
	var description: String
	var id: String
	var isActive: Bool
    var image: Data
    var date: Date

    init(title: String, description: String, isActive: Bool, image: Data, date: Date) {
		self.title = title
		self.description = description
		self.id = UUID().uuidString
		self.isActive = isActive
        self.image = image
        self.date = date
	}
}
//MARK: - USER DEFAULTS -
extension Task {
    
    static let userDefaultsKey = "TasksKey"
    
    static func save(_ tasks: [Task]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
    static func load() -> [Task] {
        var returnValue: [Task] = []
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey), let tasks = try? JSONDecoder().decode([Task].self, from: data){
            returnValue = tasks
        }
            return returnValue
    }
}
