//
//  SettingsView.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/26.
//

import SwiftUI

struct SettingsView: View {

    // 判断是否是第一次启动
    @AppStorage("IsFirstLaunch") var isFirstLaunch = 0
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        VStack{
            HStack{
                ZStack{
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text(appSettings.userModel.avatar)
                        .font(.system(size: 60))
                }
                Text(appSettings.userModel.name)
            }
            HStack{
                Button {
                    withAnimation(.easeInOut) {
                        isFirstLaunch = 0
                        appSettings.updateUserModel(name: "", birthday: Date(), avatar: "🥰")
                    }
                } label: {
                    Text("Init")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
}
