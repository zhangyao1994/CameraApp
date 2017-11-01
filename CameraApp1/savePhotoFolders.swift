//
//  savePhotoFolders.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 7/26/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit
import Foundation


class savePhotoFolders: UITableViewController, UIAlertViewDelegate {
    var capturedImage2 = UIImage()
    var capturedImage3 = UIImage()
    let fm = FileManager.default
    
    @IBOutlet weak var headButton: UIButton!
    @IBOutlet weak var leftArmButton: UIButton!
    
    @IBOutlet weak var rightArmButton: UIButton!
    @IBOutlet weak var stomachButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var leftLegButton: UIButton!
    
    @IBOutlet weak var rightLegButton: UIButton!
    var tField: UITextField!

    let timestamp = String(NSDate().timeIntervalSince1970)

    var timestampString = String()
    
    func commonHelperFunction(_ sender: Any, body: String) {
        func configurationTextField(textField: UITextField!)
        {
            print("generating the TextField")
            textField.placeholder = "Enter name"
            tField = textField
        }
        
        func handleCancel(alertView: UIAlertAction!)
        {
            print("Cancelled !!")
        }
        
        var alert = UIAlertController(title: "Enter Mole Name", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler:{ (UIAlertAction) in
            print("Done !!")
            
            let input = self.tField.text
            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            
            if let documentDirectoryPath = documentDirectoryPath {
                // create the custom folder path
                
                let  newDirectoryPath = documentDirectoryPath.appending("/" + body)
                let fileManager = FileManager.default

                do {
                    try fileManager.createDirectory(atPath: newDirectoryPath,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    print("Error creating" + body + " folder in documents dir: \(error)")
                }
                
                if input != nil {
                    let  newDirectoryPath1 = newDirectoryPath + "/" + input!;
                    do {
                        try fileManager.createDirectory(atPath: newDirectoryPath1,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
                    } catch {
                        print("Error creating /\(body)/\(input) folder in documents dir: \(error)")
                    }
                    
                    let double = Double(self.timestamp)
                    let date2 = (Date(timeIntervalSince1970: double!))
                    self.timestampString = "\(date2)"
                    
                    let  newDirectoryPath2 = newDirectoryPath1 + "/" + self.timestampString;
                    
                    do {
                        try fileManager.createDirectory(atPath: newDirectoryPath2,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
                    } catch {
                        print("Error creating /\(body)/\(input)/\(self.timestamp) folder in documents dir: \(error)")
                    }
                    
                    func saveMyImageToDocumentDirectory(_ capturedImage2: UIImage, _ fileName: String) -> String {
                        let docsurl = try! self.fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                        let myurl = docsurl.appendingPathComponent(body + "/" + input! + "/\(self.timestampString)" + "/" + fileName);

                        do {
                            try UIImageJPEGRepresentation(capturedImage2, 1.0)?.write(to: myurl, options: .atomic)
                            print("saving image to " + myurl.absoluteString);
                            return String.init(myurl.absoluteString)
                            
                        } catch {
                            print(error)
                            print("file cant not be save at path \(myurl.absoluteString), with error : \(error)");
                            return myurl.absoluteString
                        }
                    }
                    
                    saveMyImageToDocumentDirectory(self.capturedImage2, "image1.jpg");
                    saveMyImageToDocumentDirectory(self.capturedImage3, "image2.jpg");
                    
 //                   performSegue(withIdentifier: "gobacktohome", sender: <#Any?#>)

                }
                
            }
            
            
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
        
    }

    @IBAction func createTextAlert(_ sender: Any) {
        commonHelperFunction(sender, body: "headAndNeck");
    }

    @IBAction func saveLeftArmPhoto(_ sender: Any) {
        commonHelperFunction(sender, body: "leftArm");
    }

    @IBAction func saveRightArmPhoto(_ sender: Any) {
        commonHelperFunction(sender, body: "rightArm");
    }

    @IBAction func saveStomachPhoto(_ sender: Any) {
        commonHelperFunction(sender, body: "stomach");
    }
    @IBAction func saveBackPhoto(_ sender: Any) {
        commonHelperFunction(sender, body: "back");
    }
    @IBAction func saveLeftLegPhoto(_ sender: Any) {
        commonHelperFunction(sender, body: "leftLeg");
    }
    
    @IBAction func saverightLegPhoto(_ sender: Any) {
        commonHelperFunction(sender, body: "rightLeg");
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
            // path to documents directory
            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            if let documentDirectoryPath = documentDirectoryPath {
                // create the custom folder path
                let stomachDirectoryPath = documentDirectoryPath.appending("/stomach")
                let fileManager = FileManager.default
                if !fileManager.fileExists(atPath: stomachDirectoryPath) {
                    do {
                        try fileManager.createDirectory(atPath: stomachDirectoryPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
                    } catch {
                        print("Error creating Stomach folder in documents dir: \(error)")
                    }
                }
                let leftArmDirectoryPath = documentDirectoryPath.appending("/leftArm")
                if !fileManager.fileExists(atPath: leftArmDirectoryPath) {
                    do {
                        try fileManager.createDirectory(atPath: leftArmDirectoryPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
                    } catch {
                        print("Error creating Left Arm folder in documents dir: \(error)")
                    }
                }
                let rightArmDirectoryPath = documentDirectoryPath.appending("/rightArm")
                if !fileManager.fileExists(atPath: rightArmDirectoryPath) {
                    do {
                        try fileManager.createDirectory(atPath: rightArmDirectoryPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
                    } catch {
                        print("Error creating Right Arm folder in documents dir: \(error)")
                    }
                }
                let headAndNeckDirectoryPath = documentDirectoryPath.appending("headAndNeck")
                if !fileManager.fileExists(atPath: headAndNeckDirectoryPath) {
                    do {
                        try fileManager.createDirectory(atPath: headAndNeckDirectoryPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
                    } catch {
                        print("Error creating Head and Neck folder in documents dir: \(error)")
                    }
                }
                let backDirectoryPath = documentDirectoryPath.appending("/back")
                if !fileManager.fileExists(atPath: backDirectoryPath) {
                    do {
                        try fileManager.createDirectory(atPath: backDirectoryPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
                    } catch {
                        print("Error creating Back folder in documents dir: \(error)")
                    }
                }
                let leftLegDirectoryPath = documentDirectoryPath.appending("/leftLeg")
                if !fileManager.fileExists(atPath: leftLegDirectoryPath) {
                    do {
                        try fileManager.createDirectory(atPath: leftLegDirectoryPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
                    } catch {
                        print("Error creating Left Leg folder in documents dir: \(error)")
                    }
                }
                let rightLegDirectoryPath = documentDirectoryPath.appending("/rightLeg")
                if !fileManager.fileExists(atPath: rightLegDirectoryPath) {
                    do {
                        try fileManager.createDirectory(atPath: rightLegDirectoryPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
                    } catch {
                        print("Error creating Right Leg folder in documents dir: \(error)")
                    }
                
                
                
                
                
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


}
