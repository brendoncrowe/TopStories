//
//  NewsHeadline.swift
//  TopStories
//
//  Created by Brendon Crowe on 1/2/23.
//

import Foundation

// top level JSON - HeadlinesData.self because top level JSON is a dictionary
struct HeadlinesData: Codable {
    let results: [NewsHeadline] // "results" represents the JSON array of stories
}

struct NewsHeadline: Codable {
    let title: String
    let abstract: String
}
