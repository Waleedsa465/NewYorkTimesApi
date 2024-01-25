//
//  ViewController.swift
//  NewYorkTimesApi
//
//  Created by MacBook Pro on 13/12/2023.
// url string https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key=iMdZny9C2IaSJwbOcX96cLZC0MoQayrm

import UIKit
import Reachability

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var refreshButton: UIBarButtonItem!
    
    
    var activityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    
    
    
    var arrData = [Json4Swift_Base]()
    var filter = [Results]()
    var newDataa = [Multimedia]()
    
    let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        view.addSubview(activityIndicator)
        setupRefreshControl()
        jsonParsing()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        try? reachability.startNotifier()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    @objc func reachabilityChanged() {
        if reachability.connection != .unavailable {
            
            removeInternetAlert()
            
            
        } else {
            
            showInternetAlert()
        }
    }

    func showInternetAlert() {
        if presentedViewController == nil {
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    func removeInternetAlert() {
        // Dismiss the internet alert if it is currently presented
        if presentedViewController is UIAlertController {
            dismiss(animated: true, completion: nil)
        }
    }

    func setupActivityIndicator() {
        // Create and configure the activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshData() {
        // Check internet connection before reloading data
        if reachability.connection != .unavailable {
            // Internet connection is available
            jsonParsing()
        } else {
            // No internet connection
            refreshControl.endRefreshing()
            showInternetAlert()
        }
    }

    @IBAction func refreshButtonTapped(_ sender: Any) {
        // Reload table view data
        jsonParsing()
    }

    func jsonParsing() {
        // Start the spinner
        activityIndicator.startAnimating()

        let url = URL(string: "https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key=iMdZny9C2IaSJwbOcX96cLZC0MoQayrm")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {
                do {
                    guard let data = data else {
                    
                        self.activityIndicator.stopAnimating()
                        self.showInternetAlert()
                        return
                    }
                    
                    let result = try JSONDecoder().decode(Json4Swift_Base.self, from: data)

                    self.arrData = [result]
                    self.filter = result.results!
                    self.newDataa = self.filter.flatMap { $0.multimedia! }
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                    self.removeInternetAlert()
                    self.refreshControl?.endRefreshing()
                } catch {
                    print("Error decoding JSON: \(error)")
                    self.activityIndicator.stopAnimating()
                    self.showInternetAlert()
                    self.refreshControl?.endRefreshing()
                    
                }
            }
        }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        
        cell.newsName.text = filter[indexPath.row].slug_name
        cell.newsTitle.text = filter[indexPath.row].title

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        filter.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.objResult = self.filter[indexPath.row]
        vc.newObjc = self.newDataa[indexPath.row]
        
//        vc.buttonForLink = filter[indexPath.row].url
//        if let multimedia = filter[indexPath.row].multimedia,
//           
//            multimedia.count > 3,
//            let imageUrl = multimedia[2].urls {
//            vc.imgView = imageUrl
//        } else {
//            vc.imgView = " no image for this article"
//        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}































/*
 //
 //  ViewController.swift
 //  NewYorkTimesApi
 //
 //  Created by MacBook Pro on 13/12/2023.
 // url string https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key=iMdZny9C2IaSJwbOcX96cLZC0MoQayrm

 import UIKit

 class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

     @IBOutlet weak var tableView: UITableView!
     var activityIndicator: UIActivityIndicatorView!

     var arrData = [Json4Swift_Base]()
     var filter = [Results]()
     var newDataa = [Multimedia]()

     override func viewDidLoad() {
         super.viewDidLoad()
         setupActivityIndicator()
         view.addSubview(activityIndicator)
         jsonParsing()
     }

     func setupActivityIndicator() {
         // Create and configure the activity indicator
         activityIndicator = UIActivityIndicatorView(style: .large)
         activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
         activityIndicator.center = view.center
         activityIndicator.hidesWhenStopped = true
         view.addSubview(activityIndicator)
     }

     func jsonParsing() {
         // Start the spinner
         activityIndicator.startAnimating()

         let url = URL(string: "https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key=iMdZny9C2IaSJwbOcX96cLZC0MoQayrm")
         URLSession.shared.dataTask(with: url!) { data, response, error in
             do {
                 let data = try Data(contentsOf: url!)
                 let result = try JSONDecoder().decode(Json4Swift_Base.self, from: data)

                 self.arrData = [result]
                 self.filter = result.results
                 
                 self.newDataa = self.filter.flatMap { $0.multimedia }

                 DispatchQueue.main.async {
                     // Stop the spinner when data loading is complete
                     self.activityIndicator.stopAnimating()
                     self.tableView.reloadData()
                 }
             } catch {
                 print("Error decoding JSON: \(error)")
                 // Stop the spinner in case of an error
 //                self.activityIndicator.stopAnimating()
             }

         }.resume()
         
         // below method only for file json file for download
 //        guard let fileLocation = Bundle.main.url(forResource: "data", withExtension: "json") else {
 //            // Stop the spinner in case of an error
 //            activityIndicator.stopAnimating()
 //            return
 //        }

 //        do {
 //            let data = try Data(contentsOf: fileLocation)
 //            let result = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
 //
 //            arrData = [result]
 //            filter = result.results
 //
 //            newDataa = filter.flatMap { $0.multimedia! }
 //
 //            DispatchQueue.main.async {
 //                // Stop the spinner when data loading is complete
 //                self.activityIndicator.startAnimating()
 //                self.tableView.reloadData()
 //            }
 //        } catch {
 //            print("Error decoding JSON: \(error)")
 //            // Stop the spinner in case of an error
 //            activityIndicator.stopAnimating()
 //        }
 //    }


     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
         return filter.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

         // Use the correct array and property here
         cell.newsName.text = (filter[indexPath.row].slug_name) // Replace with the actual property
         cell.newsTitle.text = filter[indexPath.row].title

         return cell
     }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         // return height for each cell
         return 90
     }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
         vc.titleNews = filter[indexPath.row].title
         vc.abstrctNews = filter[indexPath.row].abstract
         vc.newsSource = filter[indexPath.row].source!
         vc.datePublish = filter[indexPath.row].published_date!
         vc.buttonForLink = filter[indexPath.row].url
         vc.imgView = newDataa[indexPath.row].urls
         
         self.navigationController?.pushViewController(vc, animated: true)
     }
 }




 */
