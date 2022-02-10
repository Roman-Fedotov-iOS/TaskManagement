//
//  Home.swift
//  TaskManagement
//
//  Created by Roman Fedotov on 16.01.2022.
//

import SwiftUI

struct Home: View {
    
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                
                Section {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 10) {
                            ForEach(taskModel.currentWeek, id: \.self) { day in
                                
                                if #available(iOS 15.0, *) {
                                    VStack(spacing: 10) {
                                        
                                        Text(taskModel.extractDate(date: day, format: "dd"))
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                        
                                        Text(taskModel.extractDate(date: day, format: "EEE"))
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                        
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 8, height: 8)
                                            .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                    }
                                    .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                    .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                    .frame(width: 45, height: 90)
                                    .background(
                                        ZStack {
                                            
                                            if taskModel.isToday(date: day) {
                                                Capsule()
                                                    .fill(.black)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
                                    .contentShape(Capsule())
                                    .onTapGesture {
                                        withAnimation {
                                            taskModel.currentDate = day
                                        }
                                    }
                                } else {
                                    // Fallback on earlier versions
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Task()
                    
                } header: {
                    Header()
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    func Task() -> some View {
        
        LazyVStack(spacing: 18) {
            
            if let tasks = taskModel.filteredTasks {
                
                if tasks.isEmpty {
                    
                    Text("No tasks")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                } else {
                    
                    ForEach(tasks) { task in
                        TaskCard(task: task)
                    }
                }
            } else {
                ProgressView().offset(y: 100)
            }
        }
        .onChange(of: taskModel.currentDate) { newValue in
            taskModel.filterTodayTasks()
        }
    }
    
    func TaskCard(task: Task) -> some View {
        
        HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(taskModel.isCurrentHour(date: task.date) ? .black : .clear)
                    .frame(width: 18, height: 18)
                    .background(
                    Circle()
                        .stroke(.black, lineWidth: 1)
                        .padding(-3)
                    )
                    .scaleEffect(!taskModel.isCurrentHour(date: task.date) ? 0.8 : 1)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            
            VStack {
                
                HStack(alignment: .top, spacing: 10) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(task.title)
                            .font(.title2.bold())
                        
                        if #available(iOS 15.0, *) {
                            Text(task.description)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .hLeading()
                    
                    if #available(iOS 15.0, *) {
                        Text(task.date.formatted(date: .omitted, time: .shortened))
                    } else {
                        // Fallback on earlier versions
                    }
                    Button {
                        
                    } label: {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.black)
                                .padding(10)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .padding(.top)
                }
            }
            .foregroundColor(.white)
            .padding()
            .hLeading()
            .background(Color.black.cornerRadius(25))
        }
        .padding(.horizontal)
    }
    
    func Header() -> some View {
        
        HStack(spacing: 10) {
            
            VStack(alignment: .leading, spacing: 10) {
                
                if #available(iOS 15.0, *) {
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(.gray)
                } else {
                    // Fallback on earlier versions
                }
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                
            } label: {
                
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
            }
        }
        .padding()
        .padding(.top, 30)
        .background(Color.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func getSafeArea() -> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
