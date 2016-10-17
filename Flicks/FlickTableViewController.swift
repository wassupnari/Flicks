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
    @IBOutlet weak var networkErrorUIView: UIView!
    
    var data = [[String: String]]()
    var posterPathList = [String]()
    var imageList = [UIImage]()
    var movieTitle = [String]()
    let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: UIAlertControllerStyle.alert)
    let errorAlertController = UIAlertController(title: "Error", message: "An error occurred. Please try it again", preferredStyle: UIAlertControllerStyle.alert)
    
    /*
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FlickTableViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()*/

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        networkErrorUIView.isHidden = true;
        
        // For pull-to-refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FlickTableViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        mNowPlayingTableView.insertSubview(refreshControl, at: 0)
        
        // Loader
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        // Setting view's data source and delegate properties
        mNowPlayingTableView.dataSource = self
        mNowPlayingTableView.delegate = self
        mNowPlayingTableView.rowHeight = 120
        // We need to register the cell first
        //mNowPlayingTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        
        networkErrorUIView.isHidden = NetworkManager.isConnectedToNetwork()
        
        
        let apiKey = "deb86c335a6b5db138bb7565e746952b"
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        
        Alamofire
            .request(url)
            .responseJSON { response in
                debugPrint("nari nari")
                if  let errorCode = response.response?.statusCode {
                    switch errorCode {
                    case 401:
                        self.networkErrorUIView.isHidden = false
                    case 200:
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
                        self.dismiss(animated: false, completion: nil)
                    default:
                        self.networkErrorUIView.isHidden = false
                    }
                }
                self.dismiss(animated: false, completion: nil)
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        self.present(alertController, animated: false, completion: nil)
        
        networkErrorUIView.isHidden = NetworkManager.isConnectedToNetwork()
        
        let apiKey = "deb86c335a6b5db138bb7565e746952b"
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        
        Alamofire
            .request(url)
            .responseJSON { response in
                
                if  let errorCode = response.response?.statusCode {
                    switch errorCode {
                    case 401:
                        self.networkErrorUIView.isHidden = false
                    case 200:
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
                    default:
                        self.networkErrorUIView.isHidden = false
                    }
                }
                refreshControl.endRefreshing()
                self.dismiss(animated: false, completion: nil)
        }
        /*
        Alamofire.request(url)
            .response { response in
                debugPrint(response)

            }
            .responseJSON { response in
                guard case let .failure(error) = response.result else {
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
                    self.dismiss(animated: false, completion: nil)
                    return
                }
                
                if let error = error as? AFError {
                    switch error {
                    case .invalidURL(let url):
                        debugPrint("Invalid URL: \(url) - \(error.localizedDescription)")
                    case .parameterEncodingFailed(let reason):
                        debugPrint("Parameter encoding failed: \(error.localizedDescription)")
                        debugPrint("Failure Reason: \(reason)")
                    case .multipartEncodingFailed(let reason):
                        debugPrint("Multipart encoding failed: \(error.localizedDescription)")
                        debugPrint("Failure Reason: \(reason)")
                    case .responseValidationFailed(let reason):
                        debugPrint("Response validation failed: \(error.localizedDescription)")
                        debugPrint("Failure Reason: \(reason)")
                        
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            debugPrint("Downloaded file could not be read")
                        case .missingContentType(let acceptableContentTypes):
                            debugPrint("Content Type Missing: \(acceptableContentTypes)")
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            debugPrint("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            debugPrint("Response status code was unacceptable: \(code)")
                        }
                    case .responseSerializationFailed(let reason):
                        debugPrint("Response serialization failed: \(error.localizedDescription)")
                        debugPrint("Failure Reason: \(reason)")
                    }
                    
                    debugPrint("Underlying error: \(error.underlyingError)")
                } else if let error = error as? URLError {
                    debugPrint("URLError occurred: \(error)")
                } else {
                    debugPrint("Unknown error: \(error)")
                }
            } */
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
        }
        
    }

}

