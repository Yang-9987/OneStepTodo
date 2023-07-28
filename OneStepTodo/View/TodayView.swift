//
//  TodayView.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/26.
//

import Combine
import SwiftUI
import SymbolPicker

struct TodayView: View {
    
    @EnvironmentObject var appSettings: AppSettings
    // HeadLine数据
    @State private var dayRange = "今天"
    @State private var dateTime = "周六 7月22日"
    @State private var hasNotification = true
    // 进度条数据
    @State private var progress: Double = 0.65
    // 添加任务
    @State private var isPresentedAddView = false

    var missionList: [Mission] = missionExamples.sorted { m1, m2 in
        m1.createDate > m2.createDate
    }

    var body: some View {
        VStack {
            // HeadLine
            HomeHeadLineView(dayRange: $dayRange, dateTime: $dateTime, hasNotification: $hasNotification)
            // PersonalInfo
            PersonalInfoView()
            // Progress Bar
            ProgressBarView(progress: $progress)
            // MissionList
            ZStack {
                VStack {
                    HStack {
                        Text("今日计划")
                            .font(.system(size: 25, weight: .semibold, design: .default))
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }

                ScrollView(.vertical) {
                    ForEach(missionList, id: \.self.id) { item in
                        if item.missionType == .metering {
                            ListCellView(title: item.title, category: item.category, done: String(item.doneTimes), target: String(item.targetDoneTimes), content: item.notes)
                        } else if item.missionType == .timing {
                            ListCellView(title: item.title, category: item.category, done: String(item.doneIntervalTime), target: String(item.targetDoneIntervalTime), content: item.notes)
                        }

                    }
                    Spacer(minLength: 110)
                }
                .frame(maxHeight: .infinity)
                .padding(.top, 70)
                .overlay(alignment: .bottom, content: {
                    Button {
                        isPresentedAddView = true
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 126, height: 40)
                            .background(Color(red: 0.45, green: 0.73, blue: 0.96))
                            .cornerRadius(20)
                            .shadow(color: Color(red: 0.45, green: 0.73, blue: 0.96).opacity(0.2), radius: 2, x: 0, y: 4)
                            .overlay {
                                HStack {
                                    Image(systemName: "plus.circle")
                                    Text("添加任务")
                                }
                                .foregroundStyle(.white)
                            }
                    }
                    .padding(.bottom, 70)
                })
                .sheet(isPresented: $isPresentedAddView) {
                    NavigationStack {
                        AddMissionView()
                            .navigationTitle("添加任务")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentedAddView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        isPresentedAddView = false
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    TodayView()
        .environmentObject(AppSettings())
}

struct HomeHeadLineView: View {
    @Binding var dayRange: String
    @Binding var dateTime: String
    @Binding var hasNotification: Bool

    var body: some View {
        HStack(alignment: .center) {
            Capsule()
                .fill(Color("main"))
                .frame(width: 25, height: 15)
            Text("\(dayRange)")
                .font(.system(size: 15))
                .foregroundStyle(Color("main"))
            Text("\(dateTime)")
                .font(.system(size: 15))
            Spacer()
            ZStack {
                NavigationLink {
                    NotificationListView()
                        .navigationTitle("消息提醒")
                        .navigationBarTitleDisplayMode(.inline)
                        .transition(.slide)
                } label: {
                    Image(systemName: "bell")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .offset(y: -2)
                }

                if hasNotification {
                    Circle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                        .offset(x: 8, y: -8)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct PersonalInfoView: View {
    @EnvironmentObject var appSettings: AppSettings
    @AppStorage("Username") var username = "小曹"

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(greetingText())")
                    .font(.system(size: 40, weight: .bold, design: .default))
                Text("\(appSettings.userModel.name)")
                    .font(.system(size: 40, weight: .regular, design: .default))
                Spacer()
            }
            Text("你已完成今日计划的")
                .font(.system(size: 20, weight: .thin, design: .default))
                .offset(x: 5, y: 15)
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 10)
    }
}

struct ProgressBarView: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader(content: { geometry in
            let width = geometry.size.width
            HStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color("main"), lineWidth: 20)
                        .rotationEffect(.degrees(-90))
                        .frame(width: width / 3)
                    Image("bubu")
                        .scaleEffect(0.4)
                }
                .frame(width: width / 3)
                HStack(alignment: .bottom) {
                    Text("\(doubleToString(progress))")
                        .foregroundStyle(.myPink)
                        .font(.system(size: 80, weight: .bold, design: .default))
                    Text("%")
                        .padding(.trailing, 20)
                }
                .frame(width: width - width / 3)
            }
            .padding(.horizontal, 30)
        }).frame(height: 180)
    }
}

struct ListCellView: View {
    var title: String
    var category: MissionCategory
    var done: String
    var target: String
    var content: [note]

    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .cornerRadius(20)
                    .foregroundColor(Color(category.color))
                Image(systemName: category.icon)
                    .foregroundColor(.white)
            }
            .padding()
            VStack(alignment: .leading, content: {
                Text("\(title)")
                    .font(.system(size: 20, weight: .semibold, design: .default))
                Text("\(done)" + "/" + "\(target)")
                    .font(.system(size: 15, weight: .thin, design: .default))
            })
            Spacer()
            NavigationLink {
                ForEach(content) { note in
                    Text("\(note.content)")
                }
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                        .overlay {
                            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.8), Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        }
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
        .background {
            Rectangle()
                .frame(height: 80)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 5, x: 10, y: 10)
                .opacity(0.2)
        }
        .padding(.horizontal, 5)
    }
}

