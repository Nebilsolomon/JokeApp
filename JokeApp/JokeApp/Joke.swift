//
//  Joke.swift
//  JokeApp
//
//  Created by Long Nguyen on 11/25/22.
//

import Foundation


class Joke
{
    
    var joke = ""
    var answer = ""
    let id = UUID().uuidString
    
    func getJoke() ->String
    {
        
        return joke
    }
    func getAnswer() ->String
    {
        
        return self.answer
    }
    
    func setJoke(joke: String){
        self.joke = joke
    
    }
    
    func getID() -> String
    {
        return id
    }
    
    
    
}
