/*
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 */

import Foundation

enum ActionsWithHatch {case openHatch, closeHatch}//действия для люка
enum ActionsWithEngine {case engineOn, engineOff}//действия для двигателя
enum ActionsWithWindows {case windowsClose, windowsOpen}//действия для окон
enum ActionsWithTrunk {case unLoad, upLoad}//действия для багажника
enum Transmission {case manual, auto}//тип трансмиссии

protocol AllCar {
    var info : String {
        get
    }
    func action()
    func openOrCloseWindows() -> String
    func startOrStopTheEngine() -> String
}
protocol Windows {
    var statusOfWindows : String {get set}
}
protocol Engine {
    var statusOfEngine : String {get set}
}
extension Car {
    var info : String {
        get {
            return "марка: \(mark)\nгод выпуска: \(yearOfIssue)"
        }
    }
    func openOrCloseWindows() -> String {
        switch actionWithWindows {
        case .windowsClose:
            actionWithWindows = .windowsOpen
            return statusOfWindows
        case .windowsOpen:
            actionWithWindows = .windowsClose
            return statusOfWindows
        }
    }
    func startOrStopTheEngine() -> String {
        switch actionWithEngine {
        case .engineOff:
            actionWithEngine = .engineOn
            return statusOfEngine
        case .engineOn:
            actionWithEngine = .engineOff
            return statusOfEngine
        }
    }
}
extension TrunkCar: CustomStringConvertible {
    var description: String{
        return """
        
        Повседневный автомобиль
        марка: \(mark) год выпуска: \(yearOfIssue)
        состояние двигателя: \(statusOfEngine) состояние окон: \(statusOfWindows)
        состояние багажника: \(statusOfTheTrunk)
        """
    }
}
extension SportCar: CustomStringConvertible {
    var description: String{
        return """
        
        Спортивный автомобиль
        марка: \(mark) год выпуска: \(yearOfIssue)
        состояние двигателя: \(statusOfEngine) состояние окон: \(statusOfWindows)
        состояние люка: \(hatchStatus)
        """
    }
}
class Car: AllCar, Windows, Engine{
    var mark: String = ""
    var yearOfIssue: Int = 0
    var statusOfWindows: String = "Окна закрыты"
    var actionWithWindows: ActionsWithWindows = .windowsClose {
        willSet {
            newValue == .windowsOpen ? print("открываем окна \(mark)") : print("закрываем окна \(mark)")
        }
        didSet{
            actionWithWindows == .windowsClose ? (statusOfWindows = "Окна закрыты") : (statusOfWindows = "Окна открыты")
        }
    }
    var statusOfEngine: String = "Двигатель заглушен"
    var actionWithEngine: ActionsWithEngine = .engineOff {
        willSet {
            newValue == .engineOn ? print("запускаем двигатель \(mark)") : print("глушим двигатель\(mark)")
        }
        didSet{
            actionWithEngine == .engineOn ? (statusOfEngine = "Двигатель запущен") : (statusOfEngine = "Двигатель заглушен")
        }
    }
    var transmission: Transmission = .auto
    func action() {}
}
// Повседневный автомобиль
class TrunkCar: Car {
    var actionWithTrunk: ActionsWithTrunk = .unLoad {
        willSet {
            newValue == .upLoad ? print("загружаем...") : print("раззгружаем...")
        }
        didSet{
            actionWithTrunk == .upLoad ? print("машину \(mark) загрузили") : print("машину \(mark) разгрузили")
            privateAction()
        }
    }
    var statusOfTheTrunk: String = "Багажник пуст"
    init(mark: String, yearOfIssue: Int, actionWithTrunk: ActionsWithTrunk){
        super.init()
        self.mark = mark
        self.yearOfIssue = yearOfIssue
        self.actionWithTrunk = actionWithTrunk
        privateAction()
    }
    private func privateAction() { // изменяем статус багажника в зависимости от применённого действия
        switch actionWithTrunk {
        case .unLoad:
            statusOfTheTrunk = "Багажник пуст"
        case .upLoad:
            statusOfTheTrunk = "Багажник заполнен"
        }
    }
    override func action() {
        super.action()
        actionWithTrunk == .unLoad ? print("в багажнике \(mark) груза нет") : print("в багажнике \(mark) есть груз")
        actionWithTrunk == .unLoad ? (actionWithTrunk = .upLoad) : (actionWithTrunk = .unLoad)
    }
}
// Спортивная машина
class SportCar: Car {
    var hatchStatus: String = "Люк закрыт"
    var actionWithHatch: ActionsWithHatch = .closeHatch {
        willSet {
            newValue == .openHatch ? print("открываем...") : print("закрываем...")
        }
        didSet{
            actionWithHatch == .openHatch ? print("люк \(mark) открылся") : print("люк \(mark) закрылся")
        }
    }
    init(mark: String, yearOfIssue: Int, actionWithHatch: ActionsWithHatch){
        super.init()
        self.mark = mark
        self.yearOfIssue = yearOfIssue
        self.actionWithHatch = actionWithHatch
        privateAction()
    }
    private func privateAction() { // изменяем статус люка в зависимости от применённого действия
        switch actionWithHatch {
        case .openHatch:
            hatchStatus = "Люк открыт"
        case .closeHatch:
            hatchStatus = "Люк закрыт"
        }
    }
    override func action() {
        super.action()
        actionWithHatch == .closeHatch ? print("люк \(mark) закрыт"):print("люк \(mark) открыт")
        actionWithHatch == .closeHatch ? (actionWithHatch = .openHatch):(actionWithHatch = .closeHatch)
        privateAction()
    }
}

struct Queue<T> where T: Windows, T: Engine {
    private var elements: [T] = []
    mutating func push(_ element: T) {
        elements.append(element)
    }
    mutating func pop() -> T? {
        return elements.removeFirst()
    }
    mutating func windowsIsDown(predicate: (String) -> Bool) -> [T] {
        let arr: [T] = elements
        var tmp: [T] = []
        for i in arr {
            if predicate(i.statusOfWindows){
                tmp.append(i)
            }
        }
        return tmp
    }
    mutating func engineIsOn(predicate: (String) -> Bool) -> [T] {
        let arr: [T] = elements
        var tmp: [T] = []
        for i in arr {
            if predicate(i.statusOfEngine){
                tmp.append(i)
            }
        }
        return tmp
    }
    func count() -> Int {
        return  elements.count
    }
    subscript(index: Int) -> T? {  // доступ к стеку по индексу
        if index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
}

let windowsOpen: (String) -> Bool = { (i: String) -> Bool in
    return i == "Окна открыты"
}
let engineOn: (String) -> Bool = { (i: String) -> Bool in
    return i == "Двигатель запущен"
}

var queue = Queue<Car>()

var trunkCar = TrunkCar(mark: "volvo", yearOfIssue: 2001, actionWithTrunk: .unLoad)
var sportCar = SportCar(mark: "mazda", yearOfIssue: 1999, actionWithHatch: .closeHatch)

queue.push(trunkCar)
queue.push(sportCar)

trunkCar.actionWithWindows = .windowsOpen // открыли окна в повседневной машине
sportCar.actionWithEngine = .engineOn // запустили двигатель в спортивной машине

var carsWithOpenWindows = queue.windowsIsDown(predicate: windowsOpen)
var carsRunning = queue.engineIsOn(predicate: engineOn)

print(carsWithOpenWindows)
print(carsRunning)

print(queue[2] as Any)
