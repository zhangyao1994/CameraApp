//
//  FolderSelector.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 7/26/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit

class FolderSelector: UITableViewController {
    
    var buttonClicked = String()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if (segue.identifier == "segue1") {
            
                
                let destinationController = segue.destination as! HeadImagesController
                HeadImagesController.bodypart = self.buttonClicked;
        }
    }

    
    
    
    
    
    
    
    
    
    @IBOutlet var bodypartstable: UITableView!
    
    
    
    @IBAction func headButton(_ sender: Any) {
        self.buttonClicked = "headAndNeck";
        self.performSegue(withIdentifier: "segue1", sender: self)
    }
    

    @IBAction func leftArmButton(_ sender: Any) {
        self.buttonClicked = "leftArm";
        self.performSegue(withIdentifier: "segue1", sender: self)
    }
    
    @IBAction func rightArmButton(_ sender: Any) {
        self.buttonClicked = "rightArm";
        self.performSegue(withIdentifier: "segue1", sender: self)
    }
    @IBAction func stomachButton(_ sender: Any) {
        self.buttonClicked = "stomach";
        self.performSegue(withIdentifier: "segue1", sender: self)
    }
    @IBAction func backButton(_ sender: Any) {
        self.buttonClicked = "back";
        self.performSegue(withIdentifier: "segue1", sender: self)
    }
    @IBAction func leftLegButton(_ sender: Any) {
        self.buttonClicked = "leftLeg";
        self.performSegue(withIdentifier: "segue1", sender: self)
    }
    @IBAction func rightLegButton(_ sender: Any) {
        self.buttonClicked = "rightLeg";
        self.performSegue(withIdentifier: "segue1", sender: self)
    }
    
    
    
    
   var bodyParts = ["Stomach", "Left Arm", "Right Arm", "Head and Neck", "Left Leg", "Right Leg", "Back"]
    


    override func viewDidLoad() {
        super.viewDidLoad()

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


/*    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bodyParts.count
    }
 */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
