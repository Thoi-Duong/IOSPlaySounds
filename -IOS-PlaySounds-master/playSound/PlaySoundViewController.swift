//
//  PlaySoundViewController.swift
//  playSound
//
//  Created by SwagSoft Vn on 12/22/15.
//  Copyright © 2015 SwagSoft Vn. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundViewController: UIViewController {

    
    var soundPlayer: AVAudioPlayer!
    var recorderAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!
//        let url = NSURL(fileURLWithPath: path)
//        
//        do {
//            soundPlayer = try AVAudioPlayer(contentsOfURL: url)
//            
//            soundPlayer.enableRate = true;
//            
//            
//        } catch {
//            print("fail to load file")
//        }
        
        audioEngine = AVAudioEngine()
        
        do{
            audioFile = try AVAudioFile(forReading: recorderAudio.filePathUrl)
            
            
            soundPlayer = try AVAudioPlayer(contentsOfURL: recorderAudio.filePathUrl)
        
            soundPlayer.enableRate = true;
        }
        catch{
            print("cant play file")
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func PlayDarthVanderSound(sender: UIButton) {
        soundPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        playChipmukSound(-1000)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAction(sender: UIButton) {
        //TODO : Play slow sound
        print("play a sound")
        soundPlayer.stop()
        soundPlayer.currentTime = 0.0
        soundPlayer.rate = 0.5
        soundPlayer.prepareToPlay()
        soundPlayer.play()
    }

    @IBAction func playChipmunkAction(sender: UIButton) {
        
        
        soundPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        playChipmukSound(1000)
        
    }
    
    func playChipmukSound(pitch: Float){
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    @IBAction func playFastAction(sender: UIButton) {
        soundPlayer.stop()
        soundPlayer.currentTime = 0.0
        soundPlayer.rate = 2.0
        soundPlayer.prepareToPlay()
        soundPlayer.play()
    }
    @IBAction func stopPlaySound(sender: UIButton) {
        soundPlayer.stop()
        
    }
 

}
