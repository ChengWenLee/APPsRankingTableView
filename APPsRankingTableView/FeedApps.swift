//
//  FeedApps.swift
//  APPsRankingTableView
//
//  Created by Lee chanwen on 4/18/23.
//

import Foundation

struct SearchResult: Codable{
    let feed: Feed
}


struct Feed: Codable{
    let title: String
    let country: String
    let results: [Results]
}

struct Results: Codable{
    let artistName: String?
    let name: String
    let releaseDate: String?
    let kind: String
    let artworkUrl100: URL
    let url: String
}

