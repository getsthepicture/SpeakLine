//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Cosmic Arrows, LLC on 5/5/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import Cocoa



class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate {
    //Now MainWindowController is more powerful by having its own KITT being able to delegate powerful functionality and do less work.  The delegate will do all the heavy lifting and return the results to MainWindowController instances.
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    let speechSynth = NSSpeechSynthesizer()
    var isSpeaking: Bool = false {
        didSet {
            updateButtons()
        }
    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("MainWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        speechSynth.delegate = self
    }
    
    // MARK: - Action methods
    @IBAction func speakIt(sender: NSButton) {
        //Get tuype-in text as a string
        let string = textField.stringValue
        if string.isEmpty {
            print("string from \(textField) is empty")
        } else {
            speechSynth.startSpeaking(string)
            isSpeaking = true
        }
    }
    
    @IBAction func stopIt(sender: NSButton) {
        speechSynth.stopSpeaking()
        isSpeaking = false
    }
    
    func updateButtons(){
        if isSpeaking {
            speakButton.isEnabled = false
            stopButton.isEnabled = true
        } else {
            speakButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
    
    // MARK: - NSSpeechSynthesizerDelegate
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        //by setting this variable to FALSE, it will fire off the didSet computed property which this variable has both storage and behavior.
        isSpeaking = false
        print("finishedSpeaking = \(finishedSpeaking)")
    }
}
