//
//  ViewController.swift
//  Flicks
//
//  Created by Nari Shin on 10/13/16.
//  Copyright © 2016 Nari Shin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class FlickTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mNowPlayingTableView: UITableView!
    
    var data = [[String: String]]()
    var posterPathList = [String]()
    var imageList = [UIImage]()
    var movieTitle = [String]()
    
    /*
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FlickTableViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()*/

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // For pull-to-refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FlickTableViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        mNowPlayingTableView.insertSubview(refreshControl, at: 0)
        
        // Setting view's data source and delegate properties
        mNowPlayingTableView.dataSource = self
        mNowPlayingTableView.delegate = self
        mNowPlayingTableView.rowHeight = 120
        // We need to register the cell first
        //mNowPlayingTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        let apiKey = "deb86c335a6b5db138bb7565e746952b"
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        
        Alamofire.request(url)
            .response { response in
                //debugPrint(response)
                //NSLog("response : \(response)")
            }
            .responseJSON { response in
                if((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    //let totalResults = swiftyJsonVar["total_results"].int
                    //let resultData = swiftyJsonVar["results"].arrayObject!
                    
                    for (_,subJson) in swiftyJsonVar["results"] {
                        if let posterPath = subJson["poster_path"].string {
                            print(posterPath)
                            self.posterPathList.append(posterPath)
                        }
                        if let title = subJson["title"].string {
                            self.movieTitle.append(title)
                        }
                        let tmpImage = UIImage()
                        self.imageList.append(tmpImage)
                    }
                }
                self.mNowPlayingTableView.reloadData()
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        let apiKey = "deb86c335a6b5db138bb7565e746952b"
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        
        Alamofire.request(url)
            .response { response in
                //debugPrint(response)
                //NSLog("response : \(response)")
            }
            .responseJSON { response in
                if((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    for (_,subJson) in swiftyJsonVar["results"] {
                        if let posterPath = subJson["poster_path"].string {
                            print(posterPath)
                            self.posterPathList.append(posterPath)
                        }
                        if let title = subJson["title"].string {
                            self.movieTitle.append(title)
                        }
                        let tmpImage = UIImage()
                        self.imageList.append(tmpImage)
                    }
                }
                self.mNowPlayingTableView.reloadData()
                refreshControl.endRefreshing()
            }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.nari.MoviePrototypeCell", for: indexPath) as! MoviePrototypeCell
        let path = posterPathList[indexPath.row]
        cell.movieTitle.text = movieTitle[indexPath.row]
    
        
        // Set image
        Alamofire.request("https://image.tmdb.org/t/p/w300\(path)").responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            cell.movieImage.image = response.result.value
            // Insert data to pass them to detail page
            self.imageList.insert(cell.movieImage.image!, at:indexPath.row)
            
        }
    
        print("row path : \(path)")
        //cell.stateLabel.text = cityState.last
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posterPathList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        mNowPlayingTableView.deselectRow(at: indexPath, animated: true)
        // do something here
    }
    
    /*
     * Pass data to another viewController
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DetailsViewController
        
        if let indexPath = self.mNowPlayingTableView.indexPathForSelectedRow {
            // do the work here
            destinationViewController.photoUrl = posterPathList[indexPath.row]
            destinationViewController.image = imageList[indexPath.row]
            debugPrint("index : \(indexPath)")
        }
        
    }

}

