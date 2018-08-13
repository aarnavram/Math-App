//
//  ArithmeticViewController.swift
//  mathapp
//
//  Created by Aarnav Ram on 12/06/18.
//  Copyright © 2018 Aarnav Ram. All rights reserved.
//

import UIKit
import M13Checkbox


class ArithmeticViewController: UIViewController {
    
    //declaration of connections from storyboard
    var function: String?
    @IBOutlet weak var numberBoxStackView: UIStackView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainImageViewTwo: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    //configuring the colors and other needs for the lines to draw
    var lastPoint = CGPoint.zero
    var lastPoint2 = CGPoint.zero
    var pointInBox1 = false
    var pointInBox2 = false
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 12
    var opacity: CGFloat = 1.0
    var swiped = false
    var swiped2 = false
    var answer = 100
    var tempImageView : UIImageView?
    var tempImageViewTwo : UIImageView?
    let checkbox = M13Checkbox() //adding this to storyboard messes up storyboard layout, hence programatically
    var drawingAllowed = true
    var prevorientation = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image2 = UIImage(named: "blank")!
        tempImageView = UIImageView(image: image2)
        tempImageViewTwo = UIImageView(image: image2)
        tempImageView!.translatesAutoresizingMaskIntoConstraints = false
        tempImageViewTwo!.translatesAutoresizingMaskIntoConstraints = false
        checkbox.isUserInteractionEnabled = false
        view.addSubview(checkbox)
        view.addSubview(tempImageView!)
        view.addSubview(tempImageViewTwo!)
        view.bringSubview(toFront: tempImageView!)
        view.bringSubview(toFront: tempImageViewTwo!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    public override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        turnOffCheckButton()
        generateQuestion()
        alignImageViews()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkButton.layer.cornerRadius = checkButton.bounds.height/2
        checkButton.clipsToBounds = true
        resetButton.layer.cornerRadius = checkButton.bounds.height/2
        resetButton.clipsToBounds = true
        questionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height/15)
        
