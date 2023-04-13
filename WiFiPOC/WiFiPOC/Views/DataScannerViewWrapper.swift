//
//  DataScannerView.swift
//  WiFiPOC
//
//  Created by FSITL251 on 4/7/23.
//

import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        <#code#>
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        
        let scanner = DataScannerViewController(
          recognizedDataTypes: [
            .barcode(
              symbologies: [
                .ean13
              ]),
            .text(languages: ["en"])
          ],
          isGuidanceEnabled: true,
          isHighlightingEnabled: false
        )
        
        scanner.delegate = context.coordinator
        
        let tvc = UITableViewController()
                tvc.tableView.delegate = context.coordinator
                tvc.tableView.dataSource = context.coordinator

                tvc.tableView.rowHeight = UITableView.automaticDimension
                tvc.tableView.estimatedRowHeight = UITableView.automaticDimension
                tvc.tableView.separatorStyle = .none
                tvc.tableView.allowsSelection = false
                tvc.tableView.allowsSelectionDuringEditing = true
                tvc.tableView.allowsMultipleSelectionDuringEditing = true

                self.vc = tvc
                return tvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        <#code#>
    }
    
    func makeCoordinator() -> () {
        <#code#>
    }
    
    typealias UIViewControllerType = DataScannerViewController
    
    // MARK: - Coordinator
    class Coordinator: NSObject, DataScannerViewControllerDelegate {

        // MARK: Properties and initializer
        private let parent: CommentsTableViewWrapper

        init(_ parent: CommentsTableViewWrapper) {
            self.parent = parent
        }

        // MARK: UITableViewDelegate and DataSource methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return parent.comments.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print(indexPath)

            return createCommentCell(indexPath, tableView)
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
        }

        var cellHeights = [IndexPath: CGFloat]()

        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cellHeights[indexPath] = cell.frame.size.height
        }

        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return cellHeights[indexPath] ?? UITableView.automaticDimension
        }

        // MARK: - Private helpers
        fileprivate func createCommentCell(_ indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
            let comment = parent.comments[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "DebugCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "DebugCell")

            cell.textLabel!.numberOfLines = 0
            cell.textLabel!.lineBreakMode = .byCharWrapping
            cell.textLabel!.text = comment
            return cell
        }
    }
    
}



struct DataScannerView_Previews: PreviewProvider {
    static var previews: some View {
        DataScannerView()
    }
}
