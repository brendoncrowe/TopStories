//
//  ImageClient.swift
//  TopStories
//
//  Created by Brendon Crowe on 1/4/23.
//

import UIKit

struct ImageClient {
    
    // the task of this function takes in a url and uses a completion handler to capture processed image from the url source e.g "https://...jpg"
    // an image cannot be returned by this function. Why? Because URLSession performs an asynchronous network call, which means the call relies on the network and is done in the background; not performed instantaneously.
    // The function gets completed immediately, but the completion handler is delayed for however long (Think about login loading)
    // @escaping is used because the function returns before the closure, i.e escaping closure
    // the closure syntax () -> () takes in no parameters and returns nothing, aka Void
    // Result is an enum having two 'result': success or failure, with success coming first 
    
    static func fetchImage(for urlString: String, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        
        // 1. validate that the url string is a valid url
        
        guard let url = URL(string: urlString) else { print("bad url \(urlString)")
            return
        }
        
        // 2. create a data task (go to network and fetch data using url) using the URLSession() class
        // dataTask invokes network reuest
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // check if an error exists
            if let error = error {
                print("error: \(error)")
            }
            
            
            if let data = data {
                // if there is data, data is fetched, use data to create an image
                // UIImage can take in a data object and return an image
                let image = UIImage(data: data)
                
                // use the completion handler to capture the results of image
                completion(.success(image))
            }
        }
        dataTask.resume() // resume the task if URLSession is suspended, which it is by default
    }
}
