//
//  FolderViewController.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 7/26/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit

class FolderViewController: UIViewController {
    
    private func createImagesFolder() {
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
            let headAndNeckDirectoryPath = documentDirectoryPath.appending("/headAndNeck")
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
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
