//
//  TTSController.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 04/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation
import AVFoundation

class TTSController {
    
    static let shared = TTSController()
    
    private init() {}
    
    var canSay = true
    
    func say(text: String) {
        
        if canSay {
            canSay = false
            
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.canSay = true
            }
        }
        
    }
}
