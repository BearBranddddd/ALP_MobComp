//
//  NavigationBar.swift
//  ALP_MobComp
//
//  Created by student on 27/11/25.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .frame(width: 80, height: 4)
                    .foregroundColor(.green)
                    .padding(.horizontal, 30)
                    .offset(x: linePosition)
                    .animation(.easeInOut(duration: 0.3), value: selectedTab)
            }
            
            HStack {
                NavItem(tab: .dashboard, selectedTab: $selectedTab)
                NavItem(tab: .project, selectedTab: $selectedTab)
                NavItem(tab: .report, selectedTab: $selectedTab)
                NavItem(tab: .settings, selectedTab: $selectedTab)
            }
            .offset(y:-10)
            .padding()
            .background(Color.white)
            .shadow(radius: 0.1)
            
            
        }
    }

    // Menentukan posisi garis berdasarkan tab yang dipilih
    private var linePosition: CGFloat {
        switch selectedTab {
        case .dashboard:
            return -140
        case .project:
            return -50
        case .report:
            return 45
        case .settings:
            return 140
        }
    }
}

struct NavItem: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(selectedTab == tab ? .green : .gray)
                Text(title)
                    .font(.caption)
                    .foregroundColor(selectedTab == tab ? .green : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    var icon: String {
        switch tab {
        case .dashboard: return "house"
        case .project: return "folder"
        case .report: return "doc.text"
        case .settings: return "gearshape"
        }
    }
    
    var title: String {
        switch tab {
        case .dashboard: return "Dashboard"
        case .project: return "Project"
        case .report: return "Report"
        case .settings: return "Settings"
        }
    }
}



#Preview {
//    NavigationBar()
}
