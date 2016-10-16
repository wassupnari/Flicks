//
//  ViewController.swift
//  Flicks
//
//  Created by Nari Shin on 10/13/16.
//  Copyright © 2016 Nari Shin. All rights reserved.
//

import UIKit
//import Alamofire
import SwiftyJSON

class FlicksTableViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")

       /* Alamofire.request(.GET, url).responseJSON {
            (response) -> Void in
            
            if let value = response.result.value {
                let json = JSON(value)
                
            }
        } */
        
        
        /*
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
                }
                
                
            }
            
            let json = JSON(data: response)
            let url = json["total_posts"].int
        });
        task.resume() */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

