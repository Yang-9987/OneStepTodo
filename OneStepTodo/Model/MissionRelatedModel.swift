//
//  MissionRelatedModel.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/26.
//

import Foundation
import AppIntents

struct Mission: Identifiable, Codable {

    let id: UUID
    var title: String
    var category: MissionCategory
    var createDate: Date
    var missionType: MissionType
    var notes: [note]
    var targetDoneTimes: Int
    var doneTimes: Int
    var targetDoneIntervalTime: Double
    var doneIntervalTime: Double
    var isCompleted: Bool
    var isImportant: Bool

    init(id: UUID = UUID(), title: String, category: MissionCategory, createDate: Date, missionType: MissionType, content: [note], targetDoneTimes: Int = 0, doneTimes: Int = 0, targetDoneIntervalTime: Double = 0, doneIntervalTime: Double = 0, isCompleted: Bool, isImportant: Bool) {
        self.id = id
        self.title = title
        self.category = category
        self.createDate = createDate
        self.missionType = missionType
        self.notes = content
        self.targetDoneTimes = targetDoneTimes
        self.doneTimes = doneTimes
        self.targetDoneIntervalTime = targetDoneIntervalTime
        self.doneIntervalTime = doneIntervalTime
        self.isCompleted = isCompleted
        self.isImportant = isImportant
    }

    static var emptyMission: Mission{
        Mission(title: "新建任务", category: MissionCategory.emptyMissionCategory, createDate: Date(), missionType: .metering, content: [], targetDoneTimes: 0, doneTimes: 0, targetDoneIntervalTime: 0, doneIntervalTime: 0, isCompleted: false, isImportant: false)

    }

    struct Data {
        var title: String = ""
        var category: MissionCategory = MissionCategory(id: "default", name: "预设", color: "FLAT FLESH", icon: "scribble")
        var createDate: Date = Date()
        var missionType: MissionType = .metering
        var content: [note] = []
        var targetDoneTimes: Int = 0
        var doneTimes: Int = 0
        var targetDoneIntervalTime: Double = 0
        var doneIntervalTime: Double = 0
        var isCompleted: Bool = false
        var isImportant: Bool = false
    }

    var data: Data{
        Data(title: title, category: category, createDate: createDate, missionType: missionType, content: notes, targetDoneTimes: targetDoneTimes, doneTimes: doneTimes, targetDoneIntervalTime: targetDoneIntervalTime, doneIntervalTime: doneIntervalTime, isCompleted: isCompleted, isImportant: isImportant)
    }

    mutating func update(from data: Data) {
        title = data.title
        category = data.category
        createDate = data.createDate
        missionType = data.missionType
        notes = data.content
        targetDoneTimes = data.targetDoneTimes
        doneTimes = data.doneTimes
        targetDoneIntervalTime = data.targetDoneIntervalTime
        doneIntervalTime = data.doneIntervalTime
        isCompleted = data.isCompleted
        isImportant = data.isImportant
    }

    init(data: Data) {
        id = UUID()
        title = data.title
        category = data.category
        createDate = data.createDate
        missionType = data.missionType
        notes = data.content
        targetDoneTimes = data.targetDoneTimes
        doneTimes = data.doneTimes
        targetDoneIntervalTime = data.targetDoneIntervalTime
        doneIntervalTime = data.doneIntervalTime
        isCompleted = data.isCompleted
        isImportant = data.isImportant
    }
}

var missionExamples: [Mission] = [
    Mission(title: "背单词", category: MissionCategory(id: "default", name: "预设1", color: "FLAT FLESH", icon: "scribble"), createDate: Date(), missionType: MissionType.timing, content: [], targetDoneTimes: 0, doneTimes: 0, targetDoneIntervalTime: 100000, doneIntervalTime: 0, isCompleted: false, isImportant: false),
    Mission(title: "做试卷", category: MissionCategory(id: "fitness", name: "健身", color: "MELON MELODY", icon: "figure.run"), createDate: Date(), missionType: MissionType.timing, content: [], targetDoneTimes: 0, doneTimes: 0, targetDoneIntervalTime: 300000, doneIntervalTime: 0, isCompleted: false, isImportant: false),
    Mission(title: "喝水", category: MissionCategory(id: "water", name: "喝水", color: "AZRAQ BLUE", icon: "cup.and.saucer"), createDate: Date(), missionType: MissionType.metering, content: [], targetDoneTimes: 10, doneTimes: 0, targetDoneIntervalTime: 0, doneIntervalTime: 0, isCompleted: false, isImportant: false),
    Mission(title: "遛狗", category: MissionCategory(id: "life", name: "生活", color: "AZRAQ BLUE", icon: "house"), createDate: Date(), missionType: MissionType.metering, content: [], targetDoneTimes: 2, doneTimes: 0, targetDoneIntervalTime: 0, doneIntervalTime: 0, isCompleted: false, isImportant: false),
]

struct note: Identifiable, Codable {

    let id: UUID
    var content: String

    init(id: UUID = UUID(), content: String) {
        self.id = id
        self.content = content
    }
}

struct MissionCategory: Identifiable, Codable, Equatable {
    let id: String
    var name: String
    var color: String
    var icon: String

    init(id: String, name: String, color: String, icon: String) {
        self.id = id
        self.name = name
        self.color = color
        self.icon = icon
    }

    static var emptyMissionCategory: MissionCategory {
        MissionCategory(id: "default", name: "预设1", color: "FLAT FLESH", icon: "scribble")
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

enum MissionType: Codable, CaseIterable,Identifiable {

    case metering
    case timing

    var cn_name: String {
        switch self {
        case .metering:
            return "计次"
        case .timing:
            return "计时"
        }
    }
    var en_name: String {
        switch self {
        case .metering:
            return "metering"
        case .timing:
            return "timing"
        }
    }
    var systemImageName: String {
        switch self {
        case .metering:
            return "123.rectangle"
        case .timing:
            return "timer.circle"
        }
    }
    var id: String {
        return self.en_name
    }
}

var categoryExamples: [MissionCategory] = [
    MissionCategory(id: "default", name: "预设", color: "FLAT FLESH", icon: "scribble"),
    MissionCategory(id: "default1", name: "预设1", color: "FLAT FLESH", icon: "scribble")
]

struct customNotification: Identifiable, Codable {

    let id: UUID
    var title: String
    var content: String
    var type: NotificationType
    var createTime: Date

    init(id: UUID = UUID(), title: String, content: String, type: NotificationType, createTime: Date) {
        self.id = id
        self.title = title
        self.content = content
        self.type = type
        self.createTime = createTime
    }

    enum NotificationType: Codable, CaseIterable {
        case system
        case user
        case other

        var systemImage: String {
            switch self {
            case .system:
                return "gear.circle"
            case .user:
                return "person.circle"
            case .other:
                return ""
            }

        }

        var color: String{
            switch self {
            case .system:
                return "myGray"
            case .user:
                return "main"
            case .other:
                return ""
            }
        }

    }

}

var notificationExamples: [customNotification] = [
    customNotification(title: "恭喜你！", content: "你已经完成了两项任务", type: .user, createTime: string2date("2023-05-01 15:00:34")),
    customNotification(title: "新的贴纸已经添加完成！", content: "现在你可以快速启动项目", type: .system, createTime: string2date("2023-04-30 17:00:00")),
    customNotification(title: "已达成运动周目标！", content: "完成本周运动20小时", type: .system, createTime: string2date("2023-07-28 17:20:00")),
    customNotification(title: "已达成学习周目标！", content: "完成本周学习18小时", type: .system, createTime: string2date("2023-07-21 17:00:00"))
]
