//
//  GamePlay.swift
//  BoutTime
//
//  Created by Leticia Rodriguez on 5/16/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import Foundation

struct GamePlay {
    let correctedRounds: Int = 0
    let totalRounds: Int = 6
    
     func addCorrectedRound() {
        self.correctedRounds += 1
    }
    
    func resetCorrectedRounds(){
        self.correctedRounds = 0
    }
}
