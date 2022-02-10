//
//  Task.swift
//  TaskManagement
//
//  Created by Roman Fedotov on 16.01.2022.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var date: Date
}
