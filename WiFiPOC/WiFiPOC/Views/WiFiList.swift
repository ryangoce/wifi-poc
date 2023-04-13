//
//  WiFiList.swift
//  WiFiPOC
//
//  Created by FSITL251 on 4/7/23.
//

import SwiftUI
import NetworkExtension

struct WiFiList: View {
    @StateObject var vm = SSIDViewModel()
    
    var body: some View {
        List {
            ForEach(vm.ssids) { ssid in
                Text(ssid.name)
            }
        }
        .task {
            await vm.getSSIDs()
//            NEHotspotConfigurationManager.shared.getConfiguredSSIDs {
//            (ssidsArray) in
//                for ssid in ssidsArray {
//                    print(ssid)
//                }
//            }
        }
        
    }
}

struct WiFiList_Previews: PreviewProvider {
    static var previews: some View {
        WiFiList()
    }
}
