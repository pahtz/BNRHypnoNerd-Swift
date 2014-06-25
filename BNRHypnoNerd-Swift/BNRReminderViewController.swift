//
//  BNRReminderViewController.swift
//  BNRHypnoNerd-Swift
//
//  Created by Paul Yu on 23/6/14.
//  Copyright (c) 2014 Paul Yu. All rights reserved.
//

import UIKit

class BNRReminderViewController: UIViewController {

    @IBOutlet var datePicker : UIDatePicker
    
    @IBAction func addReminder(sender: AnyObject?)
    {
        let date = datePicker.date
        println("Setting a reminder for \(date)")
        
        var note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(note)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        //Set the tab bar item's title
        tabBarItem.title = "Reminder"
        //Create a UIImage from a file
        //This will use Time@2x.png on retina display devices
        let image = UIImage(named: "Time.png")
        //Put that image on the tab bar item
        tabBarItem.image = image
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("BNRReminderViewController loaded its view.")
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.datePicker.minimumDate = NSDate(timeIntervalSinceNow: NSTimeInterval(60))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
