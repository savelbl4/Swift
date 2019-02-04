//var ik = [0,1,2,3,4,5,6,7,8,9,10]
var x = ""
// задание 1
func task01(_ a: Int) -> String{
    if a % 2 == 0 {
        return "true"//чётное
    }
    return "false"
}
x = task01(6)
print(x)
// задание 2
func task02(_ a: Int) -> String{
    if a % 3 == 0 {
        return "true"//делится
    }
    return "false"
}
x = task02(2)
print(x)
// задание 3
var Arr = Array<Int>()
for i in 0...99 {
    Arr.append(i)
}
print(Arr)
// задание 4
func task04(array: [Int]){
    Arr.removeAll()
    for i in array where task01(i) == "false" {
        Arr.append(i)
    }
    let _Arr = Arr
    Arr.removeAll()
    for i in _Arr where task02(i) == "true" {
        Arr.append(i)
    }
    print(Arr)
}
task04(array: Arr)
// задание 5
var cci: Array<Float> = [1, 1]
while cci.count < 100 {
    cci.append(cci[cci.count-1]+cci[cci.count-2])
}
print(cci)
// задание 6
var intj: Array<Int> = [2]
var simp = Array<Int>()
//заполняем массив положительными числами
while intj.count < 1000 {
    intj.append(intj[intj.count-1]+1)
}
//выбираем простые числа из массива
func _simp(array: [Int]){
    intj.removeAll()
    let p = array[0]
    simp.append(p)
    for i in 1...(array.count-1) where array[i] % p != 0 {
        intj.append(array[i])
    }
}
while simp.count < 100 {
    _simp(array: intj)
}
print(simp)
