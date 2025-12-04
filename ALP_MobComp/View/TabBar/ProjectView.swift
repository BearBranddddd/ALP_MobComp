//
//  ProjectView.swift
//  ALP_MobComp
//
//  Created by student on 27/11/25.
//

import SwiftUI

// model
struct Project: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let client: String
    let date: String
    let amount: String
    let status: Bool
    let platformIcon: String
}

struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let status: String
    let invoiceNumber: String
    let platformIcon: String
}

// dummy data
let ongoingProjects: [Project] = [
    Project(
        title: "Design for Desktop Website E-Commerce Shop",
        description: "Project design for desktop website e-commerce shop for PT. Sukses Makmur Selalu",
        client: "PT. Sukses Makmur Selalu",
        date: "15 Nov, 2025",
        amount: "Rp 6.504.300",
        status: true,
        platformIcon: "fiverr_transaction"
    ),
    Project(
        title: "Logo Branding for Urban Coffee",
        description: "Branding design for coffee shop including logo & marketing assets",
        client: "Urban Coffee",
        date: "10 Nov, 2025",
        amount: "Rp 3.200.000",
        status: false,
        platformIcon: "fiverr_transaction"
    ),
    Project(
        title: "Mobile UI/UX for Edu App",
        description: "Educational app UI design for children",
        client: "EduTech",
        date: "8 Nov, 2025",
        amount: "Rp 5.100.000",
        status: true,
        platformIcon: "fiverr_transaction"
    )
]

let projectTransactions: [Transaction] = [
    Transaction(
        title: "Cashier Application System for GFC",
        date: "1 Nov, 2025",
        status: "Completed",
        invoiceNumber: "2WE349576013",
        platformIcon: "fiverr_transaction"
    ),
    Transaction(
        title: "UI/UX Design for Library Systems",
        date: "29 Sept, 2025",
        status: "Completed",
        invoiceNumber: "D23DFI65MS87",
        platformIcon: "fiverr_transaction"
    )
]

// komponen
struct SearchBarView: View {
    @State private var searchText: String = ""
    @State private var showFilterSheet: Bool = false
        
    // Filter state variables
    @State private var selectedPlatform: String = "All"
    @State private var paymentStatus: String = "All"
    @State private var invoiceStatus: String = "All"
    @State private var sorting: String = "Tanggal Terbaru"
        
    let platformOptions = ["All", "Upwork", "Fiverr", "Manual"]
    let paymentOptions = ["All", "Paid", "Unpaid"]
    let invoiceOptions = ["All", "With Invoice", "No Invoice"]
    let sortingOptions = ["Tanggal Terbaru", "Nama Proyek", "Nilai Proyek"]
    
    
    var body: some View {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $searchText)
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    Button(action: {
                        showFilterSheet.toggle()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundColor(Color.black)
                    }
                    .padding(.leading, 8)
                    .sheet(isPresented: $showFilterSheet) {
                        FilterSheetView(
                            selectedPlatform: $selectedPlatform,
                            paymentStatus: $paymentStatus,
                            invoiceStatus: $invoiceStatus,
                            sorting: $sorting,
                            platformOptions: platformOptions,
                            paymentOptions: paymentOptions,
                            invoiceOptions: invoiceOptions,
                            sortingOptions: sortingOptions
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }

struct FilterSheetView: View {
    
    @Binding var selectedPlatform: String
    @Binding var paymentStatus: String
    @Binding var invoiceStatus: String
    @Binding var sorting: String
    
    let platformOptions: [String]
    let paymentOptions: [String]
    let invoiceOptions: [String]
    let sortingOptions: [String]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Platform")) {
                    Picker("Platform", selection: $selectedPlatform) {
                        ForEach(platformOptions, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
                
                Section(header: Text("Status Pembayaran")) {
                    Picker("Pembayaran", selection: $paymentStatus) {
                        ForEach(paymentOptions, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
                
                Section(header: Text("Status Invoice")) {
                    Picker("Invoice", selection: $invoiceStatus) {
                        ForEach(invoiceOptions, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
            .navigationTitle("Filter")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ProjectCardView: View {
    let project: Project
    
    var body: some View {
        // 1. Set spacing: 0 agar Header hijau nempel sempurna dengan body bawah
        VStack(alignment: .leading, spacing: 0) {
            
            // --- BAGIAN HEADER HIJAU ---
            HStack {
                Text(project.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Spacer()
                
                Text(project.status ? "Unpaid" : "Paid")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(project.status ? Color.red.opacity(0.7) : Color.green.opacity(0.7))
                    .cornerRadius(15)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.15, green: 0.45, blue: 0.25))
            .clipShape(RoundedCorner(radius: 14, corners: [.topLeft, .topRight]))
            
            // --- BAGIAN ISI KONTEN ---
            VStack(alignment: .leading, spacing: 12) {
                
                Text(project.description)
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.85))
                    .lineLimit(1)
                
                HStack(spacing: 6) {
                    Image(project.platformIcon)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .clipShape(Circle())
                    Text("\(project.client)")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
                
                HStack {
                    Label(project.date, systemImage: "calendar")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Label(project.amount, systemImage: "banknote")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                
                Divider().background(Color.black.opacity(0.5))
                
                HStack {
                    Text("No invoice yet")
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.75))
                    Spacer()
                    Button(action: {}) {
                        Label("Generate Invoice", systemImage: "plus")
                            .font(.caption)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 10)
                            .background(Color.green)
                            .cornerRadius(15)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(15) // Padding konten bawah agar tidak mepet pinggir
        }
        // --- BAGIAN KARTU UTAMA ---
        .frame(width: UIScreen.main.bounds.width * 0.85)
        .background(Color.white)
        .cornerRadius(14) // Membulatkan bagian bawah (atas sudah dihandle Header)
        .shadow(radius: 5, x: 2, y: 2)
    }
}

struct NewProjectPromptView: View {
    var body: some View {
        HStack {
            Text("Have your own project not from platform?")
                .font(.footnote)
            
            Spacer()
            
            NavigationLink(destination: CreateProjectView()) {
                Label("Create Project", systemImage: "plus")
                    .font(.caption)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Color(red: 0.15, green: 0.45, blue: 0.25))
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            

        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Image(transaction.platformIcon)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(transaction.date).font(.caption).foregroundColor(.gray)
                
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(transaction.status)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                Text(transaction.invoiceNumber)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 6)
    }
}

// Main View

struct ProjectView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Text("Projects")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
                        .padding(.horizontal)
                        .padding(.top)
                    
                    SearchBarView()
                    
                    // Ongoing Projects Title
                    HStack {
                        Text("Ongoing Project")
                            .font(.title2.bold())
                            .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
                        Text("\(ongoingProjects.count)")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                            .padding(7)
                            .background(
                                Circle()
                                    .fill(Color(red: 0.15, green: 0.45, blue: 0.25))
                            )
                        Spacer()
                        
                        NavigationLink(destination: OngoingProjectListView()) {
                            Text("See All")
                        }

                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Horizontal Scroll Carousel
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(ongoingProjects) { project in
                                ProjectCardView(project: project)
                                    .frame(width: UIScreen.main.bounds.width * 0.85)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                    
                    NewProjectPromptView()
                    
                    // Transactions
                    HStack {
                        Text("Transaction for Project")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
                        Spacer()
                        NavigationLink(destination: TransactionListView()) {
                            Text("See All")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    VStack(spacing: 12) {
                        ForEach(projectTransactions) { transaction in
                            TransactionRowView(transaction: transaction)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(.bottom, 40)
            }
            .padding(.bottom, 20)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ProjectView()
}
