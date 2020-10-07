//
//  main.swift
//  7l_AntonyChechevichkin
//
//  Created by Антон Чечевичкин on 12.09.2020.
//  Copyright © 2020 Антон Чечевичкин. All rights reserved.
//

import Foundation


//Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.




enum StudentErrors: String, Error {
    case quantityOfStringsExceeded = "Столько струн на гитаре нет"
    case noStringsPicked = "Хватит стучать по деке"
    case wrongStringNumber = "Ты чего там дергать собрался?"
}



class Guitar {
    
    
    private var guitarStrings = ["Ми","Си","Соль","Ре","Ля","Ми"]

    

    func playGuitar (pull guitarStringsNumber: Int...) -> (Bool?, StudentErrors?) {
        
        guard guitarStringsNumber.count <= guitarStrings.count else {
            return (false, StudentErrors.quantityOfStringsExceeded)
        }
        
        
        guard guitarStringsNumber.count > 0 && guitarStringsNumber.min()! >= 0 else {
            return (false, StudentErrors.noStringsPicked)
        }
        
        
        
        func maxNumber() -> Int {
        
            guard guitarStringsNumber.count >= 1 else {
                return 0
            }
            
            return guitarStringsNumber.max()!
        }
        
        
        guard maxNumber() < guitarStrings.count else {
            return (false, StudentErrors.wrongStringNumber)
        }
        
        
        
        for n in guitarStringsNumber {
            print("Играем ноту \(guitarStrings[n])")
        }
        
        
        
        
        return (true, nil)
        
    }
    
    
    
}



var acousticGuitar = Guitar()

var acousticSong = acousticGuitar.playGuitar(pull: 3,5,3)

if acousticSong.0 != false {
    print("Мы сыграли аккорд")
} else if let errorPlaying = acousticSong.1 {
    print(errorPlaying.rawValue)
}





//Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.


struct Strum {
    var song: String
}

extension Error {

}

enum ElectroError: String, Error {
    case wrongMusic = "Выбери корректный жанр"
    case turnedOff = "Включи гитару"
    case unplugged = "Вставь шнур"
}

class Electro: Guitar {
    
    enum Music: String {
        case rock = "OtherSide"
        case jazz = "Summertime"
        case heavyMetal = "CrazyTrain"
    }
    
    
    func playElectroGuitar(plug: Bool, turn: Bool, play: Music) throws -> Strum {
        
        guard play == Music.heavyMetal || play == Music.rock || play == Music.jazz else {
            throw ElectroError.wrongMusic
        }
            
        guard plug == true else {
            throw ElectroError.unplugged
        }
        
        guard turn == true else {
            throw ElectroError.turnedOff
        }
        
        return Strum.init(song: play.rawValue)
        
    }
        
}


var playSong = Electro()


do {
    let song = try playSong.playElectroGuitar(plug: true, turn: false, play: .heavyMetal)
} catch ElectroError.turnedOff {
    print(ElectroError.turnedOff.rawValue)
} catch ElectroError.unplugged {
    print(ElectroError.unplugged.rawValue)
} catch ElectroError.wrongMusic {
    print(ElectroError.wrongMusic.rawValue)
}  catch let error {
    print(error.localizedDescription)
}

print(try playSong.playElectroGuitar(plug: true, turn: true, play: .heavyMetal))
