

let gumballMachine = GumballMachine(count: 5)

gumballMachine.insertQuarter()
gumballMachine.turnCrank()
print("\(gumballMachine.count) gumballs left\n")

gumballMachine.ejectQuarter()
print("")

for i in 0..<gumballMachine.count {
    gumballMachine.insertQuarter()
    gumballMachine.turnCrank()
    print("\(gumballMachine.count) gumballs left\n")
}

