//
//  HomeView.swift
//  WiFiPOC
//
//  Created by FSITL251 on 4/7/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Join a WiFi Network") {
                    JoinWiFiNetwork()
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
