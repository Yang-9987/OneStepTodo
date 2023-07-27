//
//  StringUtils.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/26.
//

import Foundation
import SwiftUI

extension String {
  var isEmptyOrWhitespace: Bool {
    return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}

func greetingText() -> String{
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)

    var greeting: String = ""

    if hour >= 5 && hour < 12 {
        greeting = "早上好"
    } else if hour >= 12 && hour < 14 {
        greeting = "中午好"
    } else if hour >= 14 && hour < 18 {
        greeting = "下午好"
    } else if hour >= 18 && hour < 23 {
        greeting = "晚上好"
    } else {
        greeting = "夜深了"
    }

    return greeting
}

func doubleToString(_ number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    let string = formatter.string(from: NSNumber(value: number)) ?? ""
    return string.replacing("%", with: "")
}

let ColorListVal: [String] = ["FLAT FLESH", "MELON MELODY", "LIVID", "SPRAY", "PARADISE GREEN", "SQUASH BLOSSOM", "MANDARIN RED", "AZRAQ BLUE", "DUPAIN", "AURORA GREEN", "ICELAND POPPY", "TOMATO RED", "SECRET BLUE", "GOOD SAMARITIAN", "WATER", "CARROT ORANGE", "JALAPENO RED", "DARK BLUE", "FOREST BLUE", "REEF ENCOUNTER"]

enum TextFieldType {
    case edit
    case show
    case picker
    case button
}

struct CustomTextField: View {
    @Binding var text: String // 绑定输入框的文本值
    @Binding var boolData: Bool // 绑定输入框的文本值
    var placeholder: String // 输入框的占位符文本
    var iconName: String // 图标的名字
    var type: TextFieldType

    var content: () -> AnyView

    init(text: Binding<String> = .constant(""), boolData: Binding<Bool> = .constant(false), placeholder: String, iconName: String, type: TextFieldType, @ViewBuilder content: @escaping () -> AnyView) {
        _text = text
        _boolData = boolData
        self.placeholder = placeholder
        self.iconName = iconName
        self.type = type
        self.content = content
    }

    var body: some View {
        VStack{
            HStack{
                Image(systemName: iconName)
                Text(placeholder)
                Spacer()
            }
            .foregroundColor(.black)
            if type == .edit{
                TextField(placeholder, text: $text)
                    .foregroundColor(.black)
            } else if type == .show {
                TextField(placeholder, text: $text)
                    .disabled(true)
                    .foregroundColor(.gray)
            } else if type == .picker {
                content()
            } else if type == .button {
                HStack{
                    Text(boolData ? "标记为重要事件" : "不做标记")
                        .foregroundStyle(boolData ? Color.yellow : Color.gray)
                    Spacer()
                    Toggle("", isOn: $boolData)
                        .labelsHidden()
                
                }
            }
        }
    }
}

func date2string(_ dateData: Date) -> String {
    let date = dateData
    let dateformatter = DateFormatter()

//    dateformatter.dateStyle = .full
    dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    let dateStr = dateformatter.string(from: date)

    return dateStr
}

func string2date(_ dateStr: String) -> Date {
    var newDate: Date?
    let dateformatter = DateFormatter()

    dateformatter.dateFormat = "YYYY-MM-dd : HH:mm:ss"
    newDate = dateformatter.date(from: dateStr)

    return newDate!
}

