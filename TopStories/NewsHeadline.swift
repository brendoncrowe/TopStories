//
//  NewsHeadline.swift
//  TopStories
//
//  Created by Brendon Crowe on 1/2/23.
//

import Foundation

// top level JSON - HeadlinesData.self because top level JSON is a dictionary
struct HeadlinesData: Codable { // Codable allows objects to be decoded from JSON
    let results: [NewsHeadline] // "results" represents the JSON array of stories
}

struct NewsHeadline: Codable {
    let title: String
    let abstract: String
    let byline: String
}

extension HeadlinesData {
    
    // the purpose of getHeadlines() is to parse the "topStoriesScience.json" into an array of [NewsHeadline] objects
    static func getHeadlines() -> [NewsHeadline] {
        var headlines = [NewsHeadline]()
        
        // The app Bundle() allows access (read) to in-app resources, e.g mp3 file, mov, jpeg, or in the case of this app the topStoriesScience.json
        
        // URL refers to a file pathway, getting to a specific file destination
        
        // get the url to the intended resource, which is the topStoriesScience.json file
        guard let pathToData = Bundle.main.url(forResource: "topStoriesTechnology", withExtension: "json") else { fatalError("topStoriesTechnology.json file not found") }
        
        // get the data from the contents of the file url
        do {
            let data = try Data(contentsOf: pathToData) // if a method could throw an error, it must be marked with try
            
            
            // JSONDecoder decodes JSON into swift objects such as HeadlinesData
            let headlinesData = try JSONDecoder().decode(HeadlinesData.self, from: data)
            headlines = headlinesData.results // [NewsHeadline]
            
        } catch {
            fatalError("failed to load content \(error)")
        }
        return headlines
    }
}
