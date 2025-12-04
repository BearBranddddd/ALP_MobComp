import SwiftUI

// ✅ 1. MODEL DATA UNTUK TEMPLATE
struct EmailTemplate: Identifiable, Hashable {
    let id = UUID()
    var name: String     // Contoh: "Payment Reminder"
    var subject: String
    var body: String
}

struct SettingsView: View {
    @State private var showAddPlatformModal = false
    @State private var visibleCount = 3
    
    @State private var businessName = "Bear Brand Moment"
        @State private var businessEmail = "BBM@gmail.com"
        @State private var businessPhone = "+62 812-3456-7890"

    // ✅ STATE UNTUK TEMPLATE EMAIL
    @State private var emailTemplates: [EmailTemplate] = [
        EmailTemplate(
            name: "Payment Reminder",
            subject: "Payment Reminder for {PROJECT_NAME}",
            body: """
            Hello {CLIENT_NAME},

            This is a friendly reminder that your payment for the project "{PROJECT_NAME}" (total of {CURRENCY} {AMOUNT}) is still pending.

            The due date for this invoice is {DUE_DATE}.
            We'd appreciate it if you could complete the payment at your earliest convenience.

            If you've already made the payment, please disregard this message.

            Thank you so much for your attention!

            Best,
            {FREELANCER_NAME}
            {FREELANCER_BUSINESS_NAME}
            """
        ),
        EmailTemplate(
            name: "Send Invoice",
            subject: "Invoice #{INVOICE_NUMBER} for {PROJECT_NAME}",
            body: """
            Hi {CLIENT_NAME},

            I hope you are doing well.

            Please find attached the invoice for the project "{PROJECT_NAME}".
            The total amount due is {CURRENCY} {AMOUNT}.

            Invoice Details:
            - Invoice Number: {INVOICE_NUMBER}
            - Date: {INVOICE_DATE}
            - Due Date: {DUE_DATE}

            Please make the payment by the due date. We truly appreciate your trust and collaboration.

            If you have any questions, feel free to reach out at any time.

            Warm regards,
            {FREELANCER_NAME}
            {FREELANCER_BUSINESS_NAME}
            """
        )
    ]
    
    @State private var selectedTemplateForView: EmailTemplate? = nil

    // ✅ DATA PLATFORM
    let platforms = [
        (name: "Upwork", status: "Connected"),
        (name: "Fiverr", status: "Connected"),
        (name: "Sribulancer", status: "Connected"),
        (name: "Freelancer", status: "Connected"),
        (name: "PeoplePerHour", status: "Connected"),
        (name: "Toptal", status: "Connected"),
        (name: "Guru", status: "Connected"),
        (name: "Projects.co.id", status: "Connect"),
        (name: "LinkedIn", status: "Connect"),
        (name: "Glints", status: "Connect")
    ]

    var connectedPlatforms: [(name: String, status: String)] {
        platforms.filter { $0.status == "Connected" }
    }

    var paginatedPlatforms: [(name: String, status: String)] {
        Array(connectedPlatforms.prefix(visibleCount))
    }

    // ✅ BODY UTAMA (DIPERBAIKI AGAR TIDAK ERROR)
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // 1. Header Profile
                        headerProfileView
                        
                        // 2. Platform Integration
                        platformIntegrationView
                        
                        // 3. Template Email
                        templateEmailView
                        
                        // 4. Invoice Settings
                        invoiceSettingsView
                        
                    }
                }
            }

            // ===== FLOATING MODAL ADD PLATFORM =====
            if showAddPlatformModal {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showAddPlatformModal = false
                        }
                    }

                AddPlatformFloatingModal(
                    showModal: $showAddPlatformModal,
                    platforms: platforms
                )
                .transition(.scale.combined(with: .opacity))
                .zIndex(1)
            }
            
            // ===== FLOATING MODAL VIEW TEMPLATE =====
            if let template = selectedTemplateForView {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { selectedTemplateForView = nil }
                    }
                
                ViewTemplateModal(template: template, onClose: {
                    withAnimation { selectedTemplateForView = nil }
                })
                .transition(.scale.combined(with: .opacity))
                .zIndex(2)
            }
        }
    }
    
    // MARK: - SUBVIEWS (PEMECAHAN KODE AGAR COMPILER TIDAK ERROR)
    
    var headerProfileView: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
