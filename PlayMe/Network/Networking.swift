//
//  ApiHelper.swift
//  BeanStalk
//
//  Created by myu on 21/09/20.
//  Copyright © 2020 myu. All rights reserved.
//

import Foundation

//MARK: - Path to fetch songs list
let songsPath = "https://itunes.apple.com/search"

//MARK: - Generic struct for decoding
struct APIResults<T: Decodable>: Decodable {
    
    let value: T
    
    private enum CodingKeys: String, CodingKey {
        case value = "results"
    }
}

internal typealias CompletionHandler<T> = (_ result: T?, _ error: Swift.Error?) -> Void

class API {
    
    private static func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        request.httpMethod = method

        let session = URLSession(configuration: URLSessionConfiguration.default)

        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                completion(true, data)
            }
            else
            {
                completion(false, nil)
            }
        }.resume()
    }

    private static func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    private static func clientURLRequest(path: String, params: [String: String]? = nil) -> NSMutableURLRequest {
        
        var url = URLComponents(string: path)!

        for (key, val) in params ?? [:]
        {
            url.queryItems = [
                URLQueryItem(name: key, value: val)
            ]
        }
        
        let request = NSMutableURLRequest(url: url.url!)
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                paramString += "\(String(describing: escapedKey))=\(String(describing: escapedValue))&"
            }

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
    
    //MARK: - Get Songs APi Request
    //Request param: - term
    //Response param: - [Song]
    static func getSongs(completion: @escaping CompletionHandler<[Song]>)
    {
        self.get(request: clientURLRequest(path: songsPath, params: ["term": "Michael jackson"])) { (success, result) in
            
            guard let result = result else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(APIResults<[Song]>.self, from: result)
                print(data)
                completion(data.value, nil)
            } catch _ {
                completion(nil, nil)
            }
        }
    }
    
    private static func printRequest(_ response: NSMutableURLRequest) {
        print(
            """
            \n
            API Request:-
            --------------
            URL         : \(response.url?.absoluteString ?? "")
            Headers     : \(response.allHTTPHeaderFields ?? [:])
            HTTP Method : \(response.httpMethod)
            Parameters  : \(String(bytes: response.httpBody ?? Data(), encoding: .utf8) ?? "")
            
            \n\n
            """
        )
    }
}
