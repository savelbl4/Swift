import Foundation
enum Actions {
    case engineOn
    case engineOff
    case windowsUp
    case windowsDown
    case unLoad
    case upLoad
}
struct Car {
    var mark: String
    var yearOfIssue: Int
    var volumeTrunk: Float
    var volumeTrunkFilled: Float
    var engineRunning: Bool
    var windowsOpen: Bool
    var info : String {
    get {
    return "марка - \(mark)\nгод выпуска - \(yearOfIssue)\nобъём багажника - \(volumeTrunk)\nзаполненный объём - \(volumeTrunkFilled)\nдвигатель запущен - \(engineRunning)\nокна открыты - \(windowsOpen)"
    }
    }
    init(mark: String, yearOfIssue: Int, volumeTrunk: Float, volumeTrunkFilled: Float){
        self.mark = mark; self.yearOfIssue = yearOfIssue
        self.volumeTrunk = volumeTrunk; self.volumeTrunkFilled = volumeTrunkFilled
        engineRunning = true; windowsOpen = true
    }
    init() {
        mark = "Лада 2111"; yearOfIssue = 2001; volumeTrunk = 440; volumeTrunkFilled = 0; engineRunning = false; windowsOpen = false
    }
    mutating func action(_ action: Actions) {
        switch action {
        case .engineOn:
            if engineRunning != true {
                engineRunning = true; print("запустили двигатель \(mark)")
            } else {
                print("двигатель уже запущен")
            }
        case .engineOff:
            if engineRunning != false {
                engineRunning = false; print("заглушили двигатель \(mark)")
            } else {
                print("двигатель уже заглушен")
            }
        case .windowsUp:
            if windowsOpen != true {
                windowsOpen = true; print("открыли окна \(mark)")
            } else {
                print("окна уже открыты")
            }
        case .windowsDown:
            if windowsOpen != false {
                windowsOpen = false; print("закрыли окна \(mark)")
            } else {
                print("окна уже закрыты")
            }
        case .unLoad:
            if volumeTrunkFilled == 0 {
                print("груза нет\nобъём груза в багажнике - \(volumeTrunkFilled) литров\n")
            } else if (volumeTrunkFilled - (volumeTrunk/100*25)) < 0{
                print("на 25% от общего объёма багажника разгрузить нельзя\nобъём груза в багажнике - \(volumeTrunkFilled) литров\n")
            } else {
                volumeTrunkFilled = volumeTrunkFilled - (volumeTrunk/100*25)
                print("разгрузили \(mark) на 25% от общего объёма багажника\nобъём груза в багажнике - \(volumeTrunkFilled) литров\n")
            }
        case .upLoad:
            if volumeTrunkFilled == volumeTrunk {
                print("больше не влезет\nобъём груза в багажнике - \(volumeTrunkFilled) литров\n")
            } else {
                volumeTrunkFilled = volumeTrunkFilled + (volumeTrunk/100*25)
                print("загрузили \(mark) на 25% от общего объёма багажника\nобъём груза в багажнике - \(volumeTrunkFilled) литров\n")
            }
        }
    }
    
}
struct Truck {
    var mark: String
    var yearOfIssue: Int
    var volumeTrunk: Float
    var volumeTrunkFilled: Float
    var engineRunning: Bool
    var windowsOpen: Bool
    var info : String {
        get {
            return "марка - \(mark)\nгод выпуска - \(yearOfIssue)\nобъём багажника - \(volumeTrunk)\nзаполненный объём - \(volumeTrunkFilled)\nдвигатель запущен - \(engineRunning)\nокна открыты - \(windowsOpen)"
        }
    }
    init(mark: String, yearOfIssue: Int, volumeTrunk: Float, volumeTrunkFilled: Float){
        self.mark = mark; self.yearOfIssue = yearOfIssue
        self.volumeTrunk = volumeTrunk; self.volumeTrunkFilled = volumeTrunkFilled
        engineRunning = true; windowsOpen = true
    }
    init() {
        mark = "ЗИЛ 130"; yearOfIssue = 1962; volumeTrunk = 5000; volumeTrunkFilled = 5000; engineRunning = false; windowsOpen = true
    }
    mutating func action(_ action: Actions) {
        switch action {
        case .engineOn:
            if engineRunning != true {
                engineRunning = true; print("запустили двигатель \(mark)")
            } else {
                print("двигатель уже запущен")
            }
        case .engineOff:
            if engineRunning != false {
                engineRunning = false; print("заглушили двигатель \(mark)")
            } else {
                print("двигатель уже заглушен")
            }
        case .windowsUp:
            if windowsOpen != true {
                windowsOpen = true; print("открыли окна \(mark)")
            } else {
                print("окна уже открыты")
            }
        case .windowsDown:
            if windowsOpen != false {
                windowsOpen = false; print("закрыли окна \(mark)")
            } else {
                print("окна уже закрыты")
            }
        case .unLoad:
            if volumeTrunkFilled == 0 {
                print("груза нет\nобъём груза в кузове - \(volumeTrunkFilled) литров\n")
            } else if (volumeTrunkFilled - (volumeTrunk/100*50)) < 0{
                print("на 50% от общего объёма кузова разгрузить нельзя\nобъём груза в кузове - \(volumeTrunkFilled) литров\n")
            } else {
                volumeTrunkFilled = volumeTrunkFilled - (volumeTrunk/100*50)
                print("разгрузили \(mark) на 50% от общего объёма кузова\nобъём груза в кузове - \(volumeTrunkFilled) литров\n")
            }
        case .upLoad:
            if volumeTrunkFilled == volumeTrunk {
                print("больше не влезет\nобъём груза в кузове - \(volumeTrunkFilled) литров\n")
            } else {
                volumeTrunkFilled = volumeTrunkFilled + (volumeTrunk/100*25)
                print("загрузили \(mark) на 25% от общего объёма кузова\nобъём груза в кузове - \(volumeTrunkFilled) литров\n")
            }
        }
    }
}
var Ta4ka = Car(); var rpy3oBuk = Truck()

print("\n\(Ta4ka.info)\n\n\(rpy3oBuk.info)\n")

Ta4ka.action(.upLoad)
Ta4ka.action(.engineOn)
Ta4ka.action(.windowsDown)
print("\n\(Ta4ka.info)\n")

rpy3oBuk.action(.unLoad)
rpy3oBuk.action(.engineOff)
rpy3oBuk.action(.windowsUp)
print("\n\(rpy3oBuk.info)\n")
