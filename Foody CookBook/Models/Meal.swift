//
//  Meal.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 6, 2021

import Foundation

import Foundation

struct RecipeModel : Codable {

        var meals : [Meal]?
}

struct Meal : Codable, Equatable {

        let idMeal : String?
        let strArea : String?
        let strCategory : String?
        let strImageSource : String?
        let strIngredient1 : String?
        let strIngredient10 : String?
        let strIngredient11 : String?
        let strIngredient12 : String?
        let strIngredient13 : String?
        let strIngredient14 : String?
        let strIngredient15 : String?
        let strIngredient16 : String?
        let strIngredient17 : String?
        let strIngredient18 : String?
        let strIngredient19 : String?
        let strIngredient2 : String?
        let strIngredient20 : String?
        let strIngredient3 : String?
        let strIngredient4 : String?
        let strIngredient5 : String?
        let strIngredient6 : String?
        let strIngredient7 : String?
        let strIngredient8 : String?
        let strIngredient9 : String?
        let strInstructions : String?
        let strMeal : String?
        let strMealThumb : String?
        let strMeasure1 : String?
        let strMeasure10 : String?
        let strMeasure11 : String?
        let strMeasure12 : String?
        let strMeasure13 : String?
        let strMeasure14 : String?
        let strMeasure15 : String?
        let strMeasure16 : String?
        let strMeasure17 : String?
        let strMeasure18 : String?
        let strMeasure19 : String?
        let strMeasure2 : String?
        let strMeasure20 : String?
        let strMeasure3 : String?
        let strMeasure4 : String?
        let strMeasure5 : String?
        let strMeasure6 : String?
        let strMeasure7 : String?
        let strMeasure8 : String?
        let strMeasure9 : String?
        let strSource : String?

        enum CodingKeys: String, CodingKey {
                case idMeal = "idMeal"
                case strArea = "strArea"
                case strCategory = "strCategory"
                case strImageSource = "strImageSource"
                case strIngredient1 = "strIngredient1"
                case strIngredient10 = "strIngredient10"
                case strIngredient11 = "strIngredient11"
                case strIngredient12 = "strIngredient12"
                case strIngredient13 = "strIngredient13"
                case strIngredient14 = "strIngredient14"
                case strIngredient15 = "strIngredient15"
                case strIngredient16 = "strIngredient16"
                case strIngredient17 = "strIngredient17"
                case strIngredient18 = "strIngredient18"
                case strIngredient19 = "strIngredient19"
                case strIngredient2 = "strIngredient2"
                case strIngredient20 = "strIngredient20"
                case strIngredient3 = "strIngredient3"
                case strIngredient4 = "strIngredient4"
                case strIngredient5 = "strIngredient5"
                case strIngredient6 = "strIngredient6"
                case strIngredient7 = "strIngredient7"
                case strIngredient8 = "strIngredient8"
                case strIngredient9 = "strIngredient9"
                case strInstructions = "strInstructions"
                case strMeal = "strMeal"
                case strMealThumb = "strMealThumb"
                case strMeasure1 = "strMeasure1"
                case strMeasure10 = "strMeasure10"
                case strMeasure11 = "strMeasure11"
                case strMeasure12 = "strMeasure12"
                case strMeasure13 = "strMeasure13"
                case strMeasure14 = "strMeasure14"
                case strMeasure15 = "strMeasure15"
                case strMeasure16 = "strMeasure16"
                case strMeasure17 = "strMeasure17"
                case strMeasure18 = "strMeasure18"
                case strMeasure19 = "strMeasure19"
                case strMeasure2 = "strMeasure2"
                case strMeasure20 = "strMeasure20"
                case strMeasure3 = "strMeasure3"
                case strMeasure4 = "strMeasure4"
                case strMeasure5 = "strMeasure5"
                case strMeasure6 = "strMeasure6"
                case strMeasure7 = "strMeasure7"
                case strMeasure8 = "strMeasure8"
                case strMeasure9 = "strMeasure9"
                case strSource = "strSource"
        }
    
    static func ==(lhs: Meal, rhs: Meal) -> Bool {
        return lhs.idMeal == rhs.idMeal
    }


}
