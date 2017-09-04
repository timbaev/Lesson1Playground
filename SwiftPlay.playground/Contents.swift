//: Playground - noun: a place where people can play

import UIKit

let someint: Float = 12.0

let array: Array<String> = ["asdsad"]
let array1: [String] = ["adasdsa"]
var array2 = [String]()

var dictionary = [String:Int]()
var dictionary2 = [Int:String]()

var dictionary3: [String: Int] = ["someKey":123]

let value = dictionary3["someKey"]

let arrayValue = array[0]

var str = "Hello, playground"


let someValue: String!

for (i,object) in array1.enumerated()  {
    let newString = array[i]
    print(object)
}

for var object in array1 {
    
    object = "12321"
}

array1.forEach { print($0) }

var optionalValue: [String]?

let errorString = "Not good."
if let unwrapedArray = optionalValue {
    
    for element in unwrapedArray {
        
    }
}
else {
    print("Error: " + errorString)
}


func someFunction() {
    
}

func functionWithParams(param1: String, param2: String) {
    
}




class MyClass {
    
    var name:String
    
    init(className: String) {
        
        name = className
    }
    
    func function(with array:[String]) -> Int {
        
        return array.count
    }
    
    func function(with strings: String...) {
        
    }
    
    
}

struct MyStruct {
    var name: String!
    var age: Int
    var sex: Bool
    
    init(name: String, age: Int, sex: Bool) {
        
        self.name = name
        self.age = age
        self.sex = sex
    }
    
    func someMethod() {
        
    }
}

let myClass = MyClass(className: "someName")
var copyClass = myClass

let myStruct = MyStruct(name: "Sergey", age: 18, sex: false)

myClass.function(with: "asdasd", "asdasd", "3123")






















