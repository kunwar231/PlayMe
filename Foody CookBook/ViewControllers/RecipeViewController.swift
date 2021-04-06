//
//  ViewController.swift
//  Foody CookBook
//
//  Created by A10B6X9A on 06/04/21.
//  Copyright © 2021 none. All rights reserved.
//

import UIKit
import SDWebImage
import ANLoader

class RecipeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!

    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    var recipe: RecipeModel?
    var favrtArray: [Meal]? = []
    
    var type: Int = 0//0 = random, 1 = specific
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: favKey) {
            favrtArray = try! PropertyListDecoder().decode([Meal].self, from: data)
        }
        
        if type == 0
        {
            backBtnWidth.constant = 0
            getRecipe()
        }
        else
        {
            backBtnWidth.constant = 60
            if favrtArray?.contains(recipe!.meals!.first!) ?? false
            {
                favButton.setImage(UIImage(named: "filledHeart"), for: .normal)
            }
            else
            {
                favButton.setImage(UIImage(named: "heart"), for: .normal)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func searchBtnAction(_ sender: Any)
    {
        guard let searchObj = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        self.navigationController?.pushViewController(searchObj, animated: true)
    }
    
    @IBAction func FavBtnAction(_ sender: Any)
    {
        guard let favObj = self.storyboard?.instantiateViewController(identifier: "FavViewController") as? FavViewController else { return }
        self.navigationController?.pushViewController(favObj, animated: true)
    }
    
    @IBAction func markFavBtnAction(_ sender: Any)
    {
        if favrtArray?.contains(recipe!.meals!.first!) ?? false
        {
            favrtArray?.removeAll(where: { (obj) -> Bool in
                obj.idMeal == recipe?.meals?.first?.idMeal ?? ""
            })
//            favrtArray.remove(recipe!.meals!.first!)
            favButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        else
        {
            favrtArray?.append(recipe!.meals!.first!)
            favButton.setImage(UIImage(named: "filledHeart"), for: .normal)
        }
        
        guard let arr = favrtArray else { return }
        if let data = try? PropertyListEncoder().encode(arr) {
            UserDefaults.standard.set(data, forKey: favKey)
        }
    }
    @IBAction func backBtnAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getRecipe()
    {
        ANLoader.showLoading("", disableUI: true)
        APIHandler.getRandomRecipe() { result in
            DispatchQueue.main.async{
                ANLoader.hide()
            }
            guard let result = result else { return }
            self.recipe = result
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
                self.imgView.sd_setImage(with: URL(string: self.recipe?.meals?.first?.strMealThumb ?? ""), placeholderImage: UIImage(named: "placeholder"))
                self.nameLabel.text = self.recipe?.meals?.first?.strMeal
                
                if self.favrtArray?.contains(self.recipe!.meals!.first!) ?? false
                {
                    self.favButton.setImage(UIImage(named: "filledHeart"), for: .normal)
                }
                else
                {
                    self.favButton.setImage(UIImage(named: "heart"), for: .normal)
                }
            }
        }
        
    }
}

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: IngreCell = tableView.dequeueReusableCell(withIdentifier: String(describing: IngreCell.self), for: indexPath)  as! IngreCell
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient1 ?? "") \(recipe?.meals?.first?.strMeasure1 ?? "")"
            
            break
        case 1:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient2 ?? "") \(recipe?.meals?.first?.strMeasure2 ?? "")"

            break
        case 2:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient3 ?? "") \(recipe?.meals?.first?.strMeasure3 ?? "")"

            break
        case 3:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient4 ?? "") \(recipe?.meals?.first?.strMeasure4 ?? "")"

            break
        case 4:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient5 ?? "") \(recipe?.meals?.first?.strMeasure5 ?? "")"

            break
        case 5:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient6 ?? "") \(recipe?.meals?.first?.strMeasure6 ?? "")"

            break
        case 6:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient7 ?? "") \(recipe?.meals?.first?.strMeasure7 ?? "")"

            break
        case 7:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient8 ?? "") \(recipe?.meals?.first?.strMeasure8 ?? "")"

            break
        case 8:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient9 ?? "") \(recipe?.meals?.first?.strMeasure9 ?? "")"

            break
        case 9:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient10 ?? "") \(recipe?.meals?.first?.strMeasure10 ?? "")"

            break
        case 10:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient11 ?? "") \(recipe?.meals?.first?.strMeasure11 ?? "")"

            break
        case 11:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient12 ?? "") \(recipe?.meals?.first?.strMeasure12 ?? "")"

            break
        case 12:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient13 ?? "") \(recipe?.meals?.first?.strMeasure13 ?? "")"

            break
        case 13:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient14 ?? "") \(recipe?.meals?.first?.strMeasure14 ?? "")"

            break
        case 14:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient15 ?? "") \(recipe?.meals?.first?.strMeasure15 ?? "")"

            break
        case 15:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient16 ?? "") \(recipe?.meals?.first?.strMeasure16 ?? "")"

            break
        case 16:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient17 ?? "") \(recipe?.meals?.first?.strMeasure17 ?? "")"

            break
        case 17:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient18 ?? "") \(recipe?.meals?.first?.strMeasure18 ?? "")"

            break
        case 18:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient19 ?? "") \(recipe?.meals?.first?.strMeasure19 ?? "")"

            break
        case 19:
            cell.nameLabel.text = "\(recipe?.meals?.first?.strIngredient20 ?? "") \(recipe?.meals?.first?.strMeasure20 ?? "")"

            break
            
        default:
            break
        }
        
        return cell
    }
}

class IngreCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

}
