//
//  AppsTableViewController.swift
//  APPsRankingTableView
//
//  Created by Lee chanwen on 4/18/23.
//

import UIKit
import Kingfisher

class AppsTableViewController: UITableViewController {
    var items = [Results]()
    var feedCountry: String = ""
    var feedTitle: String = ""
    var feedURL: String = ""
    var feedURLString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            fetchItems()
        
    }


    func fetchItems() {
        // decode the JSON data from feedURLString
        let urlString = feedURLString!
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Using URLSeccion.shared.daataTask to "Get" data with URL
                if let data {
                    let decoder = JSONDecoder() // Set decoder type to JSON
                    do { // do decode process
                        let searchResponse = try decoder.decode(SearchResult.self, from: data)
                        self.items = searchResponse.feed.results
                        self.feedCountry = searchResponse.feed.country
                        self.feedTitle = searchResponse.feed.title
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }catch{
                        print(error) //show error alert
                    }
                }else{
                    // show error alert
                    }
                }.resume()
            }
        }
    
    @IBSegueAction func showAppData(_ coder: NSCoder) -> AppDetailViewController? {
        // Transfer data to next page
        guard let row = tableView.indexPathForSelectedRow?.row else{
            return nil
        }
        return AppDetailViewController(coder: coder, results: items[row])
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set row height of tableView Cell to 160 points
        return 160
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set Identifier to the resued Indentifier of tableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomerTableViewCell.self)", for: indexPath) as! CustomerTableViewCell
        let item = items[indexPath.row]
        // Configure the cell content
        cell.appNameLabel.text = "Country: \(feedCountry) \n Name:\(item.name)"
        cell.appKindLabel.text = "Kind: \(item.kind) \n Release Date: \(item.releaseDate ?? "NA")"
        cell.appImageView.contentMode = .scaleAspectFit
        cell.appImageView.kf.setImage(with: item.artworkUrl100)
        // Set Navigation controller title as "feedTitle"
        title = feedTitle
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
