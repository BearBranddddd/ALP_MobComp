//
//  WelcomeView.swift
//  ALP_MobComp
//
//  Created by Bernardo Frederick Kowe on 26/11/25.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                // ===== BACKGROUND =====
                Image("welcome_bg") // pastikan asset sudah ada
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    
                    
                    
                    Spacer()
                    
                    // ===== CENTER TEXT =====
                    VStack(spacing: 10) {
                        Text("Welcome!")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Enter personal details to your\nemployee account")
                            .font(.system(size: 15))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    // ===== BOTTOM BUTTON BAR (STATIC) =====
                    HStack(spacing: 15) {
                        
                        // SIGN IN
                        NavigationLink(destination: LoginView()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                                
                                Text("Sign In")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color(hex: "5A8F5B"))
                            }
                        }
                        .frame(height: 50)
                        
                        // SIGN UP
                        NavigationLink(destination: SignUpView()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                                
                                Text("Sign Up")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color(hex: "5A8F5B"))
                            }
                        } .frame(height: 50)
                    } .padding()
                } .padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}



#Preview {
    WelcomeView()
}
