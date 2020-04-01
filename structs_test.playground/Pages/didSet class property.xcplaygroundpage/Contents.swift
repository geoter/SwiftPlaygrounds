//: [Previous](@previous)
 
import Foundation

//Test: didSet behaviour on nested properties changes, where class property is a class (Person)
//Result: didSet not triggered in example.p when property(name or city) of property (class:Person) is changed

class Example{
    var id:Int
    var p:Person{
        didSet{
           if oldValue.name == p.name{
                print("didSet: example.p changed:\(oldValue.name) -> \(p.name)\n")
            }
            else{
                print("*** didSet: example.p changed:\(oldValue.name) -> \(p.name)\n")
            }
        }
    }
    
    init(id:Int,person:Person){
        self.id = id
        self.p = person
    }
}

class Person{
    var name:String
    var city:City{
        didSet{
            print("### Person.City changed")
        }
    }

    init(name:String,city:City){
        self.name = name
        self.city = city
    }
}


class City{
    var adress:String
    init(adress:String){
        self.adress = adress
    }
}

var city = City(adress: "Street name")
var city2 = City(adress: "17 nov")

//withUnsafePointer(to: &city) { value in
//    print("city has address: \(value)")
//}
//
//withUnsafePointer(to: &city2) { value in
//    print("city2 has address: \(value)\n")
//}

print("city has address: \(Unmanaged.passUnretained(city).toOpaque())")
print("city2 has address: \(Unmanaged.passUnretained(city2).toOpaque())")

var person1 = Person(name:"george",city: city)
var person2 = Person(name:"aggeliki",city: city2)

print("city has address: \(Unmanaged.passUnretained(person1.city).toOpaque())")
print("city2 has address: \(Unmanaged.passUnretained(person2.city).toOpaque())")

//withUnsafePointer(to: &person1.city) { value in
//    print("->person.city has address: \(value)")
//}
//
//withUnsafePointer(to: &person2.city) {
//    print("-->person2.city has address: \($0)\n")
//}

var example = Example(id:18,person: person1)

withUnsafePointer(to: &person2) { value in
    print("Person2 has address: \(value)")
}

withUnsafePointer(to: &person2.name) { value in
    print("Person2.name has address: \(value)\n")
}

withUnsafePointer(to: &person1) { value in
    print("Person has address: \(value)")
}

withUnsafePointer(to: &person1.name) { value in
    print("Person.name has address: \(value)")
}

print("Person.name has value: \(person1.name)\n")

withUnsafePointer(to: &example.p.name) { value in
    print("-> example.p.name has address: \(value)")
}
print("-> example.p.name has value: \(example.p.name)\n")

//didSet not called
person1.name = "Charalabos"

withUnsafePointer(to: &person1.name) { value in
    print("Person.name has address: \(value)")
}

print("Person.name has value: \(person1.name)\n")

withUnsafePointer(to: &example.p.name) { value in
    print("-> example.p.name has address: \(value)")
}
print("-> example.p.name has value: \(example.p.name)\n")


//didSet called
example.p.name = "maria"

withUnsafePointer(to: &person1.name) { value in
    print("98:Person.name has address: \(value)")
}

print("101:Person.name has value: \(person1.name)\n")

withUnsafePointer(to: &example.p.name) { value in
    print("104:-> example.p.name has address: \(value)")
}
print("106:-> example.p.name has value: \(example.p.name)\n")


withUnsafePointer(to: &example.p.name) { value in
    print("110: -> example.p.name has address: \(value)")
}

//didSet gets called because the entire object changes and thus its reference
//print("114: example.p = person2")
//example.p = person2

withUnsafePointer(to: &example.p) { value in
    print("118:-> example.p has address: \(value)")
}

withUnsafePointer(to: &example.p.name) { value in
    print("122:-> example.p.name has address: \(value)")
}

withUnsafePointer(to: &person2.name) { value in
    print("126:-> person2.name has address: \(value)")
}

print("129:example.p.name = person2.name")
example.p.name = person2.name

withUnsafePointer(to: &example.p.name) { value in
    print("133:-> example.p.name has address: \(value)")
}

withUnsafePointer(to: &person2.city) { value in
    print("138:-> person2.city has address: \(value)")
}

withUnsafePointer(to: &example.p.city) { value in
    print("142:-> example.p.city has address: \(value)")
}

example.p.city = person2.city

withUnsafePointer(to: &example.p.city) { value in
    print("148:-> example.p.city has address: \(value)")
}

//: [Next](@next)
