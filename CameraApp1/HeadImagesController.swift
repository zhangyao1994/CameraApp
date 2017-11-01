//
//  HeadImagesController.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 7/27/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit
import Foundation



extension URL {
    var isDirectory: Bool {
        guard isFileURL else { return false }
        var directory: ObjCBool = false
        return FileManager.default.fileExists(atPath: path, isDirectory: &directory) ? directory.boolValue : false
    }

    var subDirectories: [URL] {
        guard isDirectory else { return [] }
        return (try? FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]).filter{ $0.isDirectory }) ?? []
    }
}


class HeadImagesController: UITableViewController {

    static var bodypart = String()
    var name = String()
    let fm = FileManager.default
    var text = String()
    var filecontent = [String]()
    var filecontent1 = [String]()
    let lightColor: UIColor = UIColor(red: 0.996, green: 0.467, blue: 0.224, alpha: 1)


    @IBOutlet var tableviewoptions: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableviewoptions.dataSource = self
        self.tableviewoptions.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        self.tableviewoptions.backgroundColor = lightColor

        
        
        
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent(HeadImagesController.bodypart)
        var urlString: String = myurl.path

        let items = try! fm.contentsOfDirectory(atPath: urlString)
        print(items)



    }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
/*        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        var filecontent: [String]?
            

            do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
                
                
                // if you want to filter the directory contents you can do like this:
                let headandneckpics = directoryContents.filter{ $0.pathExtension == "headAndNeck" }
                print("headAndNeck:",headandneckpics)
                let headandneckNames = headandneckpics.map{ $0.deletingPathExtension().lastPathComponent }
                print("Head And Neck Pictures:", headandneckNames)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }

 */
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent(HeadImagesController.bodypart)
        var urlString: String = myurl.path
        
        let items = try! fm.contentsOfDirectory(atPath: urlString)

        return items.count


    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
/*        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        var filecontent1: [String]?
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            
            
            // if you want to filter the directory contents you can do like this:
            let headandneckpics = directoryContents.filter{ $0.pathExtension == "headAndNeck" }
            print("headAndNeck:",headandneckpics)
            let headandneckNames = headandneckpics.map{ $0.deletingPathExtension().lastPathComponent }
            print("Head And Neck Pictures:", headandneckNames)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }

*/
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent(HeadImagesController.bodypart)
        var urlString: String = myurl.path
        
        let items = try! fm.contentsOfDirectory(atPath: urlString)
        
/*        for var item in items {
            item = item.replacingOccurrences(of: "Optional", with: "")
            item = item.replacingOccurrences(of: "\"", with: "")

        }
 */
 /*
        let items1 = items.map { $0.replacingOccurrences(of: "Optional", with: "") }
        let items2 = items1.map { $0.replacingOccurrences(of: "\"", with: "") }
        let items3 = items2.map { $0.replacingOccurrences(of: "(", with: "") }
        let items4 = items3.map { $0.replacingOccurrences(of: ")", with: "")}
*/
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell


    }
    
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
/*    self.performSegue(withIdentifier: "showpics1", sender: self)
    tableView.deselectRow(at: indexPath, animated: true)
    let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
    
    let currentCell = tableView.cellForRow(at: indexPath!)!
    self.text = currentCell.textLabel!.text!
*/
    let mySelectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
    
    //Colors
    
    mySelectedCell.detailTextLabel?.textColor = UIColor.white
    mySelectedCell.tintColor = UIColor.white
    

    self.performSegue(withIdentifier: "showpics1", sender: self)


}
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            let myCell = tableviewoptions.cellForRow(at: indexPath) as UITableViewCell!

            let bodypartname = myCell?.textLabel?.text

            
            let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let myurl = docsurl.appendingPathComponent(HeadImagesController.bodypart)
            let myurl2 = myurl.appendingPathComponent(bodypartname!)
            
            var urlString: String = myurl2.path
//            var items = try! fm.contentsOfDirectory(atPath: urlString)
            do {
                let items = try! fm.contentsOfDirectory(atPath: urlString)
                print(items)
                try self.fm.removeItem(atPath: urlString)
                tableviewoptions.reloadData()
                
            } catch {
                print("Could not delete \(bodypartname) folder: \(error)")
            }


            // handle delete (by removing the data from your array and updating the tableview)
        }
    }

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let myurl = docsurl.appendingPathComponent(HeadImagesController.bodypart)
    var urlString: String = myurl.path

    if (segue.identifier == "showpics1") {
        if let indexPath = self.tableviewoptions.indexPathForSelectedRow {
            
            // get the cell associated with the indexPath selected.
            let cell = self.tableviewoptions.cellForRow(at: indexPath) as UITableViewCell!
            
            // get the label text to pass to destinationController
            let text1 = cell?.textLabel?.text;
            //let text1 = "\(cell?.textLabel?.text)"
            

            let destinationController = segue.destination as! HeadTimePhotoViewer
            HeadTimePhotoViewer.name2 = urlString + "/" + text1!
        }   
    }
}

    
/*    if let destination = segue.destination as? HeadTimePhotoViewer {
        let selectedRow = tableviewoptions.indexPathForSelectedRow!.row
        destination.name2 = items4[selectedRow]
     
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
