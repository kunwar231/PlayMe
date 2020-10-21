//
//  SongDetailsVC.swift
//  PlayMe
//
//  Created by myu on 21/10/20.
//

import UIKit

class SongDetailsVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ArtistLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    var song: Song!
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imgView.imageFromServerURL(urlString:  song.artworkUrl100 ?? "", PlaceHolderImage: UIImage(named: "placeholder")!)

        let titleAttribute = [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x000000), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        let bodyAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x000000), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        
        let nameStr: NSMutableAttributedString = NSMutableAttributedString(string: "")
        nameStr.append(NSMutableAttributedString(string: "NAME: ", attributes: titleAttribute))
        nameStr.append(NSMutableAttributedString(string: song.trackName ?? "", attributes: bodyAttributes))

        let artistStr: NSMutableAttributedString = NSMutableAttributedString(string: "")
        artistStr.append(NSMutableAttributedString(string: "ARTIST: ", attributes: titleAttribute))
        artistStr.append(NSMutableAttributedString(string: song.trackName ?? "", attributes: bodyAttributes))

        let genreStr: NSMutableAttributedString = NSMutableAttributedString(string: "")
        genreStr.append(NSMutableAttributedString(string: "GENRE: ", attributes: titleAttribute))
        genreStr.append(NSMutableAttributedString(string: song.primaryGenreName ?? "", attributes: bodyAttributes))

        self.nameLabel.attributedText = nameStr
        self.ArtistLabel.attributedText = artistStr
        self.genreLabel.attributedText = genreStr

        
        if let milli = song.trackTimeMillis
        {
            let date = Date(timeIntervalSinceNow: Double(milli) / 1000)
            let formatter = DateFormatter()
            formatter.dateFormat = "mm:ss"
            
            let durStr: NSMutableAttributedString = NSMutableAttributedString(string: "")
            durStr.append(NSMutableAttributedString(string: "Duration: ", attributes: titleAttribute))
            durStr.append(NSMutableAttributedString(string: formatter.string(from: date) ?? "", attributes: bodyAttributes))

            
            self.durationLabel.attributedText = durStr
        }
    }

}