//                    .padding(.horizontal)
                    .padding(.top)
                
                Spacer()
            }
            
            Image(systemName: "pawprint.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.brown)

            Text("Bernard")
                .font(.title2)
                .fontWeight(.semibold)

            Text("bernardofkowe@gmail.com")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.6))

            NavigationLink(destination: EditProfileView()) {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(red: 0.15, green: 0.45, blue: 0.25))
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
    }
    
    var platformIntegrationView: some View {
        settingsCard(title: "Platform Integrations") {

            ForEach(paginatedPlatforms, id: \.name) { item in
                PlatformRowView(platform: item.name, status: item.status)
            }

            // SHOW MORE / LESS CONTROL
            HStack {
                if visibleCount < connectedPlatforms.count {
                    Button("Show more...") {
                        withAnimation {
                            if visibleCount == 3 {
                                visibleCount = min(6, connectedPlatforms.count)
                            } else {
                                visibleCount = connectedPlatforms.count
                            }
                        }
                    }
                    .foregroundColor(.gray)
                }

                Spacer()

                if visibleCount > 3 {
                    Button("Show less") {
                        withAnimation {
                            if visibleCount > 6 {
                                visibleCount = 6
                            } else {
                                visibleCount = 3
                            }
                        }
                    }
                    .foregroundColor(.red)
                }
            }
            .padding(.horizontal)

            Button("Add Platform Integrations") {
                withAnimation(.easeInOut) {
                    showAddPlatformModal = true
                }
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(Color(red: 0.15, green: 0.45, blue: 0.25))
            .cornerRadius(20)
            .foregroundColor(.white)
        }
    }
    
    var templateEmailView: some View {
        settingsCard(title: "Template Email") {
            // Loop data template
            ForEach(emailTemplates) { template in
                TemplateRowView(
                    template: template,
                    onView: {
                        // Aksi View: Buka Modal
                        withAnimation {
                            selectedTemplateForView = template
                        }
                    }
                )
            }
            
            // Tombol Edit Global (Masuk ke halaman edit)
            NavigationLink(destination: EditTemplateView(templates: $emailTemplates)) {
                Text("Edit Templates")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(red: 0.15, green: 0.45, blue: 0.25))
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
        }
    }
    
    var invoiceSettingsView: some View {
            settingsCard(title: "Invoice Settings") {
                // 1. Header dengan Logo
                HStack {
                    VStack(alignment: .leading) {
                        Text("Logo Photo").font(.subheadline).fontWeight(.semibold)
                    }
                    Spacer()
                    Circle().stroke(.gray, lineWidth: 1).frame(width: 70, height: 70).overlay(
                        Image(systemName: "photo.badge.plus").font(.title).foregroundColor(.gray)
                    )
                }
                
                // 2. Data Bisnis
                inputField(title: "Business Name", value: businessName)
                inputField(title: "Business Email", value: businessEmail)
                inputField(title: "Contact Number", value: businessPhone) // ✅ Ditambahkan
                
                // 3. Signature Preview (Ditambahkan)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Signature")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 60)
                        .overlay(
                            HStack {
                                Image(systemName: "signature")
                                    .foregroundColor(.gray)
                                Text("Signature Uploaded")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                }

                // 4. Tombol Edit
                NavigationLink(destination: EditInvoiceView(
                    name: $businessName,
                    email: $businessEmail,
                    phone: $businessPhone
                )) {
                    Text("Edit Invoice")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.15, green: 0.45, blue: 0.25))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                }
            }
        }
}

// MARK: - COMPONENTS

struct PlatformRowView: View {
    var platform: String
    var status: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "star.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)

                Text(platform)

                Spacer()

                Button(status) {}
                    .font(.caption)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .background(Color(red: 0.15, green: 0.45, blue: 0.25))
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 6)

            Divider()
        }
    }
}

struct TemplateRowView: View {
    var template: EmailTemplate
    var onView: () -> Void
    
    var body: some View {
        HStack {
            Text(template.name)
            Spacer()

            Button("View") {
                onView()
            }
            .font(.caption)
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(Color(red: 0.15, green: 0.45, blue: 0.25))
            .cornerRadius(8)
            .foregroundColor(.white)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

struct AddPlatformFloatingModal: View {
    @Binding var showModal: Bool
    let platforms: [(name: String, status: String)]

    @State private var searchText = ""
    @State private var selectedIndex = 0

    let options = ["All", "Connected"]

    var filteredPlatforms: [(name: String, status: String)] {
        platforms.filter { item in
            let matchSearch =
                searchText.isEmpty ||
                item.name.lowercased().contains(searchText.lowercased())

            let matchFilter =
                selectedIndex == 0
                ? true
                : item.status == "Connected"

            return matchSearch && matchFilter
        }
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            // HEADER
            HStack {
                Text("Integrations")
                    .font(.title3)
                    .fontWeight(.bold)

                Spacer()

                Button {
                    withAnimation {
                        showModal = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(6)
                }
            }

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField("Search platform...", text: $searchText)
                    .padding(8)

                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            )

            // FILTER
            Picker("Filter", selection: $selectedIndex) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index])
                }
            }
            .pickerStyle(.segmented)

