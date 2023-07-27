//
//  LottieView.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/25.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {

    let name: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat

    init(name: String, loopMode: LottieLoopMode, animationSpeed: CGFloat = 1) {
        self.name = name
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        return animationView
    }

    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {

    }

}
