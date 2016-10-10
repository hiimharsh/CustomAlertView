//
//  ViewController.swift
//  CustomAlertView
//
//  Created by Harsh Thakkar on 10/10/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let width = UIScreen.mainScreen().bounds.size.width
    let height = UIScreen.mainScreen().bounds.size.height

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(sender: AnyObject) {
        
        let backView = UIView(frame: CGRectMake(0, 0, width, height))
        let mainView = UIView(frame: CGRectMake(0, 0, width, 300))
        let imageView = UIImageView(frame: CGRectMake(0, 20, 50, 50))
        
        let ratingView = RatingControl(frame: CGRectMake(0, 120, width, 44))
        
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        mainView.layer.zPosition = 100
        mainView.backgroundColor = UIColor.whiteColor()
        mainView.center = CGPointMake(backView.frame.size.width / 2, backView.frame.size.height / 2)
        mainView.layer.cornerRadius = 5
        mainView.clipsToBounds = true
        
        imageView.center.x = self.view.frame.size.width / 2
        imageView.image = UIImage(named: "1")
        
        mainView.addSubview(imageView)
        mainView.addSubview(ratingView)
        backView.addSubview(mainView)
        self.view.addSubview(backView)
        
    }
}

class RatingControl: UIView {
    
    var rating = 0
    let spacing = 5
    let starCount = 5
    var ratingButtons = [UIButton]()
    let moodArr = ["Disappointed", "Sad", "Good", "Super", "In Love"]
    let imageArr = ["1", "2", "1", "2", "1"]
    
    var moodText: UILabel!
    let filledStarImage = UIImage(named: "1")
    let emptyStarImage = UIImage(named: "2")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for _ in 0..<starCount {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            //button.backgroundColor = UIColor.redColor()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped), forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
        
        moodText = UILabel(frame: CGRectMake(0, 80, frame.size.width, 20))
        moodText.textAlignment = .Center
        moodText.textColor = UIColor.blueColor()
        addSubview(moodText)
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 240, height: 44)
    }
    
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
        rating = ratingButtons.indexOf(button)! + 1
        print(rating)
        moodText.text = moodArr[rating - 1]
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }
    
}

