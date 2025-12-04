//
//  ReportView.swift
//  ALP_MobComp
//
//  Created by student on 27/11/25.
//

import SwiftUI
import Charts // Pastikan import ini ada jika menggunakan iOS 16+

struct ReportView: View {
    let themeGreen = Color(red: 0.15, green: 0.45, blue: 0.25)
    let lightGreen = Color(red: 0.4, green: 0.7, blue: 0.4)
    let bgGray = Color(uiColor: .systemGroupedBackground)
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                bgGray.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            // MARK: - SECTION 1: HEADER & FILTER CARD
                            ZStack(alignment: .top) {
                                ReportHeaderView(themeGreen: themeGreen)
                                
                                ReportCardView(themeGreen: themeGreen)
                                    .padding(.top, 140)
                                    .padding(.horizontal, 20)
                            }
                            .zIndex(1)
                            
                            // MARK: - SECTION 2: DASHBOARD CONTENT (Updated)
                            // Ini kode baru untuk menampilkan Summary, Grafik, dll sesuai screenshot
                            VStack(spacing: 20) {
                                
                                // 1. Summary Cards (Income, Paid, Pending)
                                SummaryStatsView()
                                
                                // 2. Income Trend (Wave Chart)
                                IncomeTrendView(themeGreen: themeGreen)
                                
                                // 3. Income by Platform (Donut Chart)
                                PlatformDonutView(themeGreen: themeGreen)
                                
                                // 4. Transactions List
                                transactionListView(themeGreen: themeGreen)
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 100) // Spacer bawah agar tidak tertutup TabBar
                        }
                    }
                    .ignoresSafeArea(edges: .top)
                }
            }
        }
    }
}

// MARK: - 1. HEADER VIEW
struct ReportHeaderView: View {
    var themeGreen: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Spacer().frame(height: 60)
            
            HStack {
                Text("Financial Report")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .frame(width: 25, height: 30)
                        .foregroundColor(.white)
                }
            }
            
            Spacer().frame(height: 100)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
        .background(themeGreen)
        .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight]))
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - 2. REPORT CARD VIEW (FILTER)
struct ReportCardView: View {
    var themeGreen: Color
    
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var selectedFilter: String = "This Month" // State untuk filter tombol
    
    let filters = ["This Month", "Last Month", "This Year"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Report Criteria")
                .font(.title3)
                .fontWeight(.bold)
            
            CustomDatePickerView(startDate: $startDate, endDate: $endDate)
            
            // Filter Buttons (Horizontal Scroll) sesuai screenshot
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(filters, id: \.self) { filter in
                        Button(action: {
                            selectedFilter = filter
                        }) {
                            Text(filter)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedFilter == filter ? themeGreen.opacity(0.1) : Color.clear)
                                .foregroundColor(selectedFilter == filter ? themeGreen : .gray)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(selectedFilter == filter ? themeGreen : Color.gray.opacity(0.3), lineWidth: 1)
                                )
                                .cornerRadius(20)
                        }
                    }
                }
            }
            
            // Dropdowns (Platform & Status)
            HStack(spacing: 12) {
                dropdownButton(title: "Platform: All")
                dropdownButton(title: "Status: All")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
    
    // Helper View untuk Dropdown kecil
    func dropdownButton(title: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.down")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }
}

// MARK: - 3. DATE PICKER VIEW
struct CustomDatePickerView: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    
    @State private var showCalendar = false
    @State private var sheetHeight: CGFloat = 450
    
    let themeColor = Color(red: 0.15, green: 0.45, blue: 0.25)

    var body: some View {
        VStack {
            Button(action: { showCalendar = true }) {
                HStack {
                    if let start = startDate {
                        if let end = endDate {
                            Text("\(formatDate(start)) - \(formatDate(end))")
                        } else {
                            Text("\(formatDate(start)) - End Date")
                        }
                    } else {
                        Text("Choose Date")
                    }
                    Spacer()
                    Image(systemName: "calendar")
                }
                .foregroundColor(.black)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
            }
        }
        .sheet(isPresented: $showCalendar) {
            VStack(spacing: 0) {
                CustomCalendarGrid(startDate: $startDate, endDate: $endDate, themeColor: themeColor)
                    .padding(.horizontal)
                    .padding(.top,40)
                
                Button(action: {
                    showCalendar = false
                }) {
                    Text("Save")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(themeColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .disabled(startDate == nil || endDate == nil)
                .opacity((startDate == nil || endDate == nil) ? 0.5 : 1)
            }
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SheetHeightKey.self, value: proxy.size.height)
                }
            }
            .onPreferenceChange(SheetHeightKey.self) { newHeight in
                if newHeight > 0 {
                    DispatchQueue.main.async {
                        sheetHeight = newHeight
                    }
                }
            }
            .presentationDetents([.height(sheetHeight)])
            .presentationDragIndicator(.visible)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}

// MARK: - 4. NEW DASHBOARD COMPONENTS (Sesuai Screenshot)

// A. SUMMARY STATS (3 Kotak Kecil)
struct SummaryStatsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Summary")
                .font(.headline)
                .padding(.bottom, 5)
            
            summaryCard(title: "Total Income", amount: "Rp 25.500.000")
            summaryCard(title: "Total Paid", amount: "Rp 20.000.000")
            summaryCard(title: "Pending", amount: "Rp 5.500.000")
        }
    }
    
    func summaryCard(title: String, amount: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(amount)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1)))
    }
}

