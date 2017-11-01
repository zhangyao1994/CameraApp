//
//  PhotoGalleryViewer1.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 8/3/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit

class PhotoGalleryViewer1: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    static var pathname = String()
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    let fm = FileManager.default
    var images = [UIImage]()
    var image = UIImage()
    let docsurl = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self;
        collectionView.delegate = self
        var myurl = NSURL.fileURL(withPath: PhotoGalleryViewer1.pathname)
        var urlString: String = PhotoGalleryViewer1.pathname
        
        let items = try! fm.contentsOfDirectory(atPath: urlString)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        // Do any additional setup after loading the view.
        
        
        for fileName in items {
            
            print(fileName)
            let fileURL = URL(string: fileName, relativeTo: myurl)!
            let imageData = try! Data(contentsOf: fileURL)
            let image1 = UIImage(data: imageData)
            images.append(image1!)

            
        }
        self.collectionView.reloadData()

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
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! PhotoCell
        let image = images[indexPath.row]
        cell.ph.image = image
        

        // Configure the cell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row) selcted")
        let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as! PhotoCell
        
        image = selectedCell.ph.image!

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "enlargepic" {
            
            
            let cell = sender as! PhotoCell!

            if let indexPath1 = self.collectionView.indexPath(for: cell!) {
                
            let cell1 = self.collectionView.cellForItem(at: indexPath1) as! PhotoCell!
            
            let image3 = cell1?.ph.image
                
            let destination = segue.destination as! PhotoViewerController
            destination.selectedImage = image3!
            // returns nil propertyfrom here
            //destination.navigationController!.setNavigationBarHidden(true, animated: false)
            
            }
        }
    }
    

    
    
}
