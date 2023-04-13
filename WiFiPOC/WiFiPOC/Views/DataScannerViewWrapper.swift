//
//  DataScannerViewWrapper.swift
//  WiFiPOC
//
//  Created by FSITL251 on 4/7/23.
//

import SwiftUI
import VisionKit

struct DataScannerViewWrapper: UIViewControllerRepresentable {
    var onDismiss: ((_ ssid: String, _ password: String) -> Void)?
    var vc: DataScannerViewController?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {

    }

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let dataScannerViewController = DataScannerViewController(
          recognizedDataTypes: [
            .barcode(symbologies: [.qr])
          ],
          isGuidanceEnabled: true,
          isHighlightingEnabled: true
        )

        dataScannerViewController.delegate = context.coordinator
        try? dataScannerViewController.startScanning()
//        self.vc = dataScannerViewController

        return dataScannerViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

    typealias UIViewControllerType = DataScannerViewController

    // MARK: - Coordinator
    class Coordinator: NSObject, DataScannerViewControllerDelegate {

        // MARK: Properties and initializer
        private let parent: DataScannerViewWrapper

        init(_ parent: DataScannerViewWrapper) {
            self.parent = parent
        }

        func dataScanner(
          _ dataScanner: DataScannerViewController,
          didAdd addedItems: [RecognizedItem],
          allItems: [RecognizedItem]
        ) {
//            debugPrint("dataScanner")
        }

        func dataScanner(
          _ dataScanner: DataScannerViewController,
          didUpdate updatedItems: [RecognizedItem],
          allItems: [RecognizedItem]
        ) {
//            debugPrint("dataScanner")
        }

        func dataScanner(
          _ dataScanner: DataScannerViewController,
          didRemove removedItems: [RecognizedItem],
          allItems: [RecognizedItem]
        ) {
//            debugPrint("dataScanner")
        }

        func dataScanner(
          _ dataScanner: DataScannerViewController,
          didTapOn item: RecognizedItem
        ) {
            
            switch item {
            case .barcode(let code):
                guard let urlString = code.payloadStringValue else { return }
                guard let url = URL(string: urlString) else { return }
                
                let components:NSURLComponents? = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
                
                var queryItems: [String : String] = [:]
                for item in components?.queryItems ?? [] {
                    queryItems[item.name] = item.value?.removingPercentEncoding
                }
                
                guard let ssid = queryItems["ssid"] else { return }
                guard let password = queryItems["password"] else { return }
                
                self.parent.onDismiss?(ssid, password)
            default:
                debugPrint("Unexpected item")
            }
        
            
            
        }
    }

}



struct DataScannerViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        DataScannerViewWrapper()
    }
}