// B. INCOME TREND CHART (Grafik Gelombang Hijau)
struct IncomeTrendView: View {
    var themeGreen: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Income Trend Over Time")
                .font(.headline)
                .padding(.bottom, 10)
            
            ZStack(alignment: .bottom) {
                // Background Gelombang Hijau
                WaveShape()
                    .fill(
                        LinearGradient(colors: [themeGreen.opacity(0.6), themeGreen.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(height: 120)
                
                // Garis Gelombang
                WaveShape()
                    .stroke(themeGreen, lineWidth: 2)
                    .frame(height: 120)
                
                // Label Axis X Manual (Dummy)
                HStack {
                    Text("W1 Jan").font(.caption2).foregroundColor(.gray)
                    Spacer()
                    Text("W3 Jan").font(.caption2).foregroundColor(.gray)
                    Spacer()
                    Text("W1 Feb").font(.caption2).foregroundColor(.gray)
                    Spacer()
                    Text("W3 Feb").font(.caption2).foregroundColor(.gray)
                    Spacer()
                    Text("W1 Mar").font(.caption2).foregroundColor(.gray)
                }
                .padding(.top, 130) // Dorong label ke bawah grafik
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
        }
    }
}

// Shape Custom untuk membuat efek gelombang
struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height * 0.7))
        
        // Buat kurva gelombang manual
        path.addCurve(to: CGPoint(x: rect.width * 0.4, y: rect.height * 0.4),
                      control1: CGPoint(x: rect.width * 0.1, y: rect.height * 0.5),
                      control2: CGPoint(x: rect.width * 0.3, y: rect.height * 0.3))
        
        path.addCurve(to: CGPoint(x: rect.width * 0.7, y: rect.height * 0.6),
                      control1: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5),
                      control2: CGPoint(x: rect.width * 0.6, y: rect.height * 0.7))
        
        path.addCurve(to: CGPoint(x: rect.width, y: rect.height * 0.3),
                      control1: CGPoint(x: rect.width * 0.8, y: rect.height * 0.5),
                      control2: CGPoint(x: rect.width * 0.9, y: rect.height * 0.4))
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

// C. PLATFORM DONUT CHART
struct PlatformDonutView: View {
    var themeGreen: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Income by Platform")
                .font(.headline)
            
