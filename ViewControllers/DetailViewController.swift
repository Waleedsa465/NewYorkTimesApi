//
//  DetailViewController.swift
//  NewYorkTimesApi
//
//  Created by MacBook Pro on 13/12/2023.
//

// url string https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key=iMdZny9C2IaSJwbOcX96cLZC0MoQayrm

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var localLbl: UILabel!
    @IBOutlet weak var imagesView: UIImageView!
    @IBOutlet weak var newsTitles: UILabel!
    @IBOutlet weak var abbstractNews: UITextView!
    @IBOutlet weak var sourceOfNews: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var linkBtn: UIButton!
    
    
    var imgView = ""
//    var titleNews = ""
//    var abstrctNews = ""
//    var newsSource = ""
//    var datePublish = ""
    var buttonForLink = ""
    
    
    var objResult: Results!
    var newObjc : Multimedia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTitles.text = self.objResult.title //titleNews
        abbstractNews.text = self.objResult.abstract
        sourceOfNews.text = self.objResult.source
        publishDate.text = self.objResult.published_date
        localLbl.text = self.objResult.multimedia?.first?.copyright
        imgView = self.newObjc.urls!
        buttonForLink = self.objResult.url
//        linkBtn = self.objResult.url
        
        
        if let multimedia = objResult.multimedia,
           
            multimedia.count > 3,
            let imageUrl = multimedia[2].urls {
            imgView = imageUrl
        } else {
            imgView = " no image for this article"
        }

        
        
        if let url = URL(string: imgView) {
            imagesView.kf.setImage(with: url)
        }
        
        
        
        imagesView.layer.cornerRadius = 20
    }

    @IBAction func moreInfo(_ sender: UIButton) {
        if let url = URL(string: buttonForLink) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
