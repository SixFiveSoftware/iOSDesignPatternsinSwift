// Builder Patern

let jsonString = "{\"items\":[{\"givenName\":\"BJ\",\"familyName\":\"Miller\",\"heightInInches\":77},{\"givenName\":\"Cole\",\"familyName\":\"Miller\",\"heightInInches\":51}]}"

struct Person {
  let givenName: String
  let familyName: String
  let heightInInches: Int
}

struct PersonBuilder : BuilderType {
  typealias ItemType = Person
  
  func people(json: String?, keyName key: String = "items") -> [Person] {
    do {
      let items = try objectsFromJSON(json, forKey: key, withParsingFunction: parsePerson)
      return items
    } catch {
      return []  // ideally handle error vs return empty array
    }
  }
  
  func parsePerson(items: JSONDictionary) -> Person? {
    guard let givenName = items["givenName"] as? String, familyName = items["familyName"] as? String, heightInInches = items["heightInInches"] as? Int else { return nil }
    
    let person = Person(givenName: givenName, familyName: familyName, heightInInches: heightInInches)
    return person
  }
}

let builder = PersonBuilder()
let people = builder.people(jsonString)
people.count
people.forEach { person in
  print(person)
}


