//
//  BNRHypnosisViewController.swift
//  BNRHypnoNerd-Swift
//
//  Created by Paul Yu on 23/6/14.
//  Copyright (c) 2014 Paul Yu. All rights reserved.
//

import UIKit

class BNRHypnosisViewController: UIViewController, UITextFieldDelegate {

    var segmentedControl : UISegmentedControl!
    var textField : UITextField?
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        //Set the tab bar item's title
        tabBarItem.title = "Hypnotize"
        //Create a UIImage from a file
        //This will use Hypno@2x.png on retina display devices
        let image = UIImage(named: "Hypno.png")
        //Put that image on the tab bar item
        tabBarItem.image = image
    }

    override func loadView()
    {
        //Always call the super implementation of viewDidLoad
        super.viewDidLoad()
        
        //Create a view
        var backgroundView = BNRHypnosisView(frame: CGRectZero)
        self.view = backgroundView
        
        //Create UISegmentedControl
        segmentedControl = UISegmentedControl(items: ["RED", "GREEN", "BLUE"])
        segmentedControl.frame = CGRectMake(75, 20, 180, 44)    //fix: use of magic numbers
        
        self.view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: "pickRGBColor:", forControlEvents: UIControlEvents.ValueChanged)
        
        //Create a text field
        let textFieldRect = CGRectMake(40, 70, 240, 30)
        textField = UITextField(frame: textFieldRect)
        
        //Setting the border style on the text field will allow us to see it more easily
        textField!.borderStyle = UITextBorderStyle.RoundedRect
        textField!.placeholder = "Hypnotize me"
        textField!.returnKeyType = UIReturnKeyType.Done
        textField!.delegate = self
        self.view.addSubview(textField!)
        
        println("BNRHypnosisViewController loaded its view.")
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(2.0,
            delay: 0.0,
            usingSpringWithDamping: 0.25,
            initialSpringVelocity: 0.0,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                let frame = CGRectMake(40, 270, 240, 30)
                self.textField!.frame = frame
            },
            completion: nil)

     }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        drawHypnoticMessage(textField.text)
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
    func pickRGBColor(sender: UISegmentedControl!)
    {
            println("User clicked segmentedControl")
            let hv = self.view as BNRHypnosisView
            switch segmentedControl.selectedSegmentIndex
            {
            case 0: hv.circleColor = UIColor.redColor()
            case 1: hv.circleColor = UIColor.greenColor()
            case 2: hv.circleColor = UIColor.blueColor()
            default: println("UISegmentedControl chose unknown color")
            }
    }
    
    func drawHypnoticMessage(message : String)
    {
        for _ in 1..<20
        {
            var messageLabel = UILabel()
            
            //Configure the label's colors and text
            messageLabel.backgroundColor = UIColor.clearColor()
            messageLabel.text = message
            
            //This method resizes the label, which will be relative
            //to the text that it is displaying
            messageLabel.sizeToFit()
            
            //Get a random x value that fits within the hypnosis view's width
            var width : CGFloat = view.bounds.size.width - messageLabel.bounds.size.width
            var x = CGFloat(arc4random()) % width
            
            //Get a random y value that fits within the hypnosis view's width
            var height : CGFloat = view.bounds.size.height - messageLabel.bounds.size.height
            var y = CGFloat(arc4random()) % height
            
            //Update the label's frame
            var frame = messageLabel.frame
            frame.origin = CGPointMake(x, y)
            messageLabel.frame = frame
            
            //Add the label to the hierarchy
            view.addSubview(messageLabel)
            
            //Set the label's intital alpha
            messageLabel.alpha = 0.0
            
            //Animate the alpha to 1.0
            //UIView.animateWithDuration(0.5, animations:{ messageLabel.alpha = 1.0 })
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { messageLabel.alpha = 1.0 }, completion: nil)
            
            UIView.animateKeyframesWithDuration(1.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: {
                
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.8, animations: { messageLabel.center = self.view.center })
                
                UIView.addKeyframeWithRelativeStartTime(0.8, relativeDuration: 0.2, animations: {
                let x = CGFloat(arc4random_uniform(UInt32(width)))
                let y = CGFloat(arc4random_uniform(UInt32(height)))
                messageLabel.center = CGPointMake(x , y)})
            
                }, completion: {(finished: Bool) in
                    println("Animation finished") })
            
            var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            
            motionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
        }
    }
}