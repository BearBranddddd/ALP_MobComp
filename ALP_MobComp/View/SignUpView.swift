//
//  SignUpView.swift
//  ALP_MobComp
//
//  Created by Stefanie Agahari on 26/11/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var agreePersonalData: Bool = false

    var body: some View {
        ZStack {
            // Background abu muda
            Color(hex: "F6F8FA")
                .ignoresSafeArea()

            // Shape gradient hijau
            VStack {
                BottomRoundedRectangle(radius: 150)
                    .frame(width: 510, height: 460)
                    .padding(.bottom, 520)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(hex: "85BA83"), location: 0.0),
                                .init(color: Color(hex: "3D7D3B"), location: 0.50),
                                .init(color: Color(hex: "266524"), location: 0.75),
                                .init(color: Color(hex: "154A13"), location: 0.88),
                                .init(color: Color(hex: "000000"), location: 1.0),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }

            VStack(spacing: 20) {

                Spacer().frame(height: 40)

                // Logo
                Image("logo_mobcomp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220)
                    .padding(.top, 40)
                    .padding(.bottom, -50)

                // Title
                Text("Get Started")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)

                // White Card
                VStack(spacing: 14) {

                    // Google Button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "g.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.red)

                            Text("Sign In with Google")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 0.4)
                    )

                    // Apple Button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "apple.logo")
                                .font(.system(size: 20))

                            Text("Sign In with Apple")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 0.4)
                    )

                    // Or Divider
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.4))

                        Text("Or")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.4))
                    }
                    .padding(.vertical, 4)

                    // Full Name
                    TextField("Enter Full Name", text: $fullName)
                        .font(.system(size: 14))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 0.4)
                        )

                    // Email
                    TextField("Enter Email", text: $email)
                        .font(.system(size: 14))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 0.4)
                        )

                    // Password
                    SecureField("Enter Password", text: $password)
                        .font(.system(size: 14))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 0.4)
                        )

                    // Agreement
                    HStack {
                        Toggle(isOn: $agreePersonalData) {
                            Text("I agree to the processing of ")
                                .font(.system(size: 12))
                        }
                        .toggleStyle(CheckboxToggleStyle())

                        Text("Personal data")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(red: 0.1, green: 0.45, blue: 0.15))
                    }

                    // Sign Up Button
                    Button(action: {}) {
                        Text("Sign Up")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.2, green: 0.45, blue: 0.2),
                                        Color(red: 0.1, green: 0.3, blue: 0.1)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                    }

                    // Already Have Account
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 12))

                        NavigationLink(destination: LoginView()) {
                            Text("Sign In")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color(red: 0.1, green: 0.45, blue: 0.15))
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(24)
                .frame(maxWidth: 320)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 40)
                .padding(.top, 60)

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignUpView()
}
