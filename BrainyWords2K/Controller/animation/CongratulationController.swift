//
//  CongratulationController.swift
//  BrainyWords2k
//
//  Created by mac on 10/20/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

class CongratulationController: RootViewController {
    @IBOutlet weak var buttonDissmiss: UIButton!
    
    var completionHandler: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        let congratulationUrl = Utility.getAudioURL(withName: "congratulations", from: Utility.assets.quizSound)
        RootAudioPlayer.shared.url = congratulationUrl
        
        RootAudioPlayer.shared.playSound(from: congratulationUrl)
        
//        Utility.perform(after: RootAudioPlayer.shared.duration) {
//            self.dismiss(animated: false, completion: nil)
//            self.completionHandler?()
//        }
 
    }
    
    @IBAction func dissmisButtonAction(_ sender: UIButton) {
        RootAudioPlayer.shared.stop()
        self.dismiss(animated: false, completion: nil)
        completionHandler?()
    }
}
