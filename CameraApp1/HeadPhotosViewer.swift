//
//  HeadPhotosViewer.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 7/27/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit


class HeadPhotosViewer: UICollectionViewController {

    
    @IBOutlet weak var ph: UIImageView!
    var pathname = String()
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    let fm = FileManager.default
    var images = [UIImage]()
    let docsurl = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
        
        let myurl = docsurl.appendingPathComponent("\(pathname)")
        var urlString: String = myurl.path
        
        let items = try! fm.contentsOfDirectory(atPath: urlString)
        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
    }
    
//    private func load(fileName: String) -> UIImage? {
    func loadImages() {
        let fileURL = docsurl.appendingPathComponent(pathname)
        do {
            let imageData = try Data(contentsOf: fileURL)
            let image1 = UIImage(data: imageData)
            images.append(image1!)
            self.collectionView?.reloadData()
        } catch {
            print("Error loading image : \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }
/*
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let image = images[indexPath.row]
        cell1.ph.image = image
        
    
        // Configure the cell
    
        return cell
    }
*/
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