struct AddMissionView: View {
    @State private var mission = Mission.emptyMission
    @State private var newNote = ""
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    @State private var selectedType: MissionType = .metering

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                CustomTextField(text: $mission.title, placeholder: "任务名称:", iconName: "newspaper", type: .edit) {
                    AnyView(EmptyView())
                }
            }
            .padding()
            HStack {
                CustomTextField(text: Binding(get: { date2string(mission.createDate) }, set: { mission.createDate = dateFormatter.date(from: $0) ?? Date() }), placeholder: "创建时间:", iconName: "timer", type: .show) {
                    AnyView(EmptyView())
                }
            }
            .padding()
            HStack {
                CustomTextField(placeholder: "选择标签:", iconName: "tag", type: .picker) {
                    AnyView(
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(mission.category.color))
                                Image(systemName: mission.category.icon)
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text(mission.category.name)
                            }
                            Spacer()
                            NavigationLink(destination: CategoryList(selectedCategory: $mission.category), label: {
                                HStack{
                                    Text("请选择标签")
                                    Image(systemName: "arrowtriangle.right.fill")
                                }
                                .foregroundColor(.blue)
                            })
                        }
                    )
                }
            }
            .padding()
            HStack {
                ForEach(MissionType.allCases) { item in
                    Button(action: {
                        withAnimation {
                            selectedType = item // Add animation to the selectedTab change
                        }
                    }) {
                        VStack {
                            Image(systemName: item.systemImageName)
                                .imageScale(.large)
                            Text(item.cn_name)
                                .font(.footnote)
                        }
                        .foregroundColor(item == selectedType ? .blue : .gray)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                    }
                    .background(Color.white.opacity(0.001)) // Make the button clickable for the entire VStack area
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            TabView(selection: $selectedType) {
                HStack {
                    CustomTextField(text: Binding(get: { String(mission.targetDoneTimes) }, set: { mission.targetDoneTimes = Int($0) ?? 0 }), placeholder: "请输入目标次数:", iconName: "123.rectangle", type: .edit) {
                        AnyView(EmptyView())
                    }
                }
                .padding()
                .tag(MissionType.metering)
                HStack {
                    CustomTextField(text: Binding(get: { String(mission.targetDoneIntervalTime) }, set: { mission.targetDoneTimes = Int($0) ?? 0 }), placeholder: "请输入目标时间:", iconName: "timer.circle", type: .edit) {
                        AnyView(EmptyView())
                    }
                }
                .padding()
                .tag(MissionType.timing)
            }
            .frame(height: 100, alignment: .center)
            .tabViewStyle(.page(indexDisplayMode: .never))
            HStack{
                CustomTextField(boolData: $mission.isImportant, placeholder: "星标时间", iconName: "star", type: .button) {
                    AnyView(EmptyView())
                }
            }
            .padding()
            HStack {
                CustomTextField(placeholder: "添加备注:", iconName: "note.text", type: .picker) {
                    AnyView(
                        VStack{
                            HStack {
                                TextField("New note", text: $newNote)
                                Button(action: {
                                    withAnimation {
                                        let note = note(content: newNote)
                                        mission.notes.append(note)
                                        newNote = ""
                                    }
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                }
                                .disabled(newNote.isEmpty)
                            }
                            List{
                                ForEach(mission.notes) { item in
                                    HStack{
                                        Text(item.content)
                                        Spacer()
                                    }
                                    .padding()
                                }
                                .onDelete { index in
                                    mission.notes.remove(atOffsets: index)
                                }
                            }
                            .listStyle(.plain)

                        }
                    )
                }
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}

struct CategoryList: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isPresented: Bool = false
    @Binding var selectedCategory: MissionCategory

    var body: some View {
        ZStack {
            VStack {
                CategoriesList(selectedCategory: $selectedCategory)
                Spacer()
            }
            VStack {
                Spacer()
                Button {
                    isPresented = true
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Text("添加新标签")
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                AddNewCategoryView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("标签")
                    .font(.headline)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    print("Add new category")
                    dismiss()
                }) {
                    Text("完成")
                }
            }
        })
    }
}

