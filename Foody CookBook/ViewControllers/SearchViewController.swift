//
//  SearchViewController.swift
//  Foody CookBook
//
//  Created by A10B6X9A on 06/04/21.
//  Copyright © 2021 none. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var recipies: RecipeModel?
    var favrtArray: [Meal]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: favKey) {
            favrtArray = try! PropertyListDecoder().decode([Meal].self, from: data)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backBtnAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favBtnAction(_ sender: Any)
    {
        
    }
    
    func getResults(key: String)
    {
        APIHandler.searchRecipe(key: key) { result in
            
            guard let result = result else { return }
            self.recipies = result
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text?.count ?? 0 > 0
        {
            self.getResults(key: searchBar.text ?? "")
        }
        else
        {
            self.recipies = nil
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipies?.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: RecipCell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipCell.self), for: indexPath)  as! RecipCell
        cell.selectionStyle = .none
        cell.imgView.sd_setImage(with: URL(string: self.recipies?.meals?[indexPath.row].strMealThumb ?? ""), placeholderImage: UIImage(named: "placeholder"))
        cell.nameLabel.text = self.recipies?.meals?[indexPath.row].strMeal
        if favrtArray?.contains(recipies!.meals![indexPath.row]) ?? false
        {
            cell.favBtn.setImage(UIImage(named: "filledHeart"), for: .normal)
        }
        else
        {
            cell.favBtn.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(markfavBtnAction(_:)), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let recipeObj = self.storyboard?.instantiateViewController(identifier: "RecipeViewController") as? RecipeViewController else { return }
        var recipe = RecipeModel()
        if let mealObj = recipies?.meals?[indexPath.row]
        {
            recipe.meals = [mealObj]
        }
        
        recipeObj.recipe = recipe
        self.navigationController?.pushViewController(recipeObj, animated: true)
    }
    
    @objc func markfavBtnAction(_ sender: UIButton)
    {
        guard let cell = tableView.cellForRow(at: IndexPath.init(row: sender.tag, section: 0)) as? RecipCell else { return }
        if favrtArray?.contains(recipies!.meals![sender.tag]) ?? false
        {
            favrtArray?.removeAll(where: { (obj) -> Bool in
                obj.idMeal == recipies?.meals![sender.tag].idMeal ?? ""
            })
            cell.favBtn.setImage(UIImage(named: "heart"), for: .normal)
        }
        else
        {
            favrtArray?.append(recipies!.meals![sender.tag])
            cell.favBtn.setImage(UIImage(named: "filledHeart"), for: .normal)
        }
        
        guard let arr = favrtArray else { return }
        if let data = try? PropertyListEncoder().encode(arr) {
            UserDefaults.standard.set(data, forKey: favKey)
        }
    }
}

class RecipCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var favBtn: UIButton!

}
