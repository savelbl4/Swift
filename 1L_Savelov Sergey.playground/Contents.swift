import Cocoa
// задание 1
//объявляем коэффициенты
var a : Float = 1, b : Float = 2, c : Float = 1
//объявляем корни
var x : Float = 0, x1 : Float = 0, x2 : Float = 0
//собираем уравнение в строку
var eq : String = "\(a)(x^2)+\(b)x+\(c)=0"
//находим дискриминант
var D = pow(b,2)-(4*a*c)
if D < 0 {
    print("Уравнение \(eq) не имеет корней")
} else if D == 0 {
    x = -b/(2*a)
    print("У уравнение \(eq) один корень\n x=\((Int)(x))")
} else {
    x1 = (-b - sqrt(D))/(2*a)
    x2 = (-b + sqrt(D))/(2*a)
    print("У уравнение \(eq) два кореня\n x1=\((Int)(x1))\n x2=\((Int)(x2))")
}
// задание 2
//объявляем катеты
var ab: Float = 15, ac: Float = 25
//находим гипотенузу
var bc = sqrt(pow(ab,2)+pow(ac, 2))
//площадь
var S = (ab*ac)/2
//периметр
var P = ab+ac+bc
print("\nПлощадь S=\(S)\nПериметр P=\(P)")
// задание 3
// объявляем сумму и процент
var dep : Float = 600, per : Float = 13
// объявляем срок
var years = 5
var i = 1
while i <= years {
    dep = dep + dep*per/100
    i += 1
}
print("\nСумма вклада через \(years) лет равна \(dep)")
