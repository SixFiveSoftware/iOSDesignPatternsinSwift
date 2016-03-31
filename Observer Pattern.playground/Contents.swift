// Observer Pattern

import Foundation

let DataStoreDidUpdateNotification = "DataStoreDidUpdateNotification"

class MainClass {
    func updateDataStore() {
        // just imagine something worthwhile happened here
        NSNotificationCenter.defaultCenter().postNotificationName(DataStoreDidUpdateNotification, object: nil, userInfo: nil)
    }
}

class SomeOtherClass {
    init() {
        NSNotificationCenter.defaultCenter().addObserverForName(DataStoreDidUpdateNotification, object: nil, queue: NSOperationQueue.mainQueue()) { [unowned self] notification in
            self.dataStoreUpdated(notification)
        }
    }
    
    func dataStoreUpdated(notification: NSNotification) {
        print("I was notified: \(notification.userInfo)")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: DataStoreDidUpdateNotification, object: nil)
    }
}

let someOtherClass = SomeOtherClass()
let mainClass = MainClass()
mainClass.updateDataStore()


