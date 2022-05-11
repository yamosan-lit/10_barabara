//
//  RankingViewController.swift
//  barabara
//
//  Created by 八森聖人 on 2022/05/12.
//

import UIKit

class RankingViewController: UIViewController {
    @IBOutlet weak var rankingLabel1: UILabel!
    @IBOutlet weak var rankingLabel2: UILabel!
    @IBOutlet weak var rankingLabel3: UILabel!
    
    @IBAction func toTop(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let defaults: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScores = defaults.array(forKey: "HIGH_SCORES") as? [Int]

        var rankingLabels: [String] = ["---", "---", "---"]
        if let h = highScores {
            for i in 0..<h.count {
                rankingLabels[i] = String(h[i])
            }
        }
        rankingLabel1.text = rankingLabels[0]
        rankingLabel2.text = rankingLabels[1]
        rankingLabel3.text = rankingLabels[2]
    }
}
