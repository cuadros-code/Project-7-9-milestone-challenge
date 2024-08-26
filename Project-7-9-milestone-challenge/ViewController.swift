//
//  ViewController.swift
//  Project-7-9-milestone-challenge
//
//  Created by Kevin Cuadros on 24/08/24.
//

import UIKit

let generator = UINotificationFeedbackGenerator()

class ViewController: UIViewController {
    @IBOutlet weak var primaryWord: UILabel!
    @IBOutlet weak var wordCount: UILabel!    
    
    var listWords = [String]()
    var selectedWordReferencie: String = ""
    var selectedWord: String = "" {
        didSet {
            wordCount.text = "\(selectedWord.count) letters"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startLevel))
        
        if let fileULR = Bundle.main.url(forResource: "list", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: fileULR){
                listWords = fileContent.components(separatedBy: "\n")
                startLevel()
            }
        }
    }
    
    @objc func startLevel() {
        primaryWord.text = ""
        selectedWordReferencie = ""
        listWords.shuffle()
        listWords.removeAll(where: { $0.isEmpty })
        selectedWord = listWords[0]
        for _ in selectedWord {
            selectedWordReferencie += "?"
        }
        primaryWord.text = selectedWordReferencie
        primaryWord.textColor = .white
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else { return }

        var matchFound = false

        for (index, letter) in selectedWord.enumerated() {
            if String(letter) == buttonText {
                if let stringIndex = selectedWordReferencie.index(
                    selectedWordReferencie.startIndex,
                    offsetBy: index,
                    limitedBy: selectedWordReferencie.endIndex
                ) {
                    selectedWordReferencie.replaceSubrange(stringIndex...stringIndex, with: buttonText)
                    matchFound = true
                }
            }
        }

        if matchFound {
            primaryWord.text = selectedWordReferencie
        } else {
            errorAnimation()
        }
        
        
        if let index = selectedWordReferencie.firstIndex(of: "?") {
            print(index)
        } else {
            successGame()
        }
    }
    
    func successGame() {
        primaryWord.textColor = .green
    }
    
    func errorAnimation(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: primaryWord.center.x - 10, y: primaryWord.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: primaryWord.center.x + 10, y: primaryWord.center.y))
        primaryWord.layer.add(animation, forKey: "position")
        generator.notificationOccurred(.error)
    }
    
    
}

