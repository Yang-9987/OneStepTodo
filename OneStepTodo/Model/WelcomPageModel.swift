//
//  WelcomPageModel.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/25.
//

import Foundation

struct WelcomePage: Identifiable {

    let id = UUID()

    var buttonName: String
    var description: [String]
    var imageName: String
    var tag: Int
    var type: WelcomePageType

    static var samplePages: [WelcomePage] = [
        WelcomePage(buttonName: "下一页", description: ["学习运动快速计时","快人一步进入自律状态"], imageName: "intro-1", tag: 0, type: .introduce),
        WelcomePage(buttonName: "下一页", description: ["吃药喂奶及时提醒记录","做个人生活的小秘书"], imageName: "intro-2", tag: 1, type: .introduce),
        WelcomePage(buttonName: "初始化个人信息", description: ["NFC贴纸联动","引领打卡新体验"], imageName: "intro-3", tag: 2, type: .introduce),
        WelcomePage(buttonName: "进入OneStep", description: [], imageName: "", tag: 3, type: .setting)
    ]
}

public enum WelcomePageType {
    case introduce
    case setting
}

struct UserModel: Codable {

    var name: String
    var birthday: Date
    var avatar: String
    
}

