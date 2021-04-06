//
//  APIHandler.swift
//  Foody CookBook
//
//  Created by A10B6X9A on 06/04/21.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation

let randomRecipeURL = "https://www.themealdb.com/api/json/v1/1/random.php"
let searchRecipeURL = "https://www.themealdb.com/api/json/v1/1/search.php"
let favKey = "fav_recipes"

class APIHandler: NSObject {
    
    class func getRandomRecipe(completion: @escaping(RecipeModel?) -> Void)
    {
        let url = URL(string: randomRecipeURL)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
            guard let data = data else { return }
            print("The response is : ",String(data: data, encoding: .utf8)!)
            do {
            
                //create decodable object from data
                let decodedObject = try JSONDecoder().decode(RecipeModel.self, from: data)
                completion(decodedObject)
            } catch _ {
                
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    class func searchRecipe(key: String, completion: @escaping(RecipeModel?) -> Void)
    {
        let url = URL(string: "\(searchRecipeURL)?s=\(key)")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
            guard let data = data else { return }
            print("The response is : ",String(data: data, encoding: .utf8)!)
            do {
            
                //create decodable object from data
                let decodedObject = try JSONDecoder().decode(RecipeModel.self, from: data)
                completion(decodedObject)
            } catch _ {
                
                completion(nil)
            }
        }
        
        task.resume()
    }
}
