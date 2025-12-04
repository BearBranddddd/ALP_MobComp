//
//  CustomTextField.swift
//  ALP_MobComp
//
//  Created by student on 28/11/25.
//

import SwiftUI

struct CustomTextField: View {
    var label: String
    var placeholder: String
    @Binding var text: String

        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)

                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            .padding(.horizontal)
        }
}