        if self.view.bounds.size.width > self.view.bounds.height {
            alignCheckBoxLandscape()
        } else {
            alignCheckBoxPortrait()
        }
        alignImageViews()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if drawingAllowed {
            swiped = false
            tempImageView!.image = nil
            if let touch = touches.first {
                lastPoint = touch.location(in: tempImageView!)
                lastPoint2 = touch.location(in: tempImageViewTwo!)
            }
            if (pointInBox1 && pointInBox2) {
                turnOnCheckButton()
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if drawingAllowed {
            swiped = true
            swiped2 = true
            if let touch = touches.first {
                let currentPoint = touch.location(in: tempImageView!)
                let width1 = tempImageView!.bounds.width
                let height1 = tempImageView!.bounds.height
                let x1 = currentPoint.x
                let y1 = currentPoint.y
                if x1 <= width1 && x1 >= 0 && y1 <= height1 && y1 >= 0 {
                    pointInBox1 = true
                }
                drawLine(fromPoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
                
                
                let currentPoint2 = touch.location(in: tempImageViewTwo!)
                let width2 = tempImageViewTwo!.bounds.width
                let height2 = tempImageViewTwo!.bounds.height
                let x2 = currentPoint2.x
                let y2 = currentPoint2.y
                if x2 <= width2 && x2 >= 0 && y2 <= height2 && y2 >= 0 {
                    pointInBox2 = true
                }
                drawLineTwo(fromPoint: lastPoint2, toPoint: currentPoint2)
                lastPoint2 = currentPoint2
            }
            if (pointInBox1 && pointInBox2) {
                turnOnCheckButton()
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if drawingAllowed {
            if swiped == false {
                drawLine(fromPoint: lastPoint, toPoint: lastPoint)
            }
            if swiped2 == false {
                drawLineTwo(fromPoint: lastPoint2, toPoint: lastPoint2)
            }
            
            UIGraphicsBeginImageContext(mainImageView!.frame.size)
            mainImageView!.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageView!.frame.size.width, height: mainImageView!.frame.size.height))
            tempImageView!.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView!.frame.size.width, height: tempImageView!.frame.size.height), blendMode: .normal, alpha: opacity)
            mainImageView!.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            tempImageView!.image = nil
            
            UIGraphicsBeginImageContext(mainImageViewTwo!.frame.size)
            mainImageViewTwo!.image?.draw(in: CGRect(x: 0, y: 0, width: mainImageViewTwo!.frame.size.width, height: mainImageViewTwo!.frame.size.height))
            tempImageViewTwo!.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageViewTwo!.frame.size.width, height: tempImageViewTwo!.frame.size.height), blendMode: .normal, alpha: opacity)
            mainImageViewTwo!.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            tempImageViewTwo!.image = nil
            if (pointInBox1 && pointInBox2) {
                turnOnCheckButton()
            }
        }
    }
    
    func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(tempImageView!.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView!.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView!.frame.size.width, height: tempImageView!.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setBlendMode(.normal)
        context?.strokePath()
        
        tempImageView!.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView!.alpha = opacity
        UIGraphicsEndImageContext()
        
        
    }
    
    func drawLineTwo(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(tempImageViewTwo!.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageViewTwo!.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageViewTwo!.frame.size.width, height: tempImageViewTwo!.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setBlendMode(.normal)
        context?.strokePath()
        
        tempImageViewTwo!.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageViewTwo!.alpha = opacity
        UIGraphicsEndImageContext()
        
        
    }
    
    @IBAction func onCheckButtonPressed(_ sender: Any) {
        
        var finalString = ""
        MNISTClient.sharedInstance.predict(mainImageView!.image!)
        finalString = MNISTClient.digit!
        MNISTClient.sharedInstance.predict(mainImageViewTwo!.image!)
        finalString = finalString + MNISTClient.digit!
        questionLabel.text = "\(answer)"
        //remove later
        if finalString==String(answer) {
            checkbox.tintColor = UIColor.init(red: 91/255, green: 217/255, blue: 153/255, alpha: 1) //greenish
            checkbox.setCheckState(.checked, animated: false)
            
        } else {
            checkbox.tintColor = UIColor.init(red: 236/255, green: 100/255, blue: 75/255, alpha: 1) //redish
            checkbox.setCheckState(.mixed, animated: false)
        }
        
        drawingAllowed = false
        turnOffCheckButton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let image2 = UIImage(named: "blank")!
            self.mainImageView!.image = nil
            self.mainImageViewTwo!.image = nil
            self.mainImageView!.image = image2
            self.mainImageViewTwo!.image = image2
            self.answer = 100 //reset to 3 digits
            self.generateQuestion()
            self.pointInBox1 = false
            self.pointInBox2 = false
            self.drawingAllowed = true
        }
        
        
    }
    
    @IBAction func onResetPressed(_ sender: Any) {
        let image2 = UIImage(named: "blank")!
        mainImageView!.image = nil
        mainImageViewTwo!.image = nil
        mainImageView!.image = image2
        mainImageViewTwo!.image = image2
        answer = 100
        generateQuestion()
        self.pointInBox1 = false
        self.pointInBox2 = false
        turnOffCheckButton()
    }
    
    func generateQuestion() {
        switch function! {
        case Function.add:
            generateAdditionQuestion()
            break
        case Function.multiply:
            generateMultiplicationQuestion()
            break
        case Function.subtract:
            generateSubtractionQuestion()
            break
        case Function.random:
            generateRandomQuestion()
        default:
            break
        }
        checkbox.tintColor = UIColor.gray
        checkbox.stateChangeAnimation = .expand(.fill)
        checkbox.setCheckState(.mixed, animated: false)
    }
    
    func generateRandomQuestion() {
        let randomSelection = arc4random_uniform(3)
        switch randomSelection {
        case 0:
            generateAdditionQuestion()
            break
        case 1:
            generateMultiplicationQuestion()
            break
        case 2:
            generateSubtractionQuestion()
            break
        default:
            break
        }
        
    }
    
    func generateSubtractionQuestion() {
        var first = UInt32(0)
        var second = UInt32(0)
        while String(answer).count != 2 {
            first = arc4random_uniform(99) + 1
            second = arc4random_uniform(99) + 1
            answer = (first > second) ? Int(first - second) : Int(second - first)
        }
        questionLabel.text = (first > second) ? "\(first) - \(second)" : "\(second) - \(first)"
    }
    
    func generateMultiplicationQuestion() {
        var first = UInt32(0)
        var second = UInt32(0)
        while String(answer).count != 2 {
            first = arc4random_uniform(9) + 1
            second = arc4random_uniform(9) + 1
            answer = Int(first * second)
        }
        questionLabel.text = "\(first) x \(second)"
    }
    
    func generateAdditionQuestion() {
        var first = UInt32(0)
        var second = UInt32(0)
        while String(answer).count != 2 {
            first = arc4random_uniform(99) + 1
            second = arc4random_uniform(99) + 1
            answer = Int(first + second)
        }
        questionLabel.text = "\(first) + \(second)"
        
    }
    
    func alignImageViews() {
        NSLayoutConstraint.init(item: tempImageView!, attribute: .width, relatedBy: .equal, toItem: mainImageView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tempImageView!, attribute: .leading, relatedBy: .equal, toItem: mainImageView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tempImageView!, attribute: .top, relatedBy: .equal, toItem: mainImageView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tempImageView!, attribute: .height, relatedBy: .equal, toItem: mainImageView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tempImageViewTwo!, attribute: .width, relatedBy: .equal, toItem: mainImageViewTwo, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tempImageViewTwo!, attribute: .leading, relatedBy: .equal, toItem: mainImageViewTwo, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tempImageViewTwo!, attribute: .top, relatedBy: .equal, toItem: mainImageViewTwo, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tempImageViewTwo!, attribute: .height, relatedBy: .equal, toItem: mainImageViewTwo, attribute: .height, multiplier: 1, constant: 0).isActive = true
    }
    
    func turnOffCheckButton() {
        checkButton.backgroundColor = UIColor.lightGray
        checkButton.setTitleColor(UIColor.darkGray, for: .normal)
        checkButton.isUserInteractionEnabled = false
    }
    
    func turnOffResetButton() {
        resetButton.backgroundColor = UIColor.lightGray
        resetButton.setTitleColor(UIColor.darkGray, for: .normal)
        resetButton.isUserInteractionEnabled = false
    }
    
    func turnOnCheckButton() {
        checkButton.backgroundColor = UIColor.black
        checkButton.setTitleColor(UIColor.white, for: .normal)
        checkButton.isUserInteractionEnabled = true
    }
    
    func turnOnResetButton() {
        resetButton.backgroundColor = UIColor.black
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.isUserInteractionEnabled = true
    }
    
    func alignCheckBoxPortrait() {
        checkbox.layer.frame = CGRect(x: self.view.bounds.width/2 - 37, y: buttonStackView.frame.maxY + 20, width: 75, height: 75)
        checkbox.markType = .checkmark
    }
    
    func alignCheckBoxLandscape() {
        let widthToRight = (UIScreen.main.bounds.width - numberBoxStackView.frame.maxX)
        let middleHeight = numberBoxStackView.frame.minY + (numberBoxStackView.frame.maxY - numberBoxStackView.frame.minY)/2
        let middlePoint = CGPoint(x: numberBoxStackView.frame.maxX + widthToRight/2, y: middleHeight)
        checkbox.layer.frame = CGRect(x: middlePoint.x - 37, y: middlePoint.y - 37, width: 75, height: 75)
    }
    
}
