//
//  EditProfileView.swift
//  ALP_MobComp
//
//  Created by student on 28/11/25.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = "Bernardo Frederick Kowe"
    @State private var email: String = "bernardofkowe@gmail.com"
    @State private var phone: String = "+62 851-2544-7985"
    @State private var bank: String = "Bank Central Asia (BCA)"
    @State private var accountNumber: String = "8431230956"
    @State private var connectTo: String = "Fiverr"
    
    var body: some View {
                // MARK: - Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
                    }
                    Spacer()
                }
                .overlay(
                    Text("Edit Profile")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
                ) .padding()
                
                // MARK: - Profile Picture
                ScrollView {
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "pawprint.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.brown)
                        
                        Button(action: {}) {
                            Circle()
                                .fill(Color(red: 0.15, green: 0.45, blue: 0.25))
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Image(systemName: "pencil")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                )
                        }
                    }
                    
                    
                    // MARK: - Personal Info Card
                    settingsCard {
                        VStack(alignment: .leading, spacing: 12) {
                            customField(label: "Name", text: $name)
                            customField(label: "E-Mail", text: $email)
                            customField(label: "Mobile Number", text: $phone)
                            
                            saveButton()
                        }
                    }
                    
                    // MARK: - Bank Info Card
                    settingsCard {
                        VStack(alignment: .leading, spacing: 12) {
                            customField(label: "Bank", text: $bank)
                            customField(label: "Bank Account Number", text: $accountNumber)
                            
                            HStack {
                                Text("Connect to")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                HStack {
                                    Text(connectTo)
                                    Button(action: {}) {
                                        Image(systemName: "plus")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                                )
                            }
                            
                            saveButton()
                        }
                    }
                } .navigationBarBackButtonHidden(true)
    } 
    
    //MARK: - Components
    @ViewBuilder
    func customField(label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            TextField("", text: text)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                )
        }
    }
    
    @ViewBuilder
    func saveButton() -> some View {
        Button(action: {}) {
            Text("Save Changes")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color(red: 0.15, green: 0.45, blue: 0.25))
                .cornerRadius(10)
                .foregroundColor(.white)
        }
        .padding(.top, 6)
    }
    
    @ViewBuilder
    func settingsCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading) {
            content()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 3)
        .padding(.horizontal)
    }
}

#Preview {
    EditProfileView()
}
