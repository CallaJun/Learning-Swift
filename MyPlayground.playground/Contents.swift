//: Playground - noun: a place where people can play

import UIKit
import Foundation

class Shape {
    let sides: Int
    let name: String
    
    init(sides: Int, name: String){
        self.sides = sides
        self.name = name
    }
}


class Square: Shape {
    var sideLength: Double
    var area: Double {
        get {
            return sideLength * sideLength
        }
        set {
            sideLength = sqrt(newValue)
        }
    }
    
    init(name: String, sides: Int, sideLength: Double) {
        self.sideLength = sideLength
        super.init(sides: sides, name: name)
    }
    
    convenience init (sideLength: Double){
        self.init(name: "Square", sides: 4, sideLength:sideLength)
    }
}