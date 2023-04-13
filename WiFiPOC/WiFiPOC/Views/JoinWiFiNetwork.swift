//
//  JoinWiFiNetwork.swift
//  WiFiPOC
//
//  Created by FSITL251 on 4/7/23.
//

import SwiftUI
import NetworkExtension

struct JoinWiFiNetwork: View {
    @State private var ssid = ""
    @State private var password = ""
    @State var showModal = false
    @State private var showingConnectedAlert = false
    
    private func connectToWifi(ssid: String, password: String) {
        // TODO: move to a ViewModel and utilize an MVVM Pattern
        let config = NEHotspotConfiguration(ssid: ssid, passphrase: password, isWEP: false)
        
        debugPrint("SSID \(ssid); Password:\(password)")
        config.joinOnce = true
        
        NEHotspotConfigurationManager.shared.apply(config) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                print(String(format:"Successfully connected to the Wi-Fi %@",ssid))
                
                self.showingConnectedAlert.toggle()
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 28) {
            VStack(alignment: .leading, spacing: 11) {
                Text("SSID")
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(.secondary)
                    .frame(height: 15, alignment: .leading)
                
                TextField("", text: $ssid)
                    .font(.system(size: 17, weight: .thin))
                    .foregroundColor(.primary)
                    .frame(height: 44)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(4.0)
            }
            
            VStack(alignment: .leading, spacing: 11) {
                Text("Password")
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(.secondary)
                    .frame(height: 15, alignment: .leading)
                
                SecureField("", text: $password)
                    .font(.system(size: 17, weight: .thin))
                    .foregroundColor(.primary)
                    .frame(height: 44)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(4.0)
            }
            
            Button {
                connectToWifi(ssid: ssid, password: password)
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .frame(width: 215, height: 44, alignment: .center)
            }
            .background(.blue)
            .cornerRadius(4)
            .padding(.top, 36)
            
            
            Button {
                showModal.toggle()
            } label: {
                Text("Scan QR Code")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .frame(width: 215, height: 44, alignment: .center)
            }
            .background(.blue)
            .cornerRadius(4)
            
            Spacer()
        }
        .padding()
        .background(.secondary.opacity(0.1))
        .navigationBarTitle("Enter WiFi Details", displayMode: .inline)
        .alert("Connected successfully to the Wifi Network", isPresented: $showingConnectedAlert) {
            Button("OK", role: .cancel) { }
        }
        .sheet(isPresented: $showModal, content: {
            DataScannerViewWrapper { (ssid, password) in
                print("got ssid and password from scanner", ssid, password)
                
                connectToWifi(ssid: ssid, password: password)
                showModal.toggle()
            }
        
        })
    }
}

struct JoinWiFiNetwork_Previews: PreviewProvider {
    static var previews: some View {
        JoinWiFiNetwork()
    }
}
