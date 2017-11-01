//
//  PhotoViewerController.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 7/19/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit
import Photos

class PhotoViewerController: UIViewController {

    var selectedImage = UIImage()

    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "goback", sender: self)

    }
    
    @IBAction func deletePhoto(_ sender: Any) {
    }

    @IBOutlet var viewPhoto: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewPhoto.image = selectedImage


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
