// Singleton Pattern

import Foundation

let defaults = NSUserDefaults.standardUserDefaults()
defaults.setBool(true, forKey: "agreedToEula")
defaults.synchronize()
let agreedToEula = defaults.boolForKey("agreedToEula")

let myClass = MyClass.sharedInstance
