//
//  FeedSearchViewController.swift
//  APPsRankingTableView
//
//  Created by Lee chanwen on 4/19/23.
//

import UIKit

class FeedSearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Outlets for UI elements
    @IBOutlet weak var showURLLabel: UILabel!
    @IBOutlet weak var mediaTypePicker: UIPickerView!
    @IBOutlet weak var storefrontPicker: UIPickerView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var feedTypePicker: UIPickerView!
    @IBOutlet weak var showURLButton: UIButton!
    
    // Variables to store selected options and data
    var feedURLString: String = ""
    var currentTypes = [String]()
    var currentTypeCodes = [String]()
    var currentFeedCodes = [String]()
    var currentMedia: String?
    var currentStore: String?
    var currentType: String?
    var currentTypeCode: String?
    var currentFeedCode: String?
    
    // Data array for picker view options
    let mediaOptions = ["Music", "Podcasts", "Apps", "Books"]
    let mediaCodes = ["music", "podcasts", "apps", "books"]
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
        
        // Set delegate and data source for picker views
        mediaTypePicker.delegate = self
        mediaTypePicker.dataSource = self
        storefrontPicker.delegate = self
        storefrontPicker.dataSource = self
        typePicker.delegate = self
        typePicker.dataSource = self
        feedTypePicker.delegate = self
        feedTypePicker.dataSource = self
        feedTypePicker.isHidden = true
        
        // Set initial values and hide/show UI elements
        currentTypes = musicTypes
        currentTypeCodes = musicTypeCodes
        currentFeedCodes = musicFeedCodes
        currentMedia = mediaCodes[0]
        currentStore = storeCodes[0]
        currentTypeCode = musicTypeCodes[0]
        currentFeedCode = musicFeedCodes[0]
        
        showURLLabel.isHidden = true
        showURLButton.isHidden = true
        
    }
    
    
    // Update current types and feed codes base on selected media type
    func updateCurrentTypes() {
        // Using switch to set different type codes and feed codes
            switch mediaOptions[mediaTypePicker.selectedRow(inComponent: 0)] {
            case "Music":
                currentTypes = musicTypes
                currentTypeCodes = musicTypeCodes
                currentFeedCode = musicFeedCodes[0]
                // No need to show feed type of Music media and hide the feedTypePicker
                feedTypePicker.isHidden = true
            case "Podcasts":
                currentTypes = podcastsTypes
                currentTypeCodes = podcastsTypeCodes
                feedTypePicker.isHidden = false
                switch currentType {
                case "Podcasts":
                    currentFeedCodes = podcastFeedCodes
                case "Podcast Episodes":
                    // Set feed type of "Podcast Episodes" to only "top"
                    currentFeedCodes = [podcastFeedCodes[0]]
                    currentFeedCode = podcastFeedCodes[0]
                case "Podcast Channels":
                    // Set feed type of "Podcast Episodes" to only "top-subscriber"
                    currentFeedCodes = [podcastFeedCodes[1]]
                    currentFeedCode = podcastFeedCodes[1]
                default:
                    // Set default feed type code to "top"
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
            typePicker.reloadAllComponents() //reload typePicker View
        feedTypePicker.reloadAllComponents() //reload feedTypePicker View
        currentType = currentTypes.first // Set currentType to the 1st element of currentTypes array
        currentTypeCode = currentTypeCodes.first // Set currentType to the 1st element of currentTypeCodes array
        }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1  //Set the list number of PickerView
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //Set the row numbers of each PickerView
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
        // Using switch to set the action when the pickerView row selected
        switch pickerView{
        case mediaTypePicker:
            currentMedia = mediaCodes[row] // Set currentMedia to the selected "Media"
            updateCurrentTypes() // Set type to music types
            updateCurrentFeedCode() // Set feed type to music feed type
        case storefrontPicker:
            currentStore = storeCodes[row] // Set currentStore to the selected "Store"
        case typePicker:
            currentType = currentTypes[row] // Set currentType to the selected "Type"
            currentTypeCode = currentTypeCodes[row] // Set currentTypeCode to the slected type
            updateCurrentFeedCode() // Set feed types base on selected type
        case feedTypePicker:
            currentFeedCode = currentFeedCodes[row] // Set currentFeedCode to the selected feed type
        default:
            break
        }

    }
    
    func updateCurrentFeedCode(){
        // reflash and set feedPickerView
        if currentMedia == "music"{
            currentFeedCode = musicFeedCodes[0]
        }else if currentMedia == "apps"{
            currentFeedCode = appsFeedCodes[0]
        }else if currentMedia == "books"{
            currentFeedCode = appsFeedCodes[0]
        }else{
            // if media type is "Podcasts" and the then using switch to set different "Type" of "Podcasts"
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
        // Using IBSegueAction to set the transfer data to next page
        let controller = AppsTableViewController(coder: coder)
        var searchResult = ""
        if let media = currentMedia, let store = currentStore, let type = currentTypeCode, let feedCode = currentFeedCode{
            searchResult = "https://rss.applemarketingtools.com/api/v2/\(store)/\(media)/\(feedCode)/10/\(type).json"
            // Feed search URL format: https://rss.applemarketingtools.com/api/v2/+"storeCode"+/+"mediaCode"+/+"feedCode"+/+"10" or "25"+/+"typeCode"+.json
        }
        controller?.feedURLString = searchResult
        return controller
    }
    
    
    
    @IBAction func showSearchResultLabel(_ sender: Any) {
        // Debug test: check the generated URL string
        var searchResult = ""
        if let media = currentMedia, let store = currentStore, let type = currentTypeCode, let feedCode = currentFeedCode{
            searchResult = "https://rss.applemarketingtools.com/api/v2/\(store)/\(media)/\(feedCode)/10/\(type).json"
        }
        feedURLString = searchResult
        print(feedURLString)
        showURLLabel.text = searchResult
            
        
    }
    
//    ChatGPT: 這個程式簡單易懂，功能也很明確。以下是一些評分和建議：
//
//    評分：
//
//    功能完成度：4/5
//    程式碼品質：3/5
//    可讀性：4/5
//    建議：
//    在程式碼上更加注重命名規範和一致性，例如使用較具描述性的名稱來命名變數和函數。
//    可以更好地組織代碼，例如將對應的代碼放在一起，減少重複的代碼，並且將功能相似的代碼抽象成更通用的函數。
//    在使用 switch 語句時，可以考慮使用列舉類型，這樣更容易管理代碼和避免出現拼錯字的情況。
//    在註釋上注明代碼的意圖，更好地幫助其他人理解和閱讀代碼
    
    
}
