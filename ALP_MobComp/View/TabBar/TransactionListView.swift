//
//  TransactionListView.swift
//  ALP_MobComp
//
//  Created by student on 28/11/25.
//

import SwiftUI

struct TransactionListView: View {
    @Environment(\.dismiss) private var dismiss  // Untuk tombol Back
    
    var body: some View {
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
        .overlay(alignment: .center) {
            Text("Transaction List")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.15, green: 0.45, blue: 0.25))
        }
        .padding(.horizontal)
        .padding(.vertical, 10)

        
        ScrollView {
            VStack(spacing: 12) {
                ForEach(projectTransactions) { Transaction in
                    TransactionRowView(transaction: Transaction)
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TransactionListView()
}
