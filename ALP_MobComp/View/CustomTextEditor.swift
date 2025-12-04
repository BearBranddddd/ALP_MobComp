//
//  CustomTextEditor.swift
//  ALP_MobComp
//
//  Created by student on 28/11/25.
//

import SwiftUI

struct CustomTextEditor: View {
    var title: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)

            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(.leading, 6)
                        .padding(.top, 10)
                }

                TextEditor(text: $text)
                    .frame(height: 120)
                    .padding(4)
            }
            .background(Color.gray.opacity(0.2))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .cornerRadius(4)
        }
        .padding(.horizontal)
    }
}
