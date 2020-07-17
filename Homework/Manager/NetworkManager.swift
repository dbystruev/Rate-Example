//
//  NetworkManager.swift
//  Homework
//
//  Created by Denis Bystruev on 17.07.2020.
//  Copyright © 2020 Denis Bystruev. All rights reserved.
//

import Foundation

/// Network manager contains methods to get data from rate servers
class NetworkManager {
    static let defaultCurrency = "USD";
    static let defaultURL = URL(string: "https://api.latoken.com/api/v2/rate")!
    
    static var shared: NetworkManager = NetworkManager()
    
    let url: URL
    
    private init(url: URL? = nil) {
        self.url = url ?? NetworkManager.defaultURL
    }
    
    /// Gets current rate to USD
    /// - Parameters:
    ///   - tag: currency tag
    ///   - completion: (Double) -> () function which will return currency rate as double
    func getRate(tag: String, completion: @escaping (Double?) -> (Void)) {
        let url = self.url.appendingPathComponent(tag).appendingPathComponent(NetworkManager.defaultCurrency)
        debugPrint(#line, #function, "url = \(url)")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                debugPrint(#line, #function, "Data is nil from url \(url)")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            
            guard let rate = try? decoder.decode(Rate.self, from: data) else {
                debugPrint(#line, #function, "Couldn't decode rate data from \(data)")
                completion(nil)
                return
            }
            
            completion(rate.value)
        }
        task.resume()
    }
}
