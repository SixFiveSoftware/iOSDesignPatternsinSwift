// State Pattern : first iteration

class GumballMachine {
    let SOLD_OUT = 0
    let NO_QUARTER = 1
    let HAS_QUARTER = 2
    let SOLD = 3
    
    var state: Int
    var count = 0
    
    init(count: Int) {
        state = SOLD_OUT
        self.count = count
        if count > 0 {
            state = NO_QUARTER
        }
    }
    
    func insertQuarter() {
        if state == HAS_QUARTER {
            print("You can't insert another quarter!")
        } else if state == NO_QUARTER {
            state = HAS_QUARTER
            print("You inserted a quarter")
        } else if state == SOLD_OUT {
            print("You can't insert a quarter, the machine is sold out")
        } else if state == SOLD {
            print("Please wait, we're already giving you a gumball")
        }
    }
    
    func ejectQuarter() {
        if state == HAS_QUARTER {
            print("Quarter returned")
            state = NO_QUARTER
        }
        // ...and so on
    }
    
    func turnCrank() {
        // same stuff here
        if state == HAS_QUARTER {
            print("You turned...")
            state = SOLD
            dispense()
        }
    }
    
    func dispense() {
        if state == SOLD {
            print("A gumball comes rolling out the slot")
            count = count - 1 // (yep, they did it this way, because, java)
            if count == 0 {
                print("Oops, out of gumballs")
                state = SOLD_OUT
            } else {
                state = NO_QUARTER
            }
        }
        // ...and so on for irrelevant states
    }
}

let gumballMachine = GumballMachine(count: 5)
gumballMachine.state
gumballMachine.count

gumballMachine.insertQuarter()
gumballMachine.turnCrank()

gumballMachine.state
gumballMachine.count
