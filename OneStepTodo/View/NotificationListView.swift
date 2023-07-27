//
//  NotificationListView.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/26.
//

import SwiftUI

struct NotificationListView: View {

    var notificationList: [customNotification] = notificationExamples.sorted { c1, c2 in
        c1.createTime > c2.createTime
    }

    var body: some View {
        ScrollView(.vertical) {
            ForEach(notificationList){ item in
                VStack{
                    HStack{
                        Text(date2string(item.createTime))
                        Spacer()
                    }
                    .padding()
                    HStack{
                        ZStack{
                            Circle()
                                .frame(width: 60, height: 60)
                                .cornerRadius(20)
                                .foregroundColor(Color(item.type.color))
                            Image(systemName: item.type.systemImage)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        VStack(alignment: .leading, content: {
                            Text(item.title)
                                .font(.system(size: 20, weight: .semibold, design: .default))
                            Text(item.content)
                                .font(.system(size: 15, weight: .thin, design: .default))
                        })
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    NotificationListView()
}
