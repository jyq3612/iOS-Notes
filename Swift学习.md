Swift中常见的关键字

1、inout :
将值类型的对象用引用的方式传递。我们经常说的值类型和引用类型实际上就是指对象的传递方式分别为按值传递和按地址传递。这个关键词只用于参数修饰，也就是用在函数传参上。
2、defer
：修饰一段函数内任一段代码，使其必须在函数中的其余代码都执行完毕，函数即将结束前调用。可以理解成将延迟执行。 defer的执行只和其所在的作用域有关，如果作用域即将被收回，那么会在作用域结束之前执行defer。如果有多个defer，不一定是按写的顺序执行。
3、throws
：在可能出现异常的函数或者方法后面添加throws。
经过这个关键字修饰的函数，在调用的时候，需要程序员加上do-catch来调用。
4、guard
：此关键词和if的作用类似。if表示成立的条件，而guard-else则表示如果guard成立则继续往下执行，不然执行else中的代码。
5、if let
：if let关键字是一个组合关键字。我们主要使用它解决Optional对象解包时产生空对象的处理。对一个空对象赋值是不允 许的，因此，在赋值之前需要判断这个对象的值是不是空的，如果不是空的，才进行赋值，否则会出现错误。而这个组合关键词就是为了解决这个问题的。
6、if case
：if case主要用于模式匹配，跟switch类似，区别在于if case只需要对关注的可能值进行判断。可以认为是if的特殊用 法吧，此处判断使用 = 作为判断的符号

7、if case let
：类似与if case和let的组合。适用于复杂枚举的单个匹配。



swift中的枚举可以定义为复杂的结构，即枚举值可以关联其他的变量
enum CarBrand{
    case  BMW(name:String,Production:String)
    case  AUDI(name:String,Production:String)
    case  BENZ(name:String,Production:String)
}


swift 中集合类型的高阶函数
1、map 遍历数组，可以对数组中的每一个元素做一次处理
2、flatMap 与map类似，但返回后的数组中不存在nil，同时它会把Optional解包；flatMap还能把数组中的数组打开变成一个新的数组
3、filter 过滤，可以对数组中的元素做一次过滤，返回NO则会被过滤掉
4、reduce 计算，有接受一个参数，可以用于数组元素按照指定规则拼接