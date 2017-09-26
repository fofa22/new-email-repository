//
//  ViewController.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CellSelectedDelegate, DataUpdateDelegate{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func read(email: Email) {
        //read this email
        titleLabel.text = email.subject
        senderLabel.text = email.sender
        contentsLabel.text = email.contents
    }
	func delete (emails: [Email], currentEmail : Email){
		delete(currentEmail)
		
	}
	func send (emails: [Email], currentEmail : Email){
		send(emails: emails, currentEmail: currentEmail)
	}
	/*
	func AddEmail(emails: [Email], currentEmail : Email){
		append
	}
*/
	
}