            // LIST
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(filteredPlatforms, id: \.name) { item in
                        PlatformRowView(
                            platform: item.name,
                            status: item.status
                        )
                    }

                    if filteredPlatforms.isEmpty {
                        Text("No platform found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                    }
                }
            }
            .frame(maxHeight: 250)
        }
        .padding(20)
        .frame(maxWidth: 360)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        .padding(.horizontal, 24)
    }
}

// MARK: - HELPERS

@ViewBuilder
func settingsCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 20) {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)

        content()
    }
    .padding()
    .background(Color.white)
    .cornerRadius(12)
    .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 3)
    .padding(.horizontal)
}

@ViewBuilder
func inputField(title: String, value: String) -> some View {
    VStack(alignment: .leading, spacing: 4) {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)

        TextField("", text: .constant(value))
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
    }
}

// MARK: - MODAL VIEW TEMPLATE

struct ViewTemplateModal: View {
    var template: EmailTemplate
    var onClose: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text("View Template")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
                
                Spacer()
                
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.title3)
                }
            }
            
            Divider()
            
            // Subject
            Text("Subject: \(template.subject)")
                .font(.headline)
            
            // Body
            ScrollView {
                Text(template.body)
                    .font(.body)
                    .padding(.top, 5)
            }
            .frame(maxHeight: 300)
            
            Divider()
            
            // Close Button Bottom
            Button(action: onClose) {
                Text("Close")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(red: 0.15, green: 0.45, blue: 0.25), lineWidth: 1)
                    )
                    .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
            }
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}

// MARK: - EDIT TEMPLATE VIEW

// MARK: - EDIT TEMPLATE VIEW (WITH VALIDATION)

struct EditTemplateView: View {
    @Binding var templates: [EmailTemplate]
    @Environment(\.dismiss) var dismiss
    
    // State untuk memilih template mana yang diedit
    @State private var selectedTemplateID: UUID
    
    // ✅ STATE BARU UNTUK ALERT VALIDASI
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    // Warna tema aplikasi
    let themeColor = Color(red: 0.15, green: 0.45, blue: 0.25)
    
    // Helper Variables (Wajib ada semua)
    let variables = ["{CLIENT_NAME}", "{PROJECT_NAME}", "{AMOUNT}", "{CURRENCY}", "{DUE_DATE}", "{INVOICE_NUMBER}", "{INVOICE_DATE}"]

    init(templates: Binding<[EmailTemplate]>) {
        _templates = templates
        _selectedTemplateID = State(initialValue: templates.wrappedValue.first?.id ?? UUID())
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // --- 1. DROPDOWN PILIH TEMPLATE ---
                VStack(alignment: .leading, spacing: 8) {
                    Text("Template Name")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.7))
                    
