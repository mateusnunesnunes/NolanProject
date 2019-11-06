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
    
    func say(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}
