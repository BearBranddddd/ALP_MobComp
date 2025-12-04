//
//  HomeView.swift
//  ALP_MobComp
//
//  Created by Bernardo Frederick Kowe on 26/11/25.
//

import SwiftUI

struct DashboardView: View {
    // Warna Tema (Diambil dari sample hijau di screenshot)
    let themeGreen = Color(red: 0.15, green: 0.45, blue: 0.25)
    let lightGreen = Color(red: 0.4, green: 0.7, blue: 0.4)
    let bgGray = Color(uiColor: .systemGroupedBackground)
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Background Color (Gray)
                bgGray.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // ✅ ScrollView ignore safe area top agar Header bisa mentok ke atas layar
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            
                            // 1. Header & Income Card (Digabung agar overlapping)
                            ZStack(alignment: .top) {
                                HeaderView(themeGreen: themeGreen)
                                
                                // Floating Income Card
                                IncomeCardView(themeGreen: themeGreen)
                                    .padding(.top, 140) // Jarak card dari atas (menyesuaikan tinggi header)
                                    .padding(.horizontal, 20)
                            }
                            .zIndex(1) // Pastikan layer ini di atas
                            
                            // 2. Status Row (Unpaid, Overdue, Paid)
                            StatusRowView()
                                .padding(.horizontal, 20)
                                .padding(.top, 20) // Jarak tambahan agar tidak mepet card
                            
                            // 3. Project List (Needs Invoice)
                            ProjectListView(themeGreen: themeGreen)
                                .padding(.horizontal, 20)
                            
                            // 4. Income Source (Donut Chart)
                            IncomeSourceView(themeGreen: themeGreen)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 120) // Spacer bawah agar tidak tertutup Tab Bar
                        }
                    }
                    .ignoresSafeArea(edges: .top) // ✅ KUNCI: Scrollview mulai dari pixel 0 layar
                }
                
                // 5. Floating Action Button (+) & Tab Bar
                VStack {
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: CreateProjectView()) {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(themeColor)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                    }
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom) // Mencegah layout rusak saat keyboard muncul (opsional)
        }
    }
            // Helper color shortcut
            var themeColor: Color { themeGreen }
        }

        // MARK: - 1. HEADER VIEW
        struct HeaderView: View {
            var themeGreen: Color
            
            var body: some View {
                VStack(alignment: .leading, spacing: 8) {
                    
                    // ✅ Spacer transparant untuk "mengganjal" konten agar tidak ketutup Poni/Notch HP
                    // Karena kita pakai .ignoresSafeArea(), konten akan naik ke status bar.
                    Spacer().frame(height: 60)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hi, Bernard!")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Let's check your progress.")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        Spacer()
                        
                        // Profile Image Placeholder
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    
                    Text("Today, 1 Dec | 5 Active Projects")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 10)
                    
                    // Spacer untuk memberi ruang bagi Floating Card di bawahnya
                    Spacer().frame(height: 100)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
                .background(themeGreen) // Warna hijau background
                // Membuat sudut bawah melengkung
                .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight]))
                .ignoresSafeArea(edges: .top) // ✅ KUNCI: Warna hijau meluas sampai ke atas layar (status bar)
            }
        }

// MARK: - 2. INCOME CARD VIEW (GRAPH)
struct IncomeCardView: View {
    var themeGreen: Color
    @State private var isYearly = false
    
