//
//  ViewController.swift
//  OCRSample
//
//  Created by myu on 23/11/20.
//

import UIKit
import SwiftyTesseract
import SwiftyTesseractRTE

class ViewController: UIViewController {

    var realTimeEngine: RealTimeEngine!

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var regionOfInterest: UIView! // A subview of previewView
    @IBOutlet weak var scannedCode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        regionOfInterest.layer.borderColor = UIColor.red.cgColor
        regionOfInterest.layer.borderWidth = 1.0
        addOCR()
    }
    
    func addOCR()
    {
        let swiftyTesseract = SwiftyTesseract(language: .english)
        realTimeEngine = RealTimeEngine(swiftyTesseract: swiftyTesseract, desiredReliability: .verifiable) { recognizedString in
          // Do something with the recognized string
            let arr = recognizedString.components(separatedBy: " ")
            if let ind = arr.firstIndex(where: { (s1) -> Bool in
                String(s1.prefix(2)) == "MW"
            })
            {
                let str = arr[ind]
                if Int(str.dropFirst(2)) != nil
                {
                    self.scannedCode.text = str
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
      // Must occur during viewDidLayoutSubviews() - Autolayout constraints are not set in viewDidLoad()
      realTimeEngine.bindPreviewLayer(to: previewView)
      realTimeEngine.regionOfInterest = regionOfInterest.frame

      // Only neccessary if providing a visual cue where the regionOfInterest is to your end user
        previewView.layer.addSublayer(regionOfInterest.layer)
    }
}

