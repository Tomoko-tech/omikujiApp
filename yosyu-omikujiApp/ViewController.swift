//
//  ViewController.swift
//  yosyu-omikujiApp
//
//  Created by Takahashi Tomoko on 2020/09/11.
//  Copyright © 2020 takatomo.com. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()

    
    @IBOutlet var stickView: UIView!
    
    @IBOutlet var stickLabel: UILabel!
    
    @IBOutlet var stickHeight: NSLayoutConstraint!
    
    @IBOutlet var stickBottomMargin: NSLayoutConstraint!
    
    
    
    @IBOutlet var overView: UIView!
    
    
    @IBOutlet var bigLabel: UILabel!
    
        let resultTexts: [String] = [
            "大吉",
            "中吉",
            "小吉",
            "吉",
            "末吉",
            "凶",
            "大凶"
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSound()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        //結果の表示中はシェイクモーションを動作させない
        if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false{
            return
        }
        //ランダムな数字に直しInt型にする 0から
        let resultNum = Int(arc4random_uniform(UInt32(resultTexts.count)))
        //おみくじの結果
        stickLabel.text = resultTexts[resultNum]
        //スティックの高さぶんマイナス
        stickBottomMargin.constant = stickHeight.constant * -1
        //
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.bigLabel.text = self.stickLabel.text
            self.overView.isHidden = false
            self.resultAudioPlayer.play()
        })
        
    }
    
    
    
    @IBAction func tapRetryButton(_ sender: Any) {
        overView.isHidden = true
        stickBottomMargin.constant = 0
    }
    
    func setupSound() {
        //ファイルの置いている場所
        if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3") {
            
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            
            resultAudioPlayer.prepareToPlay()
            
        }
    }
    

}