                    Menu {
                        Picker("Select Template", selection: $selectedTemplateID) {
                            ForEach(templates) { template in
                                Text(template.name).tag(template.id)
                            }
                        }
                    } label: {
                        HStack {
                            Text(templates.first(where: { $0.id == selectedTemplateID })?.name ?? "Select Template")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
                
                // Cari index berdasarkan ID yang dipilih
                if let index = templates.firstIndex(where: { $0.id == selectedTemplateID }) {
                    
                    // --- 2. SUBJECT INPUT ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email Subject")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black.opacity(0.7))
                        
                        TextField("Enter subject...", text: $templates[index].subject)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    
                    // --- 3. BODY INPUT ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Message Body")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black.opacity(0.7))
                        
                        TextEditor(text: $templates[index].body)
                            .frame(height: 250)
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    
                    // --- 4. AVAILABLE TAGS ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Available Variables (Required)") // Ubah teks jadi Required
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(variables, id: \.self) { variable in
                                    // Cek visual: Jika variabel sudah dipakai, warnanya jadi solid, jika belum jadi pudar (Opsional, visual feedback)
                                    let isUsed = (templates[index].subject + templates[index].body).contains(variable)
                                    
                                    Text(variable)
                                        .font(.caption)
                                        .fontWeight(isUsed ? .bold : .regular)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(isUsed ? themeColor.opacity(0.2) : themeColor.opacity(0.05))
                                        .foregroundColor(isUsed ? themeColor : .gray)
                                        .cornerRadius(6)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(isUsed ? themeColor : Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    // --- 5. SAVE BUTTON DENGAN VALIDASI ---
                    Button(action: {
                        // 1. Ambil data saat ini
                        let currentSubject = templates[index].subject
                        let currentBody = templates[index].body
                        let combinedText = currentSubject + " " + currentBody
                        
                        // 2. Filter variabel mana yang BELUM ada di teks
                        let missingVariables = variables.filter { variable in
                            !combinedText.contains(variable)
                        }
                        
                        // 3. Cek Kondisi
                        if !missingVariables.isEmpty {
                            // Jika ada yang hilang, tampilkan Alert
                            let missingList = missingVariables.joined(separator: ", ")
                            alertMessage = "You must include all required variables.\n\nMissing variables:\n\(missingList)"
                            showingAlert = true
                        } else {
                            // Jika lengkap, baru tutup halaman (Save berhasil)
                            dismiss()
                        }
                        
                    }) {
                        Text("Save Changes")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(themeColor)
                            .cornerRadius(15)
                            .shadow(color: themeColor.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                    // ✅ MODIFIER ALERT
                    .alert("Incomplete Template", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text(alertMessage)
                    }
                    
                } // End if let index
            }
            .padding(20)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Edit Template")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditInvoiceView: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var phone: String
    @Environment(\.dismiss) var dismiss
    
    @State private var signatureOption: SignatureType = .upload
    enum SignatureType { case upload, draw }
    
    let themeColor = Color(red: 0.15, green: 0.45, blue: 0.25)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // BUSINESS LOGO
                VStack(alignment: .leading, spacing: 8) {
                    Text("Business Logo").font(.headline)
                    VStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(.gray).frame(height: 100)
                            .overlay(VStack(spacing: 8) {
                                Image(systemName: "photo").font(.title2).foregroundColor(.gray)
                                Text("Upload Logo (PNG, JPG)").font(.caption).foregroundColor(.gray)
                            })
                        Button("Remove Logo") {}.font(.caption).fontWeight(.semibold).foregroundColor(themeColor).underline()
                    }
                }
                
                // BUSINESS INFORMATION
                VStack(alignment: .leading, spacing: 16) {
                    Text("Business Information").font(.headline)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Business Name").font(.caption).foregroundColor(.gray)
                        TextField("e.g. Bear Design Studio", text: $name).padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Business Email").font(.caption).foregroundColor(.gray)
                        TextField("e.g. hello@beardesign.com", text: $email).padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Contact Number").font(.caption).foregroundColor(.gray)
                        TextField("e.g. +62 812-3456-7890", text: $phone).padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                    }
                }
                
                // SIGNATURE
                VStack(alignment: .leading, spacing: 12) {
                    Text("Signature").font(.headline)
                    HStack(spacing: 20) {
                        RadioButton(title: "Upload Image", isSelected: signatureOption == .upload) { signatureOption = .upload }
                        RadioButton(title: "Draw Here", isSelected: signatureOption == .draw) { signatureOption = .draw }
                    }
                    if signatureOption == .upload {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(.gray).frame(height: 80)
                            .overlay(Text("Upload Signature").font(.caption).foregroundColor(.gray))
                    } else {
                        RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            .frame(height: 120).background(Color.gray.opacity(0.05))
                            .overlay(Text("Canvas Area").font(.caption).foregroundColor(.gray.opacity(0.5)))
                    }
                }
                
                Spacer(minLength: 20)
                
                Button(action: { dismiss() }) {
                    Text("Save Settings").font(.headline).fontWeight(.bold).foregroundColor(.white)
                        .frame(maxWidth: .infinity).padding().background(themeColor).cornerRadius(12)
                }
            }.padding(20)
        }
        .navigationTitle("Invoice Settings").navigationBarTitleDisplayMode(.inline)
    }
    
    func RadioButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                ZStack {
                    Circle().stroke(isSelected ? themeColor : .gray, lineWidth: 2).frame(width: 20, height: 20)
                    if isSelected { Circle().fill(themeColor).frame(width: 10, height: 10) }
                }
                Text(title).font(.subheadline).foregroundColor(.black)
            }
        }
    }
}

#Preview {
    SettingsView()
}
