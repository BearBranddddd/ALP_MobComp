//
//  LoginView.swift
//  ALP_MobComp
//
//  Created by Bernardo Frederick Kowe on 26/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    
    var body: some View {
        ZStack {
            // Background abu muda
            Color(hex: "F6F8FA")
                .ignoresSafeArea()
            Spacer()
            // Shape gradient hijau
            VStack {
                BottomRoundedRectangle(radius: 150)
                    .frame(width: 510, height: 460)
                    .padding(.bottom, 520)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop(color: Color(hex: "85BA83"), location: 0.0),
                                Gradient.Stop(color: Color(hex: "3D7D3B"), location: 0.50),
                                Gradient.Stop(color: Color(hex: "266524"), location: 0.75),
                                Gradient.Stop(color: Color(hex: "154A13"), location: 0.88),
                                Gradient.Stop(color: Color(hex: "000000"), location: 1.0),
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
                Text("Welcome Back!")
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
                    
                    // Email
                    TextField("Email", text: $email)
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
                    SecureField("Password", text: $password)
                        .font(.system(size: 14))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 0.4)
                        )
                    
                    // Remember + Forgot
                    HStack {
                        Toggle(isOn: $rememberMe) {
                            Text("Remember me")
                                .font(.system(size: 12))
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        Spacer()
                        
                        Button("Forgot Password ?") {}
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(red: 0.1, green: 0.45, blue: 0.15))
                    }
                    .padding(.horizontal, 4)
                    
                    // Sign In Button
                    Button(action: {}) {
                        Text("Sign In")
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
                    
                    // Sign Up
                    HStack {
                        Text("Don’t have an account?")
                            .font(.system(size: 12))
                        NavigationLink(destination: SignUpView()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                                
                                Text("Sign Up")
                                    .foregroundColor(Color(hex: "5A8F5B"))
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(Color(red: 0.1, green: 0.45, blue: 0.15))
                            }
                        } .frame(height: 50)
                        Button("Sign Up") {}
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(red: 0.1, green: 0.45, blue: 0.15))
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
        .navigationBarBackButtonHidden(true)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        }
        .foregroundColor(.black)
    }
}

// Shape Rounded Bawah
struct BottomRoundedRectangle: Shape {
    var radius: CGFloat = 200
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let bl: CGFloat = radius
            let br: CGFloat = radius
            
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - br))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - br, y: rect.maxY),
                control: CGPoint(x: rect.maxX, y: rect.maxY)
            )
            
            path.addLine(to: CGPoint(x: rect.minX + bl, y: rect.maxY))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY - bl),
                control: CGPoint(x: rect.minX, y: rect.maxY)
            )
            
            path.closeSubpath()
        }
    }
}

// HEX Color
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255

        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}

#Preview {
    LoginView()
}
