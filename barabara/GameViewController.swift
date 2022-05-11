//
//  GameViewController.swift
//  barabara
//
//  Created by 八森聖人 on 2022/05/12.
//

import UIKit

class GameViewController: UIViewController {
    var timer: Timer!
    var score: Int = 1000
    let defaults: UserDefaults = UserDefaults.standard
    
    let width: CGFloat = UIScreen.main.bounds.size.width
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]
    var dx: [CGFloat] = [1.0, 0.5, -1.0]
    
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func stop(_ sender: Any) {
        if timer.isValid {
            timer.invalidate()
        }
        for i in 0..<3 {
            score = score - abs(Int(width/2 - positionX[i]))*2
            resultLabel.text = "Score: \(String(score))"
            resultLabel.isHidden = false
        }
        
        self.saveScore()
    }
    
    @IBAction func retry(_ sender: UIButton) {
        score = 1000
        positionX = [width/2, width/2, width/2]
        if !timer.isValid {
            self.start()
        }
    }
    
    @IBAction func toTop(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func up() {
        for i in 0..<3 {
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * (-1)
            }
            positionX[i] += dx[i]
        }
        imgView1.center.x = positionX[0]
        imgView2.center.x = positionX[1]
        imgView3.center.x = positionX[2]
    }
    
    private func start() {
        resultLabel.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    private func saveScore() {
        let highScores = defaults.array(forKey: "HIGH_SCORES") as? [Int]
        var newData: [Int]
        if var h = highScores {
            h.append(score)
            h.sort { $0 > $1 }
            newData = Array(h.prefix(3))
        } else {
            newData = [score]
        }

        defaults.set(newData, forKey: "HIGH_SCORES")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2]
        self.start()
    }
}
