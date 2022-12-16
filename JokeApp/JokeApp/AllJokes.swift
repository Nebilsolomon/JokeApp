//
//  Joke.swift
//  JokeApp
//
//  Created by Long Nguyen on 11/25/22.
//

import Foundation
class AllJokes{
    var allOfTheJokes = [Joke]()
    
    func addJoke(joke: Joke)
    {
        allOfTheJokes.append(joke)
    }
    func deleteJoke(id: String)
    {
        for(index, element) in allOfTheJokes.enumerated()
        {
            if element.getID() == id
            {
                allOfTheJokes.remove(at:index)
            }
        }
        
    }
    
    
}
