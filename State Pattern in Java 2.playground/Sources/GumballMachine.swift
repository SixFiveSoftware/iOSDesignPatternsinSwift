// State Pattern: second iteration

// 1. define State interface
// 2. implement a State class for every state in the machine
// 3. Remove all conditional code by delegating work back to State class


public protocol State {
    var gumballMachine: GumballMachine! { get set }
    func insertQuarter()
    func ejectQuarter()
    func turnCrank()
    func dispense()
}

enum GumballMachineState {
    case SoldOut
    case NoQuarter
    case HasQuarter
    case Sold
    
    func stateHandlerforState(gumballMachine gumballMachine: GumballMachine) -> State {
        var state: State
        switch self {
        case .SoldOut: state = SoldOutState()
        case .NoQuarter: state = NoQuarterState()
        case .HasQuarter: state = HasQuarterState()
        case .Sold: state = SoldState()
        }
        state.gumballMachine = gumballMachine
        return state
    }
    
    mutating func insertQuarter(gumballMachine gumballMachine: GumballMachine) {
        let state = stateHandlerforState(gumballMachine: gumballMachine)
        state.insertQuarter()
    }
    
    mutating func ejectQuarter(gumballMachine gumballMachine: GumballMachine) {
        let state = stateHandlerforState(gumballMachine: gumballMachine)
        state.ejectQuarter()
    }
    
    mutating func turnCrank(gumballMachine gumballMachine: GumballMachine) {
        let state = stateHandlerforState(gumballMachine: gumballMachine)
        state.turnCrank()
    }
    
    mutating func dispense(gumballMachine gumballMachine: GumballMachine) {
        let state = stateHandlerforState(gumballMachine: gumballMachine)
        state.dispense()
    }
}

public class GumballMachine {
    
    var state: GumballMachineState
    public var count = 0
    
    public init(count: Int) {
        state = .SoldOut
        self.count = count
        if count > 0 {
            state = .NoQuarter
        }
    }
    
    func setState(state: GumballMachineState) {
        self.state = state
    }
    
    public func insertQuarter() {
        state.insertQuarter(gumballMachine: self)
    }
    
    public func ejectQuarter() {
        state.ejectQuarter(gumballMachine: self)
    }
    
    public func turnCrank() {
        state.turnCrank(gumballMachine: self)
        state.dispense(gumballMachine: self)
    }
    
    func releaseBall() {
        print("A gumball comes rolling out the slot...")
        if count != 0 {
            count = count - 1
        }
        state = count > 0 ? .NoQuarter : .SoldOut
    }
    
}

struct NoQuarterState: State {
    weak var gumballMachine: GumballMachine!
    
    func insertQuarter() {
        print("You inserted a quarter")
        gumballMachine.setState(.HasQuarter)
    }
    
    func ejectQuarter() { print("You haven't inserted a quarter") }
    
    func turnCrank() { print("You turned, but there's no quarter") }
    
    func dispense() { print("You need to pay first") }
}

struct SoldOutState: State {
    weak var gumballMachine: GumballMachine!
    
    func insertQuarter() {
        print("Sorry, sold out")
        //        ejectQuarter()   // not in book, but perhaps should be?
    }
    
    func ejectQuarter() { print("Returning quarter") }
    
    func turnCrank() { print("Can't turn crank, there are no gumballs!") }
    
    func dispense() { print("Can't dispense, there are no gumballs") }
}

struct HasQuarterState: State {
    weak var gumballMachine: GumballMachine!
    
    func insertQuarter() { print("You can't insert another quarter yet") }
    
    func ejectQuarter() {
        print("Quarter returned")
        gumballMachine.setState(.NoQuarter)
    }
    
    func turnCrank() {
        print("You turned...")
        gumballMachine.setState(.Sold)
    }
    
    func dispense() { print("No gumball dispensed") }
}

struct SoldState: State {
    weak var gumballMachine: GumballMachine!
    
    func insertQuarter() { print("Please wait, we're already giving you a gumball") }
    
    func ejectQuarter() { print("Sorry you already turned the crank") }
    
    func turnCrank() { print("Turning twice doesn't get you another gumball, you gumball!") }
    
    func dispense() {
        gumballMachine.releaseBall()
        if gumballMachine.count > 0 {
            gumballMachine.setState(.NoQuarter)
        } else {
            print("Oops, out of gumballs!")
            gumballMachine.setState(.SoldOut)
        }
    }
}
