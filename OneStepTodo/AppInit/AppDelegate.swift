//
//  AppDelegate.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/25.
//

import Foundation
import SwiftUI
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    @AppStorage("IsFirstLaunch") var isFirstLaunch = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        // Your code here
//        Thread.sleep(forTimeInterval: 2.0) // 添加这行代码 启动画面延长2秒
        return true
    }
}

class AppSettings: ObservableObject {
    @AppStorage("UserModel") var userModelData: Data?
    var userModel: UserModel {
        get {
            guard let data = userModelData,
                  let userModel = try? JSONDecoder().decode(UserModel.self, from: data)
            else {
                return UserModel(name: "", birthday: Date(), avatar: "")
            }
            return userModel
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userModelData = data
        }
    }

    func updateUserModel(name:String, birthday: Date, avatar: String){
        self.userModel = UserModel(name: name, birthday: birthday, avatar: avatar)
    }
}
