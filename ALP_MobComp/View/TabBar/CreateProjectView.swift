//
//  CreateProjectView.swift
//  ALP_MobComp
//
//  Created by student on 28/11/25.
//

import SwiftUI

struct CreateProjectView: View {
    @Environment(\.dismiss) var dismiss

    @State private var projectName = ""
    @State private var clientName = ""
    @State private var clientEmail = ""
    @State private var clientPhone = ""
    @State private var projectDescription = ""
    @State private var price = ""

    var body: some View {
                // Navigation Bar
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
                    }
                    Spacer()
                }
                .overlay(
                    Text("Create Project")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
                )
                .padding()
                
            ScrollView {
                Group {
                    CustomTextField(
                        label: "Project Name",
                        placeholder: "Write the project name",
                        text: $projectName
                    )

                    CustomTextField(
                        label: "Client Name",
                        placeholder: "Write the client name",
                        text: $clientName
                    )

                    CustomTextField(
                        label: "Client Email",
                        placeholder: "@gmail.com",
                        text: $clientEmail
                    )
                    .keyboardType(.emailAddress)

                    CustomTextField(
                        label: "Client Mobile Number",
                        placeholder: "Phone Number",
                        text: $clientPhone
                    )
                    .keyboardType(.numberPad)

                    CustomTextEditor(
                        title: "Description of Project",
                        placeholder: "Write down the description",
                        text: $projectDescription
                    )
                }


                // PRICE Input
                VStack(alignment: .leading, spacing: 6) {
                    Text("Price")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    HStack {
                        Menu {
                            Button("Rp") {}
                        } label: {
                            HStack {
                                Text("Rp")
                                Image(systemName: "chevron.down")
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background(Color(.white).opacity(0.3))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                )
                        }

                        TextField("Write the price", text: $price)
                            .keyboardType(.numberPad)
                    }
                    .padding()
                    .background(Color(.systemGray6).opacity(0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                        )
                    
                }
                .padding(.horizontal)

                // Upload Contract
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 4) {
                        Text("Upload Contract")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("(optional)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Image(systemName: "arrow.up.doc")
                        Text("Only .pdf")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                        )
                }
                .padding(.horizontal)

                // SUBMIT Button
                Button(action: {
                    
                    dismiss()
                }) {
                    Text("Submit")
                        .fontWeight(.semibold)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.15, green: 0.45, blue: 0.25))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.top, 10)

            }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    CreateProjectView()
}
