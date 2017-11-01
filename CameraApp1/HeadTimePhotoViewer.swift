//
//  HeadTimePhotoViewer.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 8/1/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit
import Foundation


class HeadTimePhotoViewer: UITableViewController {

    static var name2 = String()
    let fm = FileManager.default
    var items3 = [String]()

    
    @IBOutlet var timestampList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        //let myurl = docsurl.appendingPathComponent("headAndNeck/\(HeadTimePhotoViewer.name2)")
        var urlString: String = HeadTimePhotoViewer.name2
        
        let items = try! fm.contentsOfDirectory(atPath: urlString)
        print(items)

        timestampList.dataSource = self
        self.timestampList.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")


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

    override func numberOfSections(in timestampList: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        /*
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent("headAndNeck/\(name2)")
        var urlString: String = myurl.path
        
        let items2 = try! fm.contentsOfDirectory(atPath: urlString)
        
        items3 = items2
*/
        return 1
    }

    override func tableView(_ timestampList: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        //let myurl = docsurl.appendingPathComponent("headAndNeck/" + HeadTimePhotoViewer.name2)
        var urlString: String = HeadTimePhotoViewer.name2
        
        let items = try! fm.contentsOfDirectory(atPath: urlString)
        
        return items.count

    }

    
    override func tableView(_ timestampList: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        //let myurl = docsurl.appendingPathComponent("headAndNeck/" + HeadTimePhotoViewer.name2)
        var urlString: String = HeadTimePhotoViewer.name2
        
        let items1 = try! fm.contentsOfDirectory(atPath: urlString)

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)

        cell.textLabel?.text = items1[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            self.performSegue(withIdentifier: "showpics5", sender: self)
        
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            let myCell = timestampList.cellForRow(at: indexPath) as UITableViewCell!
            
            let timestamp = myCell?.textLabel?.text
            
            
            let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
 /*
            let myurl = docsurl.appendingPathComponent(HeadTimePhotoViewer.name2)
            let myurl2 = myurl.appendingPathComponent(timestamp!)
*/
            let text2 = myCell?.textLabel?.text
            
            let path = HeadTimePhotoViewer.name2 + "/" + text2!;
            var urlString: String = path

            
            //            var items = try! fm.contentsOfDirectory(atPath: urlString)
            do {
                let items = try! fm.contentsOfDirectory(atPath: urlString)
                print(items)
                try self.fm.removeItem(atPath: urlString)
                timestampList.reloadData()
                
            } catch {
                print("Could not delete \(timestamp) folder: \(error)")
            }
            
            
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        //let myurl = docsurl.appendingPathComponent("headAndNeck/" + HeadTimePhotoViewer.name2)
        var urlString: String = HeadTimePhotoViewer.name2
        
        if (segue.identifier == "showpics5") {
            if let indexPath = self.timestampList.indexPathForSelectedRow {
                
                // get the cell associated with the indexPath selected.
                let cell = self.timestampList.cellForRow(at: indexPath) as UITableViewCell!
                let items = try! fm.contentsOfDirectory(atPath: urlString)
                print(items)

                // get the label text to pass to destinationController
                let text2 = cell?.textLabel?.text
                
                let path = HeadTimePhotoViewer.name2 + "/" + text2!;

                let destinationController = segue.destination as! PhotoGalleryViewer1

                PhotoGalleryViewer1.pathname = path
            }   
        }
    }

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
