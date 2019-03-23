//
//  RootAudioPlayer.swift
//  BangB2
//
//  Created by Khoi Nguyen on 12/22/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import UIKit
import AVKit

protocol RootAudioPlayerDelegate {
    func didFinishAudio(successfully:Bool)
}

class RootAudioPlayer: NSObject, AVAudioPlayerDelegate {

    static let shared = RootAudioPlayer()
    
    private var player: AVAudioPlayer?
    var delegate : RootAudioPlayerDelegate?
    override init() {
        super.init()
        
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    
    var url: URL?{
        didSet{
            guard let url = url else {
                return
            }
            
            player = try? AVAudioPlayer(contentsOf: url)
            
        }
    }
    
    func playSound(from url: URL) {

        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        player = try? AVAudioPlayer(contentsOf: url)
        
        /* iOS 10 and earlier require the following line:
         player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
        
        guard let player = player else { return }
        player.delegate = self
        player.play()
            
        
    }
    
    public var duration: TimeInterval{
        return player?.duration ?? 0
    }

    func stop(){
        if let _ = self.player{
            self.player?.stop()
            self.player = nil
            self.url = nil
        }
    }
    
    func pause(){
        self.player?.pause()
    }
    
    func play(){
        self.player?.play()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.didFinishAudio(successfully: flag)
    }
}