            HStack(spacing: 20) {
                // Donut Chart Sederhana
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    Circle()
                        .trim(from: 0.0, to: 0.6) // 60%
                        .stroke(themeGreen, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Circle()
                        .trim(from: 0.62, to: 0.85) // 23%
                        .stroke(themeGreen.opacity(0.6), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Circle()
                        .trim(from: 0.87, to: 0.98) // 11%
                        .stroke(themeGreen.opacity(0.3), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                }
                .frame(width: 100, height: 100)
                .padding()
                
                // Legend
                VStack(alignment: .leading, spacing: 10) {
                    legendItem(color: themeGreen, label: "Manual (60%)", value: "Rp 25.500.000")
                    legendItem(color: themeGreen.opacity(0.6), label: "Upwork (23%)", value: "Rp 1.000.000")
                    legendItem(color: themeGreen.opacity(0.3), label: "Fiverr (17%)", value: "Rp 500.000")
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
        }
    }
    
    func legendItem(color: Color, label: String, value: String) -> some View {
        HStack {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(label).font(.caption).foregroundColor(.gray)
            Text(value).font(.caption).fontWeight(.bold)
        }
    }
}

// D. TRANSACTION LIST
struct transactionListView: View {
    var themeGreen: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Transactions")
                .font(.headline)
                .padding(.bottom, 5)
            
            VStack(spacing: 0) {
                transactionRow(title: "Website Redesign", subtitle: "Stark Ind • 10 Feb", amount: "Rp 5.000.000", color: themeGreen)
                Divider()
                transactionRow(title: "Logo Design", subtitle: "Stark Ind • 10 Feb", amount: "Rp 2.000.000", color: Color(red: 0.6, green: 0.6, blue: 0.4)) // Kuning/Gold
            }
            .background(Color.white)
            .cornerRadius(16)
        }
    }
    
    func transactionRow(title: String, subtitle: String, amount: String, color: Color) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(amount)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .padding()
    }
}

// MARK: - 5. HELPERS & CALENDAR (UNCHANGED LOGIC)

struct SheetHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 400
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct roundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// --- LOGIKA KALENDER (Tanpa Batasan Masa Lalu) ---
struct CustomCalendarGrid: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    let themeColor: Color
    
    @State private var currentMonthOffset = 0
    let calendar = Calendar.current
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { currentMonthOffset -= 1 }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
                Text(monthTitle(offset: currentMonthOffset))
                    .font(.headline)
                Spacer()
                Button(action: { currentMonthOffset += 1 }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom)
            
            HStack {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day).font(.caption).foregroundColor(.gray).frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(daysInMonth(offset: currentMonthOffset), id: \.self) { date in
                    if let date = date {
                        DayCell(date: date)
                    } else {
                        Text("").frame(height: 30)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func DayCell(date: Date) -> some View {
        let isSelected = isDateSelected(date)
        let inRange = isDateInRange(date)
        
        Text("\(calendar.component(.day, from: date))")
            .font(.system(size: 14, weight: .medium))
            .frame(width: 35, height: 35)
            .background(
                ZStack {
                    if inRange { Circle().fill(themeColor.opacity(0.2)) }
                    if isSelected { Circle().fill(themeColor) }
                }
            )
            .foregroundColor(isSelected ? .white : .black)
            .onTapGesture { selectDate(date) }
    }
    
    func selectDate(_ date: Date) {
        if startDate == nil {
            startDate = date
        } else if endDate == nil && date >= startDate! {
            endDate = date
        } else if endDate == nil && date < startDate! {
            startDate = date
        } else {
            startDate = date
            endDate = nil
        }
    }
    
    func isDateSelected(_ date: Date) -> Bool {
        return calendar.isDate(date, inSameDayAs: startDate ?? Date.distantFuture) ||
               calendar.isDate(date, inSameDayAs: endDate ?? Date.distantFuture)
    }
    
    func isDateInRange(_ date: Date) -> Bool {
        guard let start = startDate, let end = endDate else { return false }
        return date >= start && date <= end
    }

    func getMonthDate(offset: Int) -> Date? {
        return calendar.date(byAdding: .month, value: offset, to: Date())
    }
    
    func monthTitle(offset: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        guard let date = getMonthDate(offset: offset) else { return "" }
        return formatter.string(from: date)
    }
    
    func daysInMonth(offset: Int) -> [Date?] {
        guard let monthDate = getMonthDate(offset: offset) else { return [] }
        let components = calendar.dateComponents([.year, .month], from: monthDate)
        guard let startOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: startOfMonth) else { return [] }
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let leadingSpaces = firstWeekday - 1
        var days: [Date?] = Array(repeating: nil, count: leadingSpaces)
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(date)
            }
        }
        return days
    }
}

#Preview {
    ReportView()
}
