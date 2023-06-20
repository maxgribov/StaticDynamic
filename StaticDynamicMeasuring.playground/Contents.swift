import UIKit

protocol Testable {}

struct TestingUnit: Testable {
    
    let id: UUID = UUID()
}

func measure(_ task: () -> Void) -> Double {
    
    let initialTime = CACurrentMediaTime()
    task()
    
    return CACurrentMediaTime() - initialTime
}

func staticDispatch<T>(_ item: T) where T: Testable {
    
    var array = [T]()
    
    for _ in 0..<1000 {
        array.append(item)
    }
}

func dynamicDispatch(_ item: Testable) {
    
    var array = [Testable]()
    
    for _ in 0..<1000 {
        array.append(item)
    }
}

let item = TestingUnit()
let staticResult = measure { staticDispatch(item) }
let dynamicResult = measure { dynamicDispatch(item) }

let diff = (1 - staticResult / dynamicResult) * 100
let percent = "\(String(format: "%.2f", diff))%"