//
struct CategoriesList: View {
    @Binding var selectedCategory: MissionCategory
    var cateList: [MissionCategory] = categoryExamples
    var body: some View {
        if cateList.isEmpty {
            Spacer()
            Text("No Categories Found")
                .font(.headline)
        } else {
            ForEach(cateList) { category in
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(category.color))
                        Image(systemName: category.icon)
                            .foregroundColor(.white)
                    }
                    HStack {
                        Text(category.name)
                        Color.white
                    }
                    Image(systemName: selectedCategory == category ? "checkmark.circle" : "circle")
                        .foregroundColor(Color(category.color))
                }
                .frame(height: 50)
                .padding(.horizontal, 15)
                .onTapGesture {
                    selectedCategory = category
                }
                Divider()
            }
        }
    }
}

struct AddNewCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var selectedColor: String = "FLAT FLESH"
    @State private var selectedSymbol: String = "folder.badge.plus"
    @State private var selectedTab = 0

    var cateList: [MissionCategory] = categoryExamples

    private var isFormValid: Bool {
        !name.isEmptyOrWhitespace
    }

    struct TabItem {
        var title: String
        var systemImageName: String
    }

    let tabItems = [
        TabItem(title: "Color", systemImageName: "paintbrush"),
        TabItem(title: "Symbol", systemImageName: "tray")
    ]

    var body: some View {
        VStack {
            VStack {
                Image(systemName: selectedSymbol)
                    .foregroundColor(Color(selectedColor))
                    .font(.system(size: 50))
                    .padding(.bottom, 30)
                TextField("Category Name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .frame(height: 200)
            .padding(.horizontal, 30)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))

            // Custom tab bar at the top
            HStack {
                ForEach(0 ..< 2) { index in
                    Spacer()
                    Button(action: {
                        withAnimation {
                            selectedTab = index // Add animation to the selectedTab change
                        }
                    }) {
                        VStack {
                            Image(systemName: tabItems[index].systemImageName)
                                .imageScale(.large)
                            Text(tabItems[index].title)
                                .font(.footnote)
                        }
                        .foregroundColor(index == selectedTab ? .blue : .gray)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                    }
                    .background(Color.white.opacity(0.001)) // Make the button clickable for the entire VStack area
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)

            TabView(selection: $selectedTab) {
                ColorPickerView(selectedColor: $selectedColor)
                    .padding(.horizontal, 20)
                    .tag(0)

                SymbolPickerView(selectedSymbolStr: $selectedSymbol)
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New Category")
                    .font(.headline)
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

struct ColorPickerView: View {
    @Binding var selectedColor: String

    let colorList: [String] = ColorListVal

    let columns = [
        GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10),
        GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10),
        GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10),
        GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10),
        GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(colorList, id: \.self) { color in
                    ZStack {
                        Circle().fill()
                            .foregroundColor(Color(color))
                            .padding(5)
                        Circle()
                            .strokeBorder(Color(selectedColor == color ? .gray : .clear), lineWidth: 4)
                            .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    }.onTapGesture {
                        selectedColor = color
                    }
                }
            }
            .padding(20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
}

struct SymbolPickerView: View {
    @Binding var selectedSymbolStr: String
    @State var selectedSymbol: Symbol?

    @State var displaySymbolPicker: Bool = false

    var body: some View {
        VStack {
            VStack {
                Image(systemName: selectedSymbol?.value ?? "")
                    .font(.largeTitle)
            }
            .padding(8)
            Button {
                displaySymbolPicker = true
            } label: {
                Text("Select standard symbols")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .sheet(isPresented: $displaySymbolPicker) {
            NavigationView {
                SymbolCategoryPickerView(
                    selectedSymbol: $selectedSymbol,
                    selectedColor: .blue,
                    categories: FullCategoriesSymbolProvider().categories
                )
                .navigationTitle("Categories")
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Symbols")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onDisappear {
                if let symbol = selectedSymbol {
                    selectedSymbolStr = symbol.value
                }
            }
        }
    }
}
