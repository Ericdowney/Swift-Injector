# Swift Injector

![Swift](https://github.com/Ericdowney/Swift-Injector/workflows/Swift/badge.svg)

This framework is meant to be a minimal dependency injection framework.  Dynamically register app dependencies to be used throughout your application.  This framework is to help write swift tests easier.  When using iOS singleton objects such as NotificationCenter or UserDefaults, there are hoops you have to jump through to make your code testable in XCTest.  Since there is no way to dynamically mock a Swift object the normal routine is to pull these objects out to a class level and then introduce a mock for test.  However, when writing extensions this is not so easy.  Let's look at a couple examples

Normal implementation
```swift
import UIKit

class ViewController: UIViewController {
  
  viewDidLoad() {
    if UserDefaults.standard.bool(forKey: "first_time_user") {
      // Do Something
    }
  }
}
```
becomes
```swift
class ViewController: UIViewController {

  let userDefaults: UserDefaults = .standard
  
  viewDidLoad() {
    if userDefaults.bool(forKey: "first_time_user") {
      // Do Something
    }
  }
}

```

Injector Implementation
```swift
import UIKit
import Injector

class ViewController: UIViewController {

  let userDefaults: UserDefaults? = .resolve()
  
  viewDidLoad() {
    if userDefaults?.bool(forKey: "first_time_user") == true {
      // Do Something
    }
  }
}
```

In the previous examples the UserDefaults dependency was pulled out of the function and put at a class level.  Now let's look at an example with an extension:

Extension Implementation
```swift
extension UIViewController {
  var isFirstTimeUser: Bool {
    return UserDefaults.standard.bool(forKey: "first_time_user")
  }
}
```

There's no way to pull the UserDefaults dependency to the class level because this is not allowed in extensions.  So now let's see it with the Injector:

Injector Implementation
```swift
extension UIViewController {
  var isFirstTimeUser: Bool {
    let userDefaults: UserDefaults? = .resolve()
    return userDefaults?.bool(forKey: "first_time_user") ?? false
  }
}
```

Now in a test you can create a mock user defaults object and then use the injector to get your mock to the production code.  You can see there is a small disadvantage here.  The Injector tries to be as safe as it can.  There are two resolve APIs.

```swift
.resolve() // returns an optional value
try .resolve() // returns a non-optional value but could generate an error
```

How do you use resolve?
The Injector object requires any registered object to conform to the `Resolvable` protocol:

```
extension UserDefaults: Resolvable {}
```

Then the object can be registered on the Injector in the AppDelegate:
```
Injector.shared.register(UserDefaults.standard)
```

## Injector API
|Method Name|Description|
|---------|---------|
|register(_ objects: Resolvable...)|Adds a Resolvable object to the Injector singleton's list of resolvable objects.|
|unregister(_ obj: Resolvable)|Removes a Resolvable object from the Injector singleton's list of resolvable objects. The supplied object must be the exact instance originally registered with the Injector singleton.|
|unregisterAll()|Removes all Resolvable objects from the Injector singleton's list of resolvable objects.|

# License
```
MIT License

Copyright (c) 2018 Ericdowney

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
