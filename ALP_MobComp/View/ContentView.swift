//
//  ContentView.swift
//  ALP_MobComp
//
//  Created by Bernardo Frederick Kowe on 26/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .dashboard
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .dashboard:
                DashboardView()
            case .project:
                ProjectView()
            case .report:
                ReportView()
            case .settings:
                SettingsView()
            }
            Spacer()
            NavigationBar(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

enum Tab {
    case dashboard
    case project
    case report
    case settings
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
