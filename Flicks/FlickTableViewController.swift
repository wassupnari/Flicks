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

class FlickTableViewController: UIViewController {
    
    var data = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
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
                    let totalResults = swiftyJsonVar["total_results"].int
                    print(swiftyJsonVar)
                    print("total result : \(totalResults)")
                }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func parse(json: JSON) {
        debugPrint("int parse method")
        for result in json["results"].arrayValue {
            debugPrint("for loop")
            let posterPath = result["poster_path"].stringValue
            let overview = result["overview"].stringValue
            
            debugPrint("Path : \(posterPath)")
            let obj = ["poster_path": posterPath, "overview": overview]
            data.append(obj)
        }
        
        
    }
}