    // Dummy data untuk grafik batang
    let barHeights: [CGFloat] = [40, 70, 50, 45, 90, 80, 50]
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Header Card
            HStack {
                Text("Total Income")
                    .font(.headline)
                
                Spacer()
                
                // Custom Toggle Style
                HStack(spacing: 0) {
                    Text("This Month")
                        .font(.caption)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(.gray)
                    
                    Text("This Year")
                        .font(.caption)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .foregroundColor(.gray)
                }
                .background(Color.white)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.2), lineWidth: 1))
            }
            
            Text("Rp 15.000.000")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(themeGreen)
            
            // Bar Chart Visual
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(0..<barHeights.count, id: \.self) { index in
                    VStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(LinearGradient(colors: [themeGreen.opacity(0.8), themeGreen], startPoint: .top, endPoint: .bottom))
                            .frame(height: barHeights[index]) // Tinggi dinamis
                        
                        Text(days[index])
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
            .frame(height: 100) // Tinggi area chart
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

// MARK: - 3. STATUS ROW VIEW
struct StatusRowView: View {
    var body: some View {
        HStack(spacing: 12) {
            StatusCard(icon: "hourglass", color: .yellow, title: "Unpaid", amount: "Rp 4.500.000", sub: "")
            StatusCard(icon: "exclamationmark.circle.fill", color: .red, title: "Overdue", amount: "Rp 1.200.000", sub: "Action needed!")
            StatusCard(icon: "wallet.pass.fill", color: .green, title: "Paid", amount: "Rp 10.500.000", sub: "")
        }
    }
}

struct StatusCard: View {
    var icon: String
    var color: Color
    var title: String
    var amount: String
    var sub: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .padding(10)
                .background(color.opacity(0.1))
                .clipShape(Circle())
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
            
            Text(amount)
                .font(.system(size: 10, weight: .bold))
                .multilineTextAlignment(.center)
            
            if !sub.isEmpty {
                Text(sub)
                    .font(.system(size: 8))
                    .foregroundColor(.red)
            }
        }
        .frame(maxWidth: .infinity) // Agar lebar sama rata
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

// MARK: - 4. PROJECT LIST VIEW
struct ProjectListView: View {
    var themeGreen: Color
    
    var body: some View {
        VStack(spacing: 0) {
            // Tabs
            HStack {
                VStack(spacing: 8) {
                    Text("Upcoming Due")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Color.clear.frame(height: 2)
                }
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 8) {
                    Text("Needs Invoice")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Color(themeGreen).frame(height: 2)
                }
                .frame(maxWidth: .infinity)
            }
            
            Divider()
            
            // List Items
            VStack(spacing: 16) {
                ProjectItemRow(title: "Project: E-commerce Website", client: "Client: Acme Corp", themeGreen: themeGreen)
                Divider()
                ProjectItemRow(title: "Project: Logo Design", client: "Client: Stark Ind", themeGreen: themeGreen)
            }
            .padding(.top, 16)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

struct ProjectItemRow: View {
    var title: String
    var client: String
    var themeGreen: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.bold)
                Text(client)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button("Generate") {}
                .font(.caption)
                .fontWeight(.medium)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .foregroundColor(themeGreen)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(themeGreen, lineWidth: 1)
                )
        }
    }
}

// MARK: - 5. INCOME SOURCE VIEW
struct IncomeSourceView: View {
    var themeGreen: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Income Source (This Month)")
                .font(.headline)
            
            HStack(spacing: 20) {
                // Donut Chart Visual
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    
                    Circle()
                        .trim(from: 0.0, to: 0.5) // 50%
                        .stroke(themeGreen, lineWidth: 20)
                        .rotationEffect(.degrees(-90))
                    
                    Circle()
                        .trim(from: 0.5, to: 0.8) // 30%
                        .stroke(themeGreen.opacity(0.7), lineWidth: 20)
                        .rotationEffect(.degrees(-90))
                    
                    Circle()
                        .trim(from: 0.8, to: 1.0) // 20%
                        .stroke(themeGreen.opacity(0.4), lineWidth: 20)
                        .rotationEffect(.degrees(-90))
                }
                .frame(width: 100, height: 100)
                .padding(10)
                
                // Legend
                VStack(alignment: .leading, spacing: 10) {
                    LegendItem(color: themeGreen, title: "Manual Projects (50%)", amount: "- Rp 7.500.000")
                    LegendItem(color: themeGreen.opacity(0.7), title: "Upwork (30%)", amount: "- Rp 4.500.000")
                    LegendItem(color: themeGreen.opacity(0.4), title: "Fiverr (20%)", amount: "- Rp 3.000.000")
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

struct LegendItem: View {
    var color: Color
    var title: String
    var amount: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
                .padding(.top, 4)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.black)
                Text(amount)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    DashboardView()
}

