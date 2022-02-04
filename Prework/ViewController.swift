//
//  ViewController.swift
//  Prework
//
//  Created by Nick on 2022-02-03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!

    @IBOutlet weak var sliderLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var numPeopleTextField: UITextField!
    
    @IBOutlet weak var totalPerTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            setGradientBackground()
            super.viewWillAppear(animated)
        }

    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        // Get Tip Percentage based on slider selection
        var tipPercentage = Int(sender.value)
        sliderLabel.text = "\(tipPercentage)%"
        
        // Get bill amount from text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Get the number of people from text field input
        let numPeople = Double(numPeopleTextField.text!) ?? 1
        
        // Get total tip by multiplying tip * tipPercentage
        let tip = bill * Double(tipPercentage)/100
       
        let total = bill + tip
        let totalPerPerson = total / numPeople
        // Update Tip Amount Label
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        totalPerTextField.text = String(format: "$%.2f", totalPerPerson)
        
    }
    
    func setGradientBackground() {
            let colorBottom =  UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor
            let colorTop = UIColor(red: 200.0/255.0, green: 0.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor
                        
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
                    
            self.view.layer.insertSublayer(gradientLayer, at:0)
        }
    }

    @IBDesignable
    public class Gradient: UIView {
        @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
        @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
        @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
        @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
        @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
        @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

        override public class var layerClass: AnyClass { CAGradientLayer.self }

        var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

        func updatePoints() {
            if horizontalMode {
                gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
                gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
            } else {
                gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
                gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
            }
        }
        func updateLocations() {
            gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
        }
        func updateColors() {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
        override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            updatePoints()
            updateLocations()
            updateColors()
        }
}

