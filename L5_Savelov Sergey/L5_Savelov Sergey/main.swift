/*
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
 */

import Foundation

enum ActionsWithHatch {case openHatch, closeHatch}//действия для люка
enum ActionsWithEngine {case engineOn, engineOff}//действия для двигателя
enum ActionsWithWindows {case windowsUp, windowsDown}//действия для окон
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

extension Car {
    var info : String {
        get {
            return "марка: \(mark)\nгод выпуска: \(yearOfIssue)"
        }
    }
    func openOrCloseWindows() -> String {
        if actionWithWindows == .windowsUp {
            actionWithWindows = .windowsDown
            return statusOfWindows
        } else {
            actionWithWindows = .windowsUp
            return statusOfWindows
        }
    }
    func startOrStopTheEngine() -> String {
        if actionWithEngine == .engineOff {
            actionWithEngine = .engineOn
            return statusOfEngine
        } else {
            actionWithEngine = .engineOff
            return statusOfEngine
        }
    }
}
extension TrunkCar: CustomStringConvertible {
    var description: String{
        return "марка: \(mark), год выпуска: \(yearOfIssue), состояние двигателя: \(statusOfEngine), состояние окон: \(statusOfWindows), состояние багажника: \(statusOfTheTrunk)"
    }
}
extension SportCar: CustomStringConvertible {
    var description: String{
        return "марка: \(mark), год выпуска: \(yearOfIssue), состояние двигателя: \(statusOfEngine), состояние окон: \(statusOfWindows), состояние люка: \(hatchStatus)"
    }
}
class Car {
    var mark: String = ""
    var yearOfIssue: Int = 0
    var statusOfWindows: String = "Окна закрыты"
    var actionWithWindows: ActionsWithWindows = .windowsUp {
        willSet {
            newValue == .windowsDown ? print("открываем окна \(mark)") : print("закрываем окна \(mark)")
        }
        didSet{
            actionWithWindows == .windowsUp ? (statusOfWindows = "Окна закрыты") : (statusOfWindows = "Окна открыты")
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
// Повседневная машина
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
var bagazhnik = TrunkCar(mark: "volvo", yearOfIssue: 2001, actionWithTrunk: .unLoad)
var pushkagonka = SportCar(mark: "mazda", yearOfIssue: 1999, actionWithHatch: .closeHatch)

bagazhnik.action()
pushkagonka.action()
print(bagazhnik.startOrStopTheEngine())
print(pushkagonka.startOrStopTheEngine())
print(bagazhnik.openOrCloseWindows())
print(pushkagonka.openOrCloseWindows())
print("\n\(bagazhnik.description)\n")
print("\n\(pushkagonka.description)\n")
