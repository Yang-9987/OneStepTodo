//
//  HomeView.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/26.
//

import SwiftUI

struct HomeView: View {

    // 当前选择页
    @State private var selectedTab: TabBarItem = .today

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    switch selectedTab {
                    case .today:
                        TodayView()
                            .navigationTitle("今日")
                            .navigationBarHidden(true)
                    case .addMission:
                        MissionListView()
                            .navigationTitle("任务列表")
                            .navigationBarTitleDisplayMode(.inline)
                    case .statistics:
                        StatisticsView()
                            .navigationTitle("统计")
                            .navigationBarTitleDisplayMode(.inline)
                    case .setting:
                        SettingsView()
                            .navigationTitle("设置")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                // Tabbar
                VStack{
                    Spacer()
                    CustomTabbar(selectedTab: $selectedTab)
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppSettings())
}

enum TabBarItem: String, CaseIterable {

    case today
    case addMission
    case statistics
    case setting

    var img: String {
        switch self {
        case .today:
            return "calendar.circle"
        case .addMission:
            return "plus.circle"
        case .setting:
            return "gear.circle"
        case .statistics:
            return "chart.bar"

        }
    }

    var cn_name: String {
        switch self {
        case .today:
            return "今日"
        case .addMission:
            return "添加"
        case .setting:
            return "设置"
        case .statistics:
            return "统计"

        }
    }

    var en_name: String {
        switch self {
        case .today:
            return "Today"
        case .addMission:
            return "AddMission"
        case .setting:
            return "Setting"
        case .statistics:
            return "Statistics"
        }
    }

}

struct CustomTabbar: View {
    @Binding var selectedTab: TabBarItem

    var body: some View {
        VStack {
            HStack {
                ForEach(TabBarItem.allCases, id: \.self) { item in
                    Spacer()
                    VStack(alignment: .center, content: {
                        Image(systemName: item.img)
                            .scaleEffect(selectedTab == item ? 1.25 : 1)
                            .foregroundColor(selectedTab == item ? Color("main") : .gray)
                            .font(.system(size: 20))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    selectedTab = item
                                }
                            }
                        Text(item.cn_name)
                            .foregroundColor(selectedTab == item ? .black : .gray)
                            .padding(5)
                    })
                    Spacer()
                }
            }
            .frame(width: nil, height: 80)
            .background(.thinMaterial)
            .cornerRadius(20)
            .padding()
        }
    }
}
