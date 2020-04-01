//: [Previous](@previous)

import Foundation

//Test: didSet behaviour on nested properties changes, where class property is a struct (Person)
//Test: copy when changing struct property (line 49)
//Test: copy on write (line 57)
//-------------------------------------------------------------------------------------------------------
//Result 0: line 'example.person.name = "maria"' causes didSet on nested property change
//Result 1: didSet triggered in Example.person when property(name or city) of property (Example.person) is changed
//Result 2: didSet not triggered in Example.person when property(name or city) of person (line 42) is changed because struct Person is copied when assigned to class Example. Read article below
//https://medium.com/@lucianoalmeida1/understanding-swift-copy-on-write-mechanisms-52ac31d68f2f

class Example{
    var id:Int
    var person:Person{
        didSet{
            if oldValue.name == person.name{
                print("didSet: Example.Person changed:\(oldValue.name) -> \(person.name)\n")
            }
            else{
                print("*** didSet: Example.Person changed:\(oldValue.name) -> \(person.name)\n")
            }
            
        }
    }
    
    init(id:Int,person:Person){
        self.id = id
        self.person = person
    }
}

struct Person{
    var name:String
    var city:City{
        didSet{
            print("Person.City changed")
        }
    }
}

struct City{
    var adress:String
}
var city = City(adress: "Street name")

var person = Person(name:"george",city: city)
var person2 = Person(name:"aggeliki",city: city)

var example = Example(id:18,person: person)

withUnsafePointer(to: &person) {
    print("Person has address: \($0)")
}

//didSet not called, because struct Person is copied when assigned to class Example.
person.name = "dimitra"

withUnsafePointer(to: &person) {
    print("Person has address: \($0)\n")
}

var person_new = example.person.name

withUnsafePointer(to: &person_new) { value in
    print("person_new has address: \(value)\n")
}

withUnsafePointer(to: &example.person) { value in
    print("->-> Example.person has address: \(value)\n")
}//caused didSet call george -> george

withUnsafePointer(to: &example.person.name) { value in
    print("-> Example.person.name has address: \(value)\n")
} //caused didSet call george -> george

//didSet gets called
example.person.name = "maria"

withUnsafePointer(to: &example.person) { value in
    print("->-> Example.person has address: \(value)\n")
}//caused didSet call maria -> maria

withUnsafePointer(to: &example.person.name) { value in
    print("-> Example.person.name has address: \(value)\n")
} //caused didSet call maria -> maria

withUnsafePointer(to: &person_new) { value in
    print("person_new has address: \(value)\n")
}


//didSet gets called
print("example.person = person2")
example.person = person2

//: [Next](@next)
