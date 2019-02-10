/*
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
 */

import Foundation

enum ActionsWithHatch {case openHatch, closeHatch}//действия для люка
enum ActionsWithEngine {case engineOn, engineOff}//действия для двигателя
enum ActionsWithWindows {case windowsUp, windowsDown}//действия для окон
enum ActionsWithTrunk {case unLoad, upLoad}//действия для багажника
enum Transmission {case manual, auto}//тип трансмиссии

class Car {
    var mark: String = ""
    var yearOfIssue: Int = 0
    var transmission: Transmission = .auto
    var engineRunning: ActionsWithEngine = .engineOff
    var windowsOpen: Bool = false
    var info : String {
        get {
            return "марка: \(mark)\nгод выпуска: \(yearOfIssue)"
        }
    }
    func action() {} // пустой метод
}
class trunkCar: Car {
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
        actionWithTrunk == .upLoad ? (statusOfTheTrunk = "Багажник заполнен") : (statusOfTheTrunk = "Багажник пуст")
    }
    override func action() {
        super.action()
        actionWithTrunk == .unLoad ? print("в багажнике \(mark) груза нет") : print("в багажнике \(mark) есть груз")
        actionWithTrunk == .unLoad ? (actionWithTrunk = .upLoad) : (actionWithTrunk = .unLoad)
    }
    override var info: String {
        get {
            print("Основная информация:")
            return "марка: \(mark), год выпуска: \(yearOfIssue), состояние багажника: \(statusOfTheTrunk)"
        }
    }
}
class sportСar: Car {
    var hatchStatus: String = "Люк закрыт"
    var actionWithHatch: ActionsWithHatch = .closeHatch {
        willSet {
            newValue == .openHatch ? print("открываем...") : print("закрываем...")
        }
        didSet{
            actionWithHatch == .openHatch ? print("люк \(mark) открылся") : print("люк \(mark) закрылся")
            privateAction()
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
        actionWithHatch == .openHatch ? (hatchStatus = "Люк открыт") : (hatchStatus = "Люк закрыт")
    }
    override func action() {
        super.action()
        if actionWithHatch == .closeHatch {
            print("люк \(mark) закрыт")
            actionWithHatch = .openHatch
        } else if actionWithHatch == .openHatch {
            print("люк \(mark) открыт")
            actionWithHatch = .closeHatch
        }
    }
    override var info: String {
        get {
            print("Основная информация:")
            return "марка: \(mark), год выпуска: \(yearOfIssue), состояние люка: \(hatchStatus)"
        }
    }
}
var bagazhnik = trunkCar(mark: "volvo", yearOfIssue: 2001, actionWithTrunk: .unLoad)
var pushkagonka = sportСar(mark: "mazda", yearOfIssue: 1999, actionWithHatch: .closeHatch)

print(bagazhnik.info)
bagazhnik.action()
print(bagazhnik.info)
print()
print(pushkagonka.info)
pushkagonka.action()
print(pushkagonka.info)
