//
//  MeteringMission.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/29.
//

import Foundation
import AppIntents
import SwiftUI

struct ShowMeteringMission: AppIntent {

    static var title: LocalizedStringResource = "Show Metering Mission"

    @Parameter(title: "Title")
    var selectedMission: ShowMeteringMissionTestEnum

    @MainActor
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        .result(view: MeteringMissionShortcutView(missionTitle: selectedMission.rawValue))
    }


}

enum ShowMeteringMissionTestEnum: String, CaseIterable, AppEnum {

    case test1
    case test2
    case test3

    public static var typeDisplayRepresentation: TypeDisplayRepresentation = "selectedMission"

    public static var caseDisplayRepresentations: [ShowMeteringMissionTestEnum : DisplayRepresentation] = [
        .test1: "MeteringMission 1",
        .test2: "MeteringMission 2",
        .test3: "MeteringMission 3"
    ]

    var asMeteringMission: selectedMission {
        switch self {
        case .test1: return .test1
        case .test2: return .test2
        case .test3: return .test3
        }
    }

}

public enum selectedMission: String, Hashable, CaseIterable, Sendable {
    case test1
    case test2
    case test3
}

struct MeteringMissionShortcutView: View {

    let missionTitle: String

    var body: some View {
        VStack{
            Text("任务：\(missionTitle) 完成一次")
            Text("时间：\(date2string(Date()))")
        }
    }
}

