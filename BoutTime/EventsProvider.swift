//
//  EventsProvider.swift
//  BoutTime
//
//  Created by Leticia Rodriguez on 5/15/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import GameKit

struct Event {
    let description: String
}

struct Round {
    let unorderedEvents: [Event]
    var orderedEvents: [Event]
    
    init(){
        self.unorderedEvents = []
        self.orderedEvents = []
    }
    
    init(unorderedEvents: [Event], orderedEvents: [Event]){
        self.unorderedEvents = unorderedEvents
        self.orderedEvents = orderedEvents
    }
}

class RoundProvider {
    
    let eventsArray = [Event(description: "Ray Charles"),
                       Event(description: "Elvis Presley"),
                       Event(description: "Johnny Cash"),
                       Event(description: "Chuck Berry"),
                       Event(description: "Bee Gees"),
                       Event(description:"The Beatles"),
                       Event(description:"The Beach Boys"),
                       Event(description:"The Rolling Stones"),
                       Event(description:"The Kinks"),
                       Event(description:"Hendrix"),
                       Event(description:"David Bowie"),
                       Event(description: "The Who"),
                       Event(description:"The Velvet Underground"),
                       Event(description:"Elton John"),
                       Event(description:"Pink Floyd"),
                       Event(description:"The Doors"),
                       Event(description:"Creedence Clearwater Revival"),
                       Event(description:"Led zeppelin"),
                       Event(description:"Aerosmith"),
                       Event(description:"Queen"),
                       Event(description:"Eagles"),
                       Event(description:"AC/DC"),
                       Event(description:"Ramones"),
                       Event(description:"Talking Heads"),
                       Event(description:"Sex Pistols"),
                       Event(description:"The Clash"),
                       Event(description:"Misfits"),
                       Event(description:"Dire Straits"),
                       Event(description:"R.E.M"),
                       Event(description:"Red Hot Chili Peppers"),
                       Event(description:"Radiohead"),
                       Event(description:"Green Day"),
                       Event(description:"Nirvana"),
                       Event(description:"Pearl Jam"),
                       Event(description:"Rage Against the Machine"),
                       Event(description: "Foo Fighters") ] //array containing array of all events chronologically ordered
    

    init(){
    }
    
    //
    func randomRound() -> Round {
        var repeatedIndexesArray: [Int] = []
        var indexOfSelectedEvent = -1
        var arrayOfIndex: [Event] = []

        for _ in 0...3 {
            indexOfSelectedEvent = GKRandomSource.sharedRandom().nextInt(upperBound: eventsArray.count)
            var isRepeated = isIndexOfSelectedEventRepetead(indexOfSelectedEvent: indexOfSelectedEvent, repeatedIndexesArray: repeatedIndexesArray)
            while isRepeated {
                indexOfSelectedEvent = GKRandomSource.sharedRandom().nextInt(upperBound: eventsArray.count)
                isRepeated = isIndexOfSelectedEventRepetead(indexOfSelectedEvent: indexOfSelectedEvent, repeatedIndexesArray: repeatedIndexesArray)
            }
            arrayOfIndex.append(eventsArray[indexOfSelectedEvent])
            repeatedIndexesArray.append(indexOfSelectedEvent)
        }
        let orderedEventsPerRoundArray = convertIndexesArrayToEventsArray(indexesArray: orderUnorderedEvents(repeatedIndexesArray: repeatedIndexesArray))
        let round = Round(unorderedEvents: arrayOfIndex, orderedEvents: orderedEventsPerRoundArray)
        
        return round
    }
    
    //
    func isIndexOfSelectedEventRepetead(indexOfSelectedEvent: Int, repeatedIndexesArray: [Int]) -> Bool {
        var isRepeated = false
        var i = 0
        
        while !isRepeated && i < repeatedIndexesArray.count{
            if indexOfSelectedEvent == repeatedIndexesArray[i] {
                isRepeated = true
            }
            i += 1
        }
        
        return isRepeated
    }
    
    //
    func orderUnorderedEvents(repeatedIndexesArray: [Int]) -> [Int] {
        
        let orderedRepeatedIndexesArray = repeatedIndexesArray.sorted()
        
        return orderedRepeatedIndexesArray
    }
    
    //
    func convertIndexesArrayToEventsArray(indexesArray: [Int]) -> [Event]{
        var orderedEventsPerRoundArray: [Event] = []
        
        for index in indexesArray {
            orderedEventsPerRoundArray.append(eventsArray[index])
        }
        
        return orderedEventsPerRoundArray
    }
    
}
