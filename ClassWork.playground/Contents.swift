//: Playground - noun: a place where people can play

import UIKit

///////////////////////////Bubble Sort///////////////////////

var array = [Int]()

for i in 0 ..< 10 {
    array.append(Int(arc4random_uniform(101)))
}

print(array)


for i in 0 ..< array.count {
    
    var pass = (array.count - 1) - i
    
    for j in 0 ..< pass {
        if (array[j] > array[j + 1]) {
            var temp = array[j + 1]
            array[j + 1] = array[j]
            array[j] = temp
        }
    }
}

print(array)

/////////////////////////////OOP Example////////////////////////

class Box {
    var width: Double
    var height: Double
    var depth: Double
    
    init(width: Double, height: Double, depth: Double) {
        self.width = width
        self.height = height
        self.depth = depth
    }
    
    func getVolume() -> Double {
        return width * height * depth
    }
    
    func openBox() {
        print("You open box with volume: \(getVolume())")
    }
    
    private func secretMethod() {
        print("yes, it was been secret")
    }
}

class ColorBox: Box {
    var color: UIColor
    var colors = [UIColor.red:"red", UIColor.black:"black", UIColor.blue:"blue"]
    
    init(width: Double, height: Double, depth: Double, color: UIColor) {
        self.color = color
        super.init(width: width, height: height, depth: depth)
    }
    
    override func openBox() {
        super.openBox()
        if colors.keys.contains(color) {
            print("And color: \(colors[color]!)")
        }
    }
    
}

let box = ColorBox(width: 12, height: 2, depth: 9, color: UIColor.black)
box.openBox()

//////////////////////////////Stack////////////////////////////////////

struct Stack<T> {
    private var elements = [T]()
    
    func empty() -> Bool {
        return elements.isEmpty
    }
    
    func peek() -> T {
        return elements.first!
    }
    
    mutating func pop() -> T {
        let element = elements.first
        elements.remove(at: 0)
        return element!
    }
    
    mutating func push(item: T) {
        elements.insert(item, at: 0)
    }
}

var stack = Stack<String>()
stack.push(item: "Test")
stack.push(item: "ITIS")
stack.push(item: "Hello, World!")
print("pop: \(stack.pop())")
print("peek: \(stack.peek())")

