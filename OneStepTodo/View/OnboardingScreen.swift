//
//  ContentView.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/25.
//

import SwiftUI

struct OnboardingScreen: View {

    @AppStorage("IsFirstLaunch") var isFirstLaunch = 0

    @State private var showText1 = false
    @State private var showText2 = false
    @State private var showText3 = false
    @State private var showBubu = false
    @State private var showPubble = false

    @State var endAnimation: Bool = false

    @State var opacity1: Double = 0
    @State var opacity2: Double = 0
    @State var opacity3: Double = 0
    @State var opacity4: Double = 0
    @State var opacity5: Double = 0
    @State var time: Double = 100

    var body: some View {
        ZStack {
            // For Home Screen and Welcome Screen
            if isFirstLaunch == 0 {
                WelcomePageView()
                    .transition(.opacity)
            }
            if isFirstLaunch == 1 {
                HomeView()
                    .transition(.opacity)
            }

            ZStack {
                Color(.white)
                // For Launch Screen
                VStack(alignment: .leading, spacing: 10) {
                    // Slogan
                    HStack {
                        VStack(alignment: .leading, spacing: 10, content: {
                            if showText1 {
                                Text("记录就")
                                    .opacity(opacity1)
                                    .transition(.slide)
                            }
                            if showText2 {
                                Text("一步")
                                    .opacity(opacity2)
                                    .transition(.slide)
                                    .foregroundStyle(Color("main"))
                            }
                            if showText3 {
                                Text("生活快一步")
                                    .opacity(opacity3)
                                    .transition(.slide)
                            }
                        })
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                for number in 1...100 {
                                    Timer.scheduledTimer(withTimeInterval: 0.01 * Double(number), repeats: false, block: { _ in
                                        self.opacity1 += 0.01
                                    })
                                }
                                withAnimation(.spring()) {
                                    showText1.toggle()
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                for number in 1...100 {
                                    Timer.scheduledTimer(withTimeInterval: 0.01 * Double(number), repeats: false, block: { _ in
                                        self.opacity2 += 0.01
                                    })
                                }
                                withAnimation(.spring()) {
                                    showText2.toggle()
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                for number in 1...100 {
                                    Timer.scheduledTimer(withTimeInterval: 0.01 * Double(number), repeats: false, block: { _ in
                                        self.opacity3 += 0.01
                                    })
                                }
                                withAnimation(.spring()) {
                                    showText3.toggle()
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                for number in 1...100 {
                                    Timer.scheduledTimer(withTimeInterval: 0.01 * Double(number), repeats: false, block: { _ in
                                        self.opacity4 += 0.01
                                    })
                                }
                                withAnimation(.spring()) {
                                    showBubu.toggle()
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                                for number in 1...100 {
                                    Timer.scheduledTimer(withTimeInterval: 0.01 * Double(number), repeats: false, block: { _ in
                                        self.opacity5 += 0.01
                                    })
                                }
                                withAnimation(.spring()) {
                                    showPubble.toggle()
                                }
                            }
                        }
                        .font(.system(size: 66, weight: .semibold, design: .default))
                        Spacer()
                    }
                    .padding(.top, 50)
                    .padding(.leading, 20)

                    VStack{
                        if showBubu {
                            Image("bubu")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 250)
                                .offset(x: 60, y: 80)
                                .padding(.bottom, 20)
                                .opacity(opacity4)
                                .transition(.move(edge: .trailing))
                        }

                        if showPubble {
                            Image("pubble")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(0.8)
                                .opacity(opacity5)
                                .offset(x: -20, y: -40)
                                .transition(.move(edge: .top).animation(.easeInOut))
                        }
                    }
                    Spacer()
                }
                .padding(.top, 40)

                GeometryReader { geometry in
                    LottieView(name: "dynamicLine", loopMode: .playOnce, animationSpeed: 1)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .alignmentGuide(HorizontalAlignment.center) { d in
                            // Align the LottieView to the center of its parent view
                            d[HorizontalAlignment.center]
                        }
                        .alignmentGuide(VerticalAlignment.center) { d in
                            // Align the LottieView to the center of its parent view
                            d[VerticalAlignment.center]
                        }
                        .scaleEffect(0.4)
                        .offset(y: -150)
                }
            }
            .ignoresSafeArea()
            .onAppear(perform: animationSplash)
            .opacity(endAnimation ? 0 : 1)
        }
    }

    func animationSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(.easeOut(duration: 0.50)) {
                endAnimation.toggle()
            }
        }

    }
}

#Preview {
    OnboardingScreen()
        .environmentObject(AppSettings())
}
