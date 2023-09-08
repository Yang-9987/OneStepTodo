//
//  WelcomePageView.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/25.
//

import SwiftUI

struct WelcomePageView: View {
    // 获取环境变量
    @AppStorage("IsFirstLaunch") var isFirstLaunch = 0
    // 当前页码
    @State private var currentPage = 0
    private let pages: [WelcomePage] = WelcomePage.samplePages
    // 初始化个人信息
    @State private var name: String = ""
    @State private var birthday: Date = .init()
    @State private var avatar: String = "🥰"
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        VStack {
            if pages[currentPage].type == .introduce {
                TabView(selection: $currentPage) {
                    ForEach(0..<3) { index in
                        SingleWelcomPageView(page: pages[index])
                            .tag(pages[index].tag)
                    }
                }
                .animation(.spring(), value: currentPage)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                // 指示器
                HStack(alignment: .center) {
                    ForEach(0..<3) { index in
                        Capsule()
                            .fill(currentPage == index ? Color("main") : Color.gray)
                            .frame(width: currentPage == index ? 20 : 8, height: 8)
                            .padding(1)
                            .onTapGesture {
                                if currentPage <= 2 {
                                    currentPage = index
                                }
                            }
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                .padding(.vertical, 50)
            } else if pages[currentPage].type == .setting {
                if appSettings.userModel.name == "" {
                    Spacer()
                    VStack {
                        HStack{
                            Text("昵称")
                                .font(.headline)
                            TextField("昵称", text: $name)
                                .textFieldStyle(.roundedBorder)

                        }
                        .padding()
                        HStack{
                            Text("生日")
                                .font(.headline)
                            Spacer()
                            DatePicker("", selection: $birthday, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .labelsHidden()

                        }
                        .padding()
                        HStack{
                            Text("Emoji:")
                                .font(.headline)
                            EmojiPicker(selectedEmojiStr: $avatar)
                        }
                        .padding()


                    }
                } else {
                    Spacer()
                    VStack(alignment: .center) {
                        Text("欢迎回来!")
                        Text("\(appSettings.userModel.name)")
                    }
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 50)
                }
                Spacer()
            }

            // 按钮
            Button {
                if pages[currentPage].type == .setting {
                    isFirstLaunch = 1
                    if appSettings.userModel.name == "" {
                        appSettings.updateUserModel(name: name, birthday: birthday, avatar: "😇")
                    }
                } else {
                    currentPage += 1
                }
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color("main"))
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 60, alignment: .center)
                    Text("\(pages[currentPage].buttonName)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 10)
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

#Preview {
    WelcomePageView()
        .environmentObject(AppSettings())
}

struct SingleWelcomPageView: View {

    var page: WelcomePage

    var body: some View {
        VStack(spacing: 20) {
//            Text("\(page.name)")
            Image("\(page.imageName)")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 20)
                .cornerRadius(10)
            VStack(alignment: .leading){
                ForEach(page.description, id: \.self){ item in
                    HStack{
                        Text("\(item)")
                            .font(Font.custom("PingFang SC", size: 30))
                            .kerning(0.6)
                        Spacer()
                    }
                }
            }
            .padding(.leading, 50)
        }
    }
}
