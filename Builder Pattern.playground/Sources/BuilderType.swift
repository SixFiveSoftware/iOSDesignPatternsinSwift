import Foundation

public typealias JSON = AnyObject
public typealias JSONDictionary = [String : JSON]
public typealias JSONDictionaryArray = [JSONDictionary]

public enum JSONError: ErrorType {
  case NoJSONExists
  case JSONNotParsable
}

public protocol BuilderType {
  associatedtype ItemType
  func objectsFromJSON(jsonString: String?, forKey key: String, withParsingFunction f: JSONDictionary -> ItemType?) throws -> [ItemType]
}

public extension BuilderType {
  public func objectsFromJSON(jsonString: String?, forKey key: String = "items", withParsingFunction f: JSONDictionary -> ItemType?) throws -> [ItemType] {
    guard let jsonString = jsonString else {
      throw JSONError.NoJSONExists
    }
    let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding) ?? NSData()
    do {
      let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
      let items = json[key] as? JSONDictionaryArray ?? []
      return items.flatMap { item in f(item) }
    } catch {
      throw JSONError.JSONNotParsable
    }
  }
}
