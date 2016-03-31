// Iterator pattern

struct Mailman<T : Comparable> {
  private var children: [T]
  init<S : SequenceType where S.Generator.Element == T>(_ sequence: S) {
    children = sequence.sort()
  }
  
  func indexOf(element: T) -> Int? {
    return children.indexOf(element)
  }
  
  private func insertionIndexForElement(element: T) -> Int {
    var index = 0
    if children.count > 0 {
      var currentElement = children[index]
      while index < children.count {
        currentElement = children[index]
        if element > currentElement {
          index += 1
        } else {
          break
        }
      }
    }
    return index
  }
  
  mutating func insert(element: T) {
    let index = insertionIndexForElement(element)
    children.insert(element, atIndex: index)
  }
  
  mutating func remove(element: T) -> T? {
    let index = indexOf(element)
    return index != nil ? children.removeAtIndex(index!) : nil
  }
}

extension Mailman : SequenceType {
  typealias Generator = AnyGenerator<T>
  
  func generate() -> AnyGenerator<T> {
    var index = 0
    return AnyGenerator {
      guard index < self.children.count else { return nil }
      let child = self.children[index]
      index += 1
      return child
    }
  }
}

var tennesseeMailman = Mailman(["cletus", "mary jane", "buford"])
tennesseeMailman.children
tennesseeMailman.insert("shuga")
tennesseeMailman.children

var tennesseeMailmanGenerator = tennesseeMailman.generate()
while let child = tennesseeMailmanGenerator.next() {
  print(child)
}

let uppercaseChildren = tennesseeMailman.map { $0.uppercaseString }
uppercaseChildren
// ["BUFORD", "CLETUS", "MARY JANE", "SHUGA"]

let joinedUcaseChildren = tennesseeMailman.map { $0.uppercaseString }.joinWithSeparator("!")
joinedUcaseChildren
// "BUFORD!CLETUS!MARY JANE!SHUGA"

let lazyChildren = tennesseeMailman.lazy.map { $0.uppercaseString }
lazyChildren
// LazyMapSequence<Mailman<String>, String>
lazyChildren.maxElement()
// "SHUGA"
