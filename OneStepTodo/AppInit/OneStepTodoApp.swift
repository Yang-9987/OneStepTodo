//
//  OneStepTodoApp.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/25.
//

import SwiftUI

@main
struct OneStepTodoApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            OnboardingScreen()
                .environmentObject(appSettings)
                .preferredColorScheme(.light)
        }
    }
}
