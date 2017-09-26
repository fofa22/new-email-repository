//
//  RootTVC.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

protocol CellSelectedDelegate {
    func read(email: Email)
}
protocol DataUpdateDelegate {
	func delete (emails: [Email], currentEmail : Email, indexPath : IndexPath)
	func send (emails: [Email], currentEmail : Email)
	func AddEmail(emails: [Email], currentEmail : Email, indexPath : IndexPath)
	
}

class RootTVC: UITableViewController {
    var dataDictionary: [String:Array<Email>] = [:]
    var emails = [Email]()
    var delegate: CellSelectedDelegate?
	var delegate2: DataUpdateDelegate?
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.title = "Inbox"
		//self.navigationItem.title = "Trash"
		//self.navigationItem.title = "Sent"
			//self.navigationItem.title = keywords[indexPath.row]
		
		
		// "YourTitle"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
		

    }

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
        return emails.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: react to user selecting row
        //I want the detail view controller to update based on the row that I selected
        
        let selectedEmail = emails[indexPath.row]
        delegate?.read(email: selectedEmail)
	
    }
	

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
		
        let currentEmail = emails[indexPath.row]
        cell.textLabel?.text = currentEmail.subject
        cell.detailTextLabel?.text = currentEmail.sender
		

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		
        if editingStyle == .delete {
            // Delete the row from the data source
			let selectedEmail = emails[indexPath.row]
			emails.remove(at: indexPath.row)
			 delegate2?.delete(emails: emails, currentEmail: selectedEmail, indexPath: indexPath )
			delegate2?.send(emails: emails, currentEmail: selectedEmail)
            tableView.deleteRows(at: [indexPath], with: .fade)
			
			
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
			
			let test = Email(sender: "asu@asu.edu", subject: "Spam", contents: "Spam")
			
			emails.append(test)
			
			emails.insert(test, at: indexPath.row)
			delegate2?.AddEmail(emails: emails, currentEmail: test, indexPath: indexPath )
			
			
			//tableView.insertRows(at: [indexPath.row], with: .fade)
        }    
    }


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
