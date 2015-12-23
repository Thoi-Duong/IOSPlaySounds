//
//  ViewController.swift
//  playSound
//
//  Created by SwagSoft Vn on 12/22/15.
//  Copyright © 2015 SwagSoft Vn. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder:AVAudioRecorder!
    var recorderAudio:RecordedAudio!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        
        recordButton.enabled = true
        recordLabel.hidden = true
        pauseButton.hidden = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        // save record file
        if (flag){
        recorderAudio = RecordedAudio()
        recorderAudio.filePathUrl = recorder.url
        
        recorderAudio.title = recorder.url.lastPathComponent
        
        
        // start new screen
        
        self.performSegueWithIdentifier("stopRecording", sender: recorderAudio)
        }
        else{
            print("fail to record")
            recordLabel.hidden = true
            pauseButton.hidden = true
            
            recordButton.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if( segue.identifier == "stopRecording"){
            let PlaySoundVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            
            let data = sender as! RecordedAudio
            
            PlaySoundVC.recorderAudio = data;
        }
    }
    
    @IBAction func recordAction(sender: UIButton) {
        print("star recording")
        
        recordLabel.hidden = false
        pauseButton.hidden = false
        
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }

    @IBAction func pausAction(sender: UIButton) {
        print("stop recording");
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
}

