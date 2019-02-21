/*
 1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
 2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.
 */

import Foundation

enum DebetCardOperationError: Error {//возможные ошибки
    case insufficientFunds (moneyNeeded: Double) //недостаточно средств на карте
    case frozenBalance//баланс карточки заморожен
}

// вещь, которую мы хотим приобрести, имеет цену
struct thing {
    var price: Double
}


class DebetCardOperation {
    var balance: Double = 10000 // изначальный баланс
    var cardIsBlocked = false // состояние карты, наша карта может быть заблокирована банком
    func buySomethig(thing: thing) throws { // пытаемся приобрести вещь
        guard cardIsBlocked == false else {
            throw DebetCardOperationError.frozenBalance
        }
        guard thing.price <= self.balance else { // провека на возможность позволить купить себе эту вещь
            throw DebetCardOperationError.insufficientFunds(moneyNeeded: thing.price - balance)
        }
        balance = self.balance - thing.price // списываем деньги
    }
    func depositeMoney (someMoney: Double) { // вносим деньги
        balance = self.balance + someMoney
    }
    func printBalance() { // функция "узнай свой баланс"
        print ("Ваш баланс \(balance)р")
    }
    
    // банк может заблокировать нашу карту
    func changeCardState(cardIsBlocked: Bool) {
        switch cardIsBlocked {
        case true:
            self.cardIsBlocked = true
        case false:
            self.cardIsBlocked = false
        }
    }
}

extension DebetCardOperationError: CustomStringConvertible { // описываем ошибки
    var description: String {
        switch self {
        case .insufficientFunds(let moneyNeeded): return "На карте недостаточно средств для выполнения этой операции. Ваш баланс: \(operation.balance)р, необходимо средств: \(moneyNeeded) rub"
        case .frozenBalance: return "Ваша карта заблокирована"
        }
    }
}


//пробуем
let operation = DebetCardOperation()
do {
    try operation.buySomethig(thing: .init(price: 350.90))
} catch let error as DebetCardOperationError {
    print(error.description)
}
operation.printBalance()
operation.depositeMoney(someMoney: 15000)
operation.printBalance()
do {
    try operation.buySomethig(thing: .init(price: 15000.0))
} catch let error as DebetCardOperationError {
    print(error.description)
}
operation.printBalance()
do {
    try operation.buySomethig(thing: .init(price: 10500.75))
} catch let error as DebetCardOperationError {
    print(error.description)
}

operation.changeCardState(cardIsBlocked: true)// банк заморозил карту.

do {
    try operation.buySomethig(thing: .init(price: 90))
} catch let error as DebetCardOperationError {
    print(error.description)
}
