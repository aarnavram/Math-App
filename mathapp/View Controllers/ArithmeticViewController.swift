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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var tempImageView : UIImageView?
    var tempImageViewTwo : UIImageView?
    
    //TODO: delete these once you make the actual connections from storyboard with constraints
    let label = UILabel()
    let questionLabel = UILabel()
    let checkButton = UIButton()
    let answerLabel = UILabel()
    let answerLabel2 = UILabel()
    let resetButton = UIButton()
    let checkbox = M13Checkbox()

    
    public override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        let image2 = UIImage(named: "blank")!
        tempImageView = UIImageView(image: image2)
        tempImageViewTwo = UIImageView(image: image2)
        tempImageView!.translatesAutoresizingMaskIntoConstraints = false
        tempImageViewTwo!.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        //delete these soon
        label.frame = CGRect(x: self.view.bounds.width/2 - 75, y: 50, width: 150, height: 50)
        questionLabel.frame = CGRect(x: self.view.bounds.width/2 - 75, y: 100, width: 150, height: 50)
        answerLabel.frame = CGRect(x: self.view.bounds.width/2 - 75, y: 340, width: 150, height: 50)
        answerLabel2.frame = CGRect(x: self.view.bounds.width/2 - 75, y: 400, width: 150, height: 50)
        checkButton.frame = CGRect(x: self.view.bounds.width/2 - 50, y:460, width: 100, height: 50)
        checkButton.layer.cornerRadius = 20
        resetButton.frame = CGRect(x: self.view.bounds.width/2 - 50, y:520, width: 100, height: 50)
        resetButton.layer.cornerRadius = 20
        checkbox.layer.frame = CGRect(x: self.view.bounds.width/2 - 25, y: 580, width: 50, height: 50)
        
        checkbox.markType = .checkmark
        checkbox.setCheckState(.mixed, animated: false)
        checkbox.stateChangeAnimation = .expand(.fill)
        checkbox.tintColor = UIColor.gray
        self.view.addSubview(checkbox)
        
        label.text = "What is"
        label.font = UIFont(name: "Avenir-Heavy", size: 25.0)
        label.textAlignment = .center
        view.addSubview(label)
        view.bringSubview(toFront: label)
        
        
        answerLabel.font = UIFont(name: "Avenir-Heavy", size: 18.0)
        answerLabel.text = "You answered __"
        answerLabel.textAlignment = .center
        view.addSubview(answerLabel)
        view.bringSubview(toFront: answerLabel)
        
        answerLabel2.font = UIFont(name: "Avenir-Heavy", size: 18.0)
        answerLabel2.textAlignment = .center
        answerLabel2.text = "The answer is __"
        view.addSubview(answerLabel2)
        view.bringSubview(toFront: answerLabel2)
        
        
        generateQuestion()
        questionLabel.font = UIFont(name: "Avenir-Heavy", size: 22.0)
        questionLabel.textAlignment = .center
        view.addSubview(questionLabel)
        view.bringSubview(toFront: questionLabel)
        
        checkButton.setTitle("Check", for: .normal)
        checkButton.setTitleColor(UIColor.white, for: .normal)
        checkButton.addTarget(self, action: #selector(check(_:)), for: .touchUpInside)
        checkButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25.0)
        checkButton.backgroundColor = UIColor.black
        view.addSubview(checkButton)
        view.bringSubview(toFront: checkButton)
        
        
        resetButton.setTitle("Next", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25.0)
        resetButton.backgroundColor = UIColor.black
        view.addSubview(resetButton)
        view.bringSubview(toFront: resetButton)
        // marks the end of what I will need to delete ocne I have made the proper views
        
        
        view.addSubview(tempImageView!)
        view.addSubview(tempImageViewTwo!)
        
        alignImageViews()

        
        view.bringSubview(toFront: tempImageView!)
        view.bringSubview(toFront: tempImageViewTwo!)
        

        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        alignImageViews()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        tempImageView!.image = nil
        if let touch = touches.first {
            lastPoint = touch.location(in: tempImageView!)
            lastPoint2 = touch.location(in: tempImageViewTwo!)
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
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
            print(pointInBox1)
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
            print(pointInBox2)
            drawLineTwo(fromPoint: lastPoint2, toPoint: currentPoint2)
            lastPoint2 = currentPoint2
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    
    @objc func check(_ sender: UIButton) {
        var finalString = ""
        MNISTClient.sharedInstance.predict(mainImageView!.image!)
        finalString = MNISTClient.digit!
        MNISTClient.sharedInstance.predict(mainImageViewTwo!.image!)
        finalString = finalString + MNISTClient.digit!
        
        
        answerLabel.text = "You answered \(finalString)"
        answerLabel2.text = "The answer is \(answer)"
        
        //remove later
        if finalString==String(answer) {
            checkbox.tintColor = UIColor.green
            checkbox.setCheckState(.checked, animated: false)
            
        } else {
            checkbox.setCheckState(.mixed, animated: false)
            checkbox.tintColor = UIColor.red
        }
        
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
        }
        
        
        
    }
    
    @objc func reset() {
        let image2 = UIImage(named: "blank")!
        mainImageView!.image = nil
        mainImageViewTwo!.image = nil
        mainImageView!.image = image2
        mainImageViewTwo!.image = image2
        answer = 100
        generateQuestion()
        self.pointInBox1 = false
        self.pointInBox2 = false
        
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
        answerLabel2.text = "The answer is __"
        answerLabel.text = "You answered __"
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
        answerLabel2.text = "The answer is __"
        answerLabel.text = "You answered __"
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
        answerLabel2.text = "The answer is __"
        answerLabel.text = "You answered __"
        
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
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
