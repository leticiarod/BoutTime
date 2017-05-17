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
    let url: String
}

struct Round {
    let unorderedEvents: [Event]
    var orderedEvents: [Event] //correct answer
    
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
    
    let eventsArray = [Event(description: "Ray Charles", url: "https://en.wikipedia.org/wiki/Ray_Charles"),
                       Event(description: "Elvis Presley", url: "https://en.wikipedia.org/wiki/Elvis_Presley"),
                       Event(description: "Johnny Cash", url: "https://en.wikipedia.org/wiki/Johnny_Cash"),
                       Event(description: "Chuck Berry", url: "https://en.wikipedia.org/wiki/Chuck_Berry"),
                       Event(description: "Bee Gees", url: "https://en.wikipedia.org/wiki/Bee_Gees"),
                       Event(description:"The Beatles", url: "https://en.wikipedia.org/wiki/The_Beatles"),
                       Event(description:"The Beach Boys", url: "https://en.wikipedia.org/wiki/The_Beach_Boys"),
                       Event(description:"The Rolling Stones", url: "http://www.rollingstones.com/"),
                       Event(description:"The Kinks", url: "https://en.wikipedia.org/wiki/The_Kinks"),
                       Event(description:"Hendrix", url: "https://en.wikipedia.org/wiki/Jimi_Hendrix"),
                       Event(description:"David Bowie", url: "https://en.wikipedia.org/wiki/David_Bowie"),
                       Event(description: "The Who", url: "https://en.wikipedia.org/wiki/The_Who"),
                       Event(description:"The Velvet Underground", url: "https://en.wikipedia.org/wiki/The_Velvet_Underground"),
                       Event(description:"Elton John", url: "https://en.wikipedia.org/wiki/Elton_John"),
                       Event(description:"Pink Floyd", url: "https://en.wikipedia.org/wiki/Pink_Floyd"),
                       Event(description:"The Doors", url: "https://en.wikipedia.org/wiki/The_Doors"),
                       Event(description:"Creedence Clearwater Revival", url: "https://en.wikipedia.org/wiki/Creedence_Clearwater_Revival"),
                       Event(description:"Led zeppelin", url: "https://en.wikipedia.org/wiki/Led_Zeppelin"),
                       Event(description:"Aerosmith", url: "http://www.aerosmith.com/"),
                       Event(description:"Queen", url: "https://en.wikipedia.org/wiki/Queen_(band)"),
                       Event(description:"Eagles", url: "https://en.wikipedia.org/wiki/Eagle"),
                       Event(description:"AC/DC", url: "https://en.wikipedia.org/wiki/AC/DC"),
                       Event(description:"Ramones", url: "https://en.wikipedia.org/wiki/Ramones"),
                       Event(description:"Talking Heads", url: "https://en.wikipedia.org/wiki/Talking_Heads"),
                       Event(description:"Sex Pistols", url: "https://en.wikipedia.org/wiki/Sex_Pistols"),
                       Event(description:"The Clash", url: "https://en.wikipedia.org/wiki/The_Clash"),
                       Event(description:"Misfits", url: "https://en.wikipedia.org/wiki/Misfits_(band)"),
                       Event(description:"Dire Straits", url: "https://en.wikipedia.org/wiki/Dire_Straits"),
                       Event(description:"R.E.M", url: "https://en.wikipedia.org/wiki/R.E.M."),
                       Event(description:"Red Hot Chili Peppers", url: "http://redhotchilipeppers.com/"),
                       Event(description:"Radiohead", url: "https://es.wikipedia.org/wiki/Radiohead"),
                       Event(description:"Green Day", url: "https://en.wikipedia.org/wiki/Green_Day"),
                       Event(description:"Nirvana", url: "https://en.wikipedia.org/wiki/Nirvana_(band)"),
                       Event(description:"Pearl Jam", url: "https://pearljam.com/"),
                       Event(description:"Rage Against the Machine", url: "http://www.ratm.com/"),
                       Event(description: "Foo Fighters", url: "https://www.foofighters.com/") ] //array containing array of all events chronologically ordered
    

    init(){
    }
    
    // Return a random Round (each round with 4 events without repeated events) when is invoked
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
    
    func orderUnorderedEvents(repeatedIndexesArray: [Int]) -> [Int] {
        // In order to retrieve the correct answer the unordered indexes array  (which is repeatedIndexesArray) is ordered from smallest to largest as the initial array containing all the events is chronologically ordered. Each index in the repeatedIndexesArray it corresponds to an Event.
        let orderedRepeatedIndexesArray = repeatedIndexesArray.sorted()
        
        return orderedRepeatedIndexesArray
    }
    
    func convertIndexesArrayToEventsArray(indexesArray: [Int]) -> [Event]{
        var orderedEventsPerRoundArray: [Event] = []
        
        for index in indexesArray {
            orderedEventsPerRoundArray.append(eventsArray[index])
        }
        
        return orderedEventsPerRoundArray
    }
    
}
