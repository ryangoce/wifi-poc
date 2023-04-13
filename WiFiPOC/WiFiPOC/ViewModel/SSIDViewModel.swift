//
//  SSIDViewModel.swift
//  WiFiPOC
//
//  Created by FSITL251 on 4/7/23.
//

import Foundation

@MainActor
class SSIDViewModel: ObservableObject {
    
    @Published var ssids: [SSID] = []
    
    func getSSIDs() async {
        self.ssids = await SSIDService().getSSIDs()
    }
}
