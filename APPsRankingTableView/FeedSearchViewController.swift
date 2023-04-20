//
//  FeedSearchViewController.swift
//  APPsRankingTableView
//
//  Created by Lee chanwen on 4/19/23.
//

import UIKit

class FeedSearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var showURLLabel: UILabel!
    @IBOutlet weak var mediaTypePicker: UIPickerView!
    @IBOutlet weak var storefrontPicker: UIPickerView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var feedTypePicker: UIPickerView!
    @IBOutlet weak var showURLButton: UIButton!
    
    var feedURLString: String = ""
    var currentTypes = [String]()
    var currentTypeCodes = [String]()
    var currentFeedCodes = [String]()
    var currentMedia: String?
    var currentStore: String?
    var currentType: String?
    var currentTypeCode: String?
    var currentFeedCode: String?
    
    let mediaOptions = ["Music", "Podcasts", "Apps", "Books"]
    let mediaURLs = ["music", "podcasts", "apps", "books"]
    let storeOptions = ["United States", "United Kingdom", "Taiwan", "Spain", "Japan", "Italy", "Greece", "Germany", "France", "Canada", "Australia"]
    let storeCodes = ["us", "gb", "tw", "es", "jp", "it", "gr", "de", "fr", "ca", "au"]
    let musicTypes = ["Albums","Music Videos","Songs"]
    let musicTypeCodes = ["albums","music-videos","songs"]
    let podcastsTypes = ["Podcasts","Podcast Episodes","Podcast Channels"]
    let podcastsTypeCodes = ["podcasts","podcast-episodes","podcast-channels"]
    let appsTypes = ["Apps"]
    let appsTypeCodes = ["apps"]
    let booksTypes = ["Books"]
    let booksTypeCodes = ["books"]
    let musicFeedCodes = ["most-played"]
    let podcastFeedCodes = ["top","top-subscriber"]
    let appsFeedCodes = ["top-free","top-paid"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaTypePicker.delegate = self
        mediaTypePicker.dataSource = self
        storefrontPicker.delegate = self
        storefrontPicker.dataSource = self
        typePicker.delegate = self
        typePicker.dataSource = self
        feedTypePicker.delegate = self
        feedTypePicker.dataSource = self
        feedTypePicker.isHidden = true
        currentTypes = musicTypes
        currentFeedCodes = musicFeedCodes
        currentMedia = mediaURLs[0]
        currentStore = storeCodes[0]
        currentTypeCode = musicTypeCodes[0]
        currentFeedCode = musicFeedCodes[0]
        
        showURLLabel.isHidden = true
        showURLButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    func updateCurrentTypes() {
            switch mediaOptions[mediaTypePicker.selectedRow(inComponent: 0)] {
            case "Music":
                currentTypes = musicTypes
                currentTypeCodes = musicTypeCodes
                currentFeedCode = musicFeedCodes[0]
                feedTypePicker.isHidden = true
            case "Podcasts":
                currentTypes = podcastsTypes
                currentTypeCodes = podcastsTypeCodes
                feedTypePicker.isHidden = false
                switch currentType {
                case "Podcasts":
                    currentFeedCodes = podcastFeedCodes
                case "Podcast Episodes":
                    currentFeedCodes = [podcastFeedCodes[0]]
                    currentFeedCode = podcastFeedCodes[0]
                case "Podcast Channels":
                    currentFeedCodes = [podcastFeedCodes[1]]
                    currentFeedCode = podcastFeedCodes[1]
                default:
                    currentFeedCodes = podcastFeedCodes
                    currentFeedCode = podcastFeedCodes[0]
                }
            case "Apps":
                currentTypes = appsTypes
                currentTypeCodes = appsTypeCodes
                feedTypePicker.isHidden = false
                currentFeedCodes = appsFeedCodes
            case "Books":
                currentTypes = booksTypes
                currentTypeCodes = booksTypeCodes
                feedTypePicker.isHidden = false
                currentFeedCodes = appsFeedCodes
            default:
                break
            }
            typePicker.reloadAllComponents()
        feedTypePicker.reloadAllComponents()
        currentType = currentTypes.first
        currentTypeCode = currentTypeCodes.first
        }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1  //Set the list number of PickerView
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == mediaTypePicker {
            return mediaOptions.count
        }else if pickerView == storefrontPicker{
            return storeOptions.count
        }else if pickerView == typePicker{
            return currentTypes.count
        }else if pickerView == feedTypePicker{
            return currentFeedCodes.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Set the titles to each PickerView
        if pickerView == mediaTypePicker {
            return mediaOptions[row]
        }else if pickerView == storefrontPicker{
            return storeOptions[row]
        }else if pickerView == typePicker{
            return currentTypes[row]
        }else if pickerView == feedTypePicker{
            return currentFeedCodes[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView{
        case mediaTypePicker:
            currentMedia = mediaURLs[row]
            updateCurrentTypes()
            updateCurrentFeedCode()
        case storefrontPicker:
            currentStore = storeCodes[row]
        case typePicker:
            currentType = currentTypes[row]
            currentTypeCode = currentTypeCodes[row]
            updateCurrentFeedCode()
        case feedTypePicker:
            currentFeedCode = currentFeedCodes[row]
        default:
            break
        }

    }
    
    func updateCurrentFeedCode(){
        if currentMedia == "music"{
            currentFeedCode = musicFeedCodes[0]
        }else if currentMedia == "apps"{
            currentFeedCode = appsFeedCodes[0]
        }else if currentMedia == "books"{
            currentFeedCode = appsFeedCodes[0]
        }else{
            
            switch podcastsTypes[typePicker.selectedRow(inComponent: 0)]{
            case "Podcasts":
                currentFeedCodes = podcastFeedCodes
                currentFeedCode = podcastFeedCodes[0]
            case "Podcast Episodes":
                currentFeedCodes = [podcastFeedCodes[0]]
                currentFeedCode = podcastFeedCodes[0]
            case "Podcast Channels":
                currentFeedCodes = [podcastFeedCodes[1]]
                currentFeedCode = podcastFeedCodes[1]
            default:
                currentFeedCodes = podcastFeedCodes
                currentFeedCode = podcastFeedCodes[0]
            }
        }
        feedTypePicker.reloadAllComponents()
    }
        
    @IBSegueAction func showSearchURL(_ coder: NSCoder) -> AppsTableViewController? {
        
        let controller = AppsTableViewController(coder: coder)
        var searchResult = ""
        if let media = currentMedia, let store = currentStore, let type = currentTypeCode, let feedCode = currentFeedCode{
            searchResult = "https://rss.applemarketingtools.com/api/v2/\(store)/\(media)/\(feedCode)/10/\(type).json"
        }
        feedURLString = searchResult
        controller?.feedURLString = feedURLString
        return controller
    }
    
    
    
    @IBAction func showSearchResultLabel(_ sender: Any) {
        
        var searchResult = ""
        if let media = currentMedia, let store = currentStore, let type = currentTypeCode, let feedCode = currentFeedCode{
            searchResult = "https://rss.applemarketingtools.com/api/v2/\(store)/\(media)/\(feedCode)/10/\(type).json"
        }
        feedURLString = searchResult
        print(feedURLString)
        showURLLabel.text = searchResult
            
        
    }
    
 //   var feedURL = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/10/apps.json"
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
