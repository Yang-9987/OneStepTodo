//
//  EmojiPickerView.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/26.
//

import SwiftUI
import EmojiPicker

struct EmojiPicker: View {

    @Binding var selectedEmojiStr: String

    @State var selectedEmoji: Emoji?
    @State var displayEmojiPicker: Bool = false

    var body: some View {
        HStack {
            HStack {
                Spacer()
                Text(selectedEmoji?.value ?? selectedEmojiStr)
                    .font(.headline)
                Spacer()
            }
            .padding(8)
            Button {
                displayEmojiPicker = true
            } label: {
                Text("选择Emoji表情")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .center)
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $displayEmojiPicker) {
            NavigationView {
                EmojiPickerView(selectedEmoji: $selectedEmoji, selectedColor: .orange)
                    .navigationTitle("Emojis")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .onDisappear {
                if let emoji = selectedEmoji {
                    selectedEmojiStr = emoji.value
                }
            }
        }
    }
}
