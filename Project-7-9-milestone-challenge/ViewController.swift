//
//  ViewController.swift
//  Project-7-9-milestone-challenge
//
//  Created by Kevin Cuadros on 24/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    var listWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.00, green: 0.30, blue: 0.81, alpha: 1.00)
        
        if let fileULR = Bundle.main.url(forResource: "list", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: fileULR){
                
            }
        }
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        print(sender.titleLabel?.text! ?? "")
    }
}

