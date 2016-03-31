// Template Pattern

protocol AnimalType {
  func eat()
  func poop()
  func liveLife()
}

extension AnimalType {
  func liveLife() {
    eat()
    poop()
  }
}

struct Dog : AnimalType {
  func eat() { print("Dog eating dog food...nom nom") }
  func poop() { print("Dog pooping") }
}
Dog().liveLife()
// "Dog eating dog food...nom nom"
// "Dog pooping"

struct Deer : AnimalType {
  func eat() { print("Deer eating plants, yum!") }
  func poop() { print("Deer poop everywhere!") }
}
Deer().liveLife()
// "Deer eating plants, yum!"
// "Deer poop everywhere!"
