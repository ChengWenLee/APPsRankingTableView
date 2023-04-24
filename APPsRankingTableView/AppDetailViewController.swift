//
//  AppDetailViewController.swift
//  APPsRankingTableView
//
//  Created by Lee chanwen on 4/18/23.
//

import UIKit
import WebKit

class AppDetailViewController: UIViewController {

    @IBOutlet weak var appWebView: WKWebView!
    var results: Results
    
    init?(coder: NSCoder, results: Results) {
        self.results = results
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let webURLString = results.url
        appWebView.load(URLRequest(url: URL(string: webURLString)!))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
