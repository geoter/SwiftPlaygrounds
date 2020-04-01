//: [Previous](@previous)

import Foundation
// https://marcosantadev.com/capturing-values-swift-closures/
//testing: copy on write, struct as func argument (will it be copied?)

struct Person{
    var name:String
    var city:City
}

struct City{
    var adress:String
}

func getStruct( structArgument:Person){
    var local = structArgument
    var local2 = structArgument
    var local3 = local
    withUnsafePointer(to: &local) {
        print("getStruct.local has address: \($0)")
    }
    withUnsafePointer(to: &local2) {
        print("getStruct.local2 has address: \($0)")
    }
    withUnsafePointer(to: &local3) {
        print("getStruct.local3 has address: \($0)\n")
    }
//error: Cannot pass immutable value as inout argument: 'structArgument' is a 'let' constant
//    withUnsafePointer(to: &structArgument) {
//        print("getStruct.structArgument has address: \($0)")
//    }
}

func getStructInout( structArgument:inout Person){
    var local = structArgument
    var local2 = structArgument
    var local3 = local
    withUnsafePointer(to: &local) {
        print("getStruct.local has address: \($0)")
    }
    withUnsafePointer(to: &local2) {
        print("getStruct.local2 has address: \($0)")
    }
    withUnsafePointer(to: &local3) {
        print("getStruct.local3 has address: \($0)")
    }
    withUnsafePointer(to: &structArgument) {
        print("getStruct.structArgument has address: \($0)")
    }
}

var city = City(adress: "Street name")
var person = Person(name: "Labros", city: city)

withUnsafePointer(to: &person) {
    print("Person has address: \($0)\n")
}

getStruct(structArgument: person)
getStructInout(structArgument: &person)
//https://medium.com/@lucianoalmeida1/understanding-swift-copy-on-write-mechanisms-52ac31d68f2f


//: [Next](@next)
