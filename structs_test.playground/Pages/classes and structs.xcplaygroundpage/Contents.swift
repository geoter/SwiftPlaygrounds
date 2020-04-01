import UIKit

//this playground page includes the original testings before spliting to files. It is more convenient for experimentation but is messy. Check the other playground pages for seperated tests.

class Example{
    var id:Int
    var person:Person{
        didSet{
            print("Example.Person changed:\(oldValue.name) -> \(person.name)")
        }
    }
    
    init(id:Int,person:Person){
        self.id = id
        self.person = person
    }
}
//class Person{
//    var name:String?
//    var city:City{
//        didSet{
//            print("Person.City changed")
//        }
//    }
//
//    init(name:String,city:City){
//        self.name = name
//        self.city = city
//    }
//}
struct City{
    var adress:String
}
//var city = City()
//city.adress = "Street name"
//
//var person = Person(name:"george",city: city)
//var person2 = Person(name:"aggeliki",city: city)
//
//var example = Example(id:18,person: person)
////didSet not called
//person.name = "maria"
////didSet not called
//example.person.name = "maria"
////didSet gets called
//example.person = person2

struct Person{
    var name:String
    var city:City
}
//struct City{
//    var adress:String
//}
var city = City(adress: "Street name")
//var person = Person(name: "george", city: city)
//var example = Example(id: 19, person: person)
//
//withUnsafePointer(to: &person) {
//    print("Person has address: \($0)")
//}
//person.name = "konstantina"
//print("Person.name = konstantina")
//withUnsafePointer(to: &person) {
//    print("Person has address: \($0)")
//}
//print("Person address doesnt change\n")
//
//withUnsafePointer(to: &example.person) {
//    print("Example.Person has address: \($0)")
//    //calls didSet
//}
////example.person != person
//example.person.name = "maria"
//
//withUnsafePointer(to: &example.person) {
//    print("Example.Person has address: \($0)")
//    //calls didSet
//}

func getStruct( structArgument:inout Person){
    var local1 = structArgument
    var local2 = structArgument
    var local3 = local1
    withUnsafePointer(to: &local) {
        print("local has address: \($0)")
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

var person2 = Person(name: "labros", city: city)

withUnsafePointer(to: &person2) {
    print("Person2 has address: \($0)")
}

getStruct(structArgument: &person2)
//https://medium.com/@lucianoalmeida1/understanding-swift-copy-on-write-mechanisms-52ac31d68f2f
