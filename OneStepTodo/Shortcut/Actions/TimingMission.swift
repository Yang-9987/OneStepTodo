//
//  TimingMission.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/29.
//

import Foundation
import SwiftUI
import AppIntents

struct ShowTimiingMission: AppIntent {

    static var title: LocalizedStringResource = "Show Timing Mission"

    @Parameter(title: "Title")
    var selectedMission: ShowTimingMissionTestEnum

    @MainActor
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        .result(view: TimingMissionShortcutView(missionTitle: selectedMission.rawValue))
    }


}

enum ShowTimingMissionTestEnum: String, CaseIterable, AppEnum {

    case test1
    case test2
    case test3

    public static var typeDisplayRepresentation: TypeDisplayRepresentation = "selectedMission"

    public static var caseDisplayRepresentations: [ShowTimingMissionTestEnum : DisplayRepresentation] = [
        .test1: "TimingMission 1",
        .test2: "TimingMission 2",
        .test3: "TimingMission 3"
    ]

    var asMeteringMission: selectedMission {
        switch self {
        case .test1: return .test1
        case .test2: return .test2
        case .test3: return .test3
        }
    }

}

struct TimingMissionShortcutView: View {

    let missionTitle: String

    var body: some View {
        VStack{
            Text("任务：\(missionTitle) 开始计时/结束计时")
            Text("时间：\(date2string(Date()))")
        }
    }
}
