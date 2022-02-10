//
//  TaskViewModel.swift
//  TaskManagement
//
//  Created by Roman Fedotov on 16.01.2022.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    
    @Published var tasks: [Task] = [
        Task(title: "Task 1", description: "It is first task", date: .init(timeIntervalSince1970: 1643204613)),
        
        Task(title: "Task 2", description: "It is second task", date: .init(timeIntervalSince1970: 1643204613)),
        
        Task(title: "Task 3", description: "It is third task", date: .init(timeIntervalSince1970: 1643204613)),
        
        Task(title: "Task 4", description: "It is fourth task", date: .init(timeIntervalSince1970: 1643204613)),
        
        Task(title: "Task 5", description: "It is fifth task", date: .init(timeIntervalSince1970: 1643204613))
    ]
    
    @Published var currentWeek: [Date] = []
    
    @Published var currentDate: Date = Date()
    
    @Published var filteredTasks: [Task]?
    
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func filterTodayTasks() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calender = Calendar.current
            
            let filtered = self.tasks.filter {
                return calender.isDate($0.date, inSameDayAs: self.currentDate)
            }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDate, inSameDayAs: date)
    }
    
    func isCurrentHour(date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
