//
//  SongsListVC.swift
//  PlayMe
//
//  Created by myu on 21/10/20.
//

import UIKit

class SongsListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var activityIndicator: MKActivityIndicator = {
        
        let activity = MKActivityIndicator(frame: CGRect(x: (self.view.frame.size.width/2)-30, y: (self.view.frame.size.height/2)-30, width: 60, height: 60))
        self.view.addSubview(activity)
        return activity
        
    }()
    
    var songs: [Song]?
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0x2F81C7)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.title = "SONGS"
        getSongs()
    }
    
    //MARK: - Fetch Songs List
    func getSongs()
    {
        activityIndicator.startAnimating()
        API.getSongs() { (result, error) in
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                guard let result = result else {
                    return
                }
                
                self.songs = result
                self.tableView.reloadData()
            }
        }
    }
}


extension SongsListVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        cell.selectionStyle = .none
        
        let song = songs?[indexPath.row]
        
        cell.imgView.imageFromServerURL(urlString:  song?.artworkUrl100 ?? "", PlaceHolderImage: UIImage(named: "placeholder")!)
        cell.nameLabel.text = song?.trackName
        cell.ArtistLabel.text = song?.artistName
        
        if let milli = song?.trackTimeMillis
        {
            let date = Date(timeIntervalSinceNow: Double(milli) / 1000)
            let formatter = DateFormatter()
            formatter.dateFormat = "mm:ss"
            
            cell.durationLabel.text = formatter.string(from: date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SongDetailsVC") as! SongDetailsVC
        vc.song = songs?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class SongCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ArtistLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.layer.cornerRadius = 5
    }
}
