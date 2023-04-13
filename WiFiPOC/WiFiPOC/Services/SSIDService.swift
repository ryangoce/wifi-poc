//
//  SSIDService.swift
//  WiFiPOC
//
//  Created by FSITL251 on 4/7/23.
//

import Foundation
import NetworkExtension

struct SSID: Identifiable, Codable {
    let id: String
    let name: String
}


struct SSIDService {
        
    func getSSIDs() async -> [SSID] {
        return await withCheckedContinuation { continuation in
            NEHotspotConfigurationManager.shared.getConfiguredSSIDs { (ssids) in
                continuation.resume(returning: ssids.map({
                    return SSID(id: $0, name: $0)
                }))
            }
        }
    }
    
}
