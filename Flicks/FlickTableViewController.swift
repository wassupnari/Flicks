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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting view's data source and delegate properties
        mNowPlayingTableView.dataSource = self
        mNowPlayingTableView.delegate = self
        mNowPlayingTableView.rowHeight = UITableViewAutomaticDimension
        // We need to register the cell first
        mNowPlayingTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        let apiKey = "deb86c335a6b5db138bb7565e746952b"
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        
        Alamofire.request(url)
            .response { response in
                //debugPrint(response)
                //NSLog("response : \(response)")
            }
            .responseJSON { response in
                //debugPrint(response)
                debugPrint("got the response")
                
                if((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    //let totalResults = swiftyJsonVar["total_results"].int
                    //let resultData = swiftyJsonVar["results"].arrayObject!
                    
                    for (_,subJson) in swiftyJsonVar["results"] {
                        if let title = subJson["poster_path"].string {
                            print(title)
                            self.posterPathList.append(title)
                        }
                    }
                }
                self.mNowPlayingTableView.reloadData()
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let path = posterPathList[indexPath.row]
        cell.titleLabel.text = path
    
        
        // Set image
        Alamofire.request("https://httpbin.org/image/png").responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            cell.movieImageView.image = response.result.value
            /*
            if let image = response.result.value {
                print("image downloaded: \(image)")
            } */
            
            
        }
    
        print("row path : \(path)")
        //cell.stateLabel.text = cityState.last
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posterPathList.count
    }

}

