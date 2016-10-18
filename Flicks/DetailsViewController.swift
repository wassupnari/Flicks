//
//  DetailsViewController.swift
//  Flicks
//
//  Created by Nari Shin on 10/15/16.
//  Copyright © 2016 Nari Shin. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var detailsImageView: UIImageView!
    var image: UIImage!
    @IBOutlet weak var descriptionLabel: UILabel!
    var overview: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailsImageView.image = image
        descriptionLabel.text = overview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
