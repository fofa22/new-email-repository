//
//  RootTVC.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

protocol CellSelectedDelegate{
    func read(email: Email)
}
protocol DataUpdateDelegate {
	func delete(emails: [Email], DeeletedEdamil: [Email])
	func send (emails: [Email])
	
}

class RootTVC: UITableViewController {
    var dataDictionary: [String:Array<Email>] = [:]
    var emails = [Email]()
    var delegate: CellSelectedDelegate?
	var delegate2: DataUpdateDelegate?
	
	@IBAction func addEmailz(_ sender: UIBarButtonItem) {
		let test = Email(sender: "asu@asu.edu", subject: "Spam", contents: "Spam")
		
		emails.append(test)
	}
	// Inserting
	func Addemail() {
		tableView.insertRows(at: [], with: .fade)
		let test = Email(sender: "asu@asu.edu", subject: "Spam", contents: "Spam")
		emails.append(test)
		tableView.reloadData()
		delegate2?.send(emails: emails)
	}
    override func viewDidLoad() {
        super.viewDidLoad()
	
		
		
		// "YourTitle"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
	
				
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
		
		//Making the send button
		
	
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
		
        let currentEmail = emails[indexPath.row]
        cell.textLabel?.text = currentEmail.subject
        cell.detailTextLabel?.text = currentEmail.sender
		

        return cell
    }
    

	
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		
        if editingStyle == .delete {
			
			var DeletedEmail = [Email]()
			var deletedMail = emails.remove(at: indexPath.row)
			
			 DeletedEmail.append(deletedMail)
			
			
			delegate2?.delete(emails: emails, DeeletedEdamil: DeletedEmail)

            tableView.deleteRows(at: [indexPath], with: .fade)
			//tableView.reloadRows(at: [indexPath], with: .none)
			//tableView.reloadData()
			
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
			
			/*
			let test = Email(sender: "asu@asu.edu", subject: "Spam", contents: "Spam")
			
			emails.append(test)
			
			emails.insert(test, at: indexPath.row)
			
			tableView.insertRows(at: [indexPath], with: .automatic)
			
			delegate2?.send(emails: emails)
			*/
			print("Do nothing")
			
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

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		let destVC2 = segue.destination as! MenuTVC
		destVC2.delegate2 = delegate2

    }
	

	
}
