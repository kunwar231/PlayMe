//
//  CategoryViewController.swift
//  Foody CookBook
//
//  Created by A10B6X9A on 06/04/21.
//  Copyright © 2021 none. All rights reserved.
//

import UIKit

class FavViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var favrtArray: [Meal]? = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: favKey) {
            favrtArray = try! PropertyListDecoder().decode([Meal].self, from: data)
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backBtnAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FavViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favrtArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: FavCell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavCell.self), for: indexPath)  as! FavCell
        cell.selectionStyle = .none
        cell.imgView.sd_setImage(with: URL(string: self.favrtArray?[indexPath.row].strMealThumb ?? ""), placeholderImage: UIImage(named: "placeholder"))
        cell.nameLabel.text = self.favrtArray?[indexPath.row].strMeal
        if favrtArray?.contains(favrtArray![indexPath.row]) ?? false
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
        if let mealObj = favrtArray?[indexPath.row]
        {
            recipe.meals = [mealObj]
        }
        
        recipeObj.recipe = recipe
        self.navigationController?.pushViewController(recipeObj, animated: true)
    }
    
    @objc func markfavBtnAction(_ sender: UIButton)
    {
        guard let cell = tableView.cellForRow(at: IndexPath.init(row: sender.tag, section: 0)) as? RecipCell else { return }
        if favrtArray?.contains(favrtArray![sender.tag]) ?? false
        {
            favrtArray?.removeAll(where: { (obj) -> Bool in
                obj.idMeal == favrtArray![sender.tag].idMeal ?? ""
            })
            cell.favBtn.setImage(UIImage(named: "heart"), for: .normal)
        }
        else
        {
            favrtArray?.append(favrtArray![sender.tag])
            cell.favBtn.setImage(UIImage(named: "filledHeart"), for: .normal)
        }
        
        self.tableView.reloadData()
        guard let arr = favrtArray else { return }
        if let data = try? PropertyListEncoder().encode(arr) {
            UserDefaults.standard.set(data, forKey: favKey)
        }
    }
}

class FavCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var favBtn: UIButton!

}
