// задание 1
func task01(_ a: Int) -> Bool{
    return a % 2 == 0
}
print(task01(7))
// задание 2
func task02(_ a: Int) -> Bool{
    return a % 3 == 0
}
print(task02(9))
// задание 3
var Arr = Array<Int>()
for i in 0...99 {
    Arr.append(i)
}
print(Arr)
// задание 4
func task04(array: [Int]){
    Arr.removeAll()
    for i in array where task01(i) == false {
        Arr.append(i)
    }
    let _Arr = Arr
    Arr.removeAll()
    for i in _Arr where task02(i) == true {
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
