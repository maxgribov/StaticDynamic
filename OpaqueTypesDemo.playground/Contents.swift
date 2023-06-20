import Foundation
import CoreGraphics
import Combine

protocol Shape: Identifiable {
    
    func draw()
}

struct Point: Shape {
    
    let id: UUID = UUID()
    let position: CGPoint
    
    func draw() { print("point at: \(position)")}
}

func draw(_ shape: any Shape) {
    
    shape.draw()
}

// external
struct ShapesGenerator {
    
    private struct Line: Shape {
        
        let id: UUID = UUID()
        let start: CGPoint
        let end: CGPoint
        
        func draw() {
            
            print("line start: \(start), end: \(end)")
        }
    }
    
    func getShape(isLine: Bool = false) -> some Shape {
        
        Line(start: .zero, end: .init(x: 30, y: 40))
    }
}

let point = Point(position: .init(x: 1, y: 5))
draw(point) // func draw(_ shape: Point)

let externalShape = ShapesGenerator().getShape()
print(Mirror(reflecting: externalShape))
draw(externalShape) // func draw(_ shape: SomeExternalCode.Line)

struct Circle: Shape {
    
    let id: UUID = UUID()
    let center: CGPoint
    let radius: CGFloat
    
    func draw() { print("circle at: \(center), with radius: \(radius)")}
}

let circleShape = Circle(center: .zero, radius: 1)
let shapes: [any Shape] = [Point(position: .init(x: 1, y: 5)), Point(position: .init(x: 1, y: 5)), circleShape]

final class ViewModel {
    
    @Published private(set) var state: String
    
    init(initialState: String, updates: some Publisher<String, Error>, u2: [any Publisher<String, Never>]) {
        
        self.state = initialState
//        updates.assign(to: &$state)
    }
}

//let viewModel = ViewModel(initialState: "", updates: Just("One"))
//print(viewModel.state)
