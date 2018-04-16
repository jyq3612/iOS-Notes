#OC泛型
泛型可以让你使用定义的类型来编写灵活的、可重用的函数和类型,可以避免重复，以清晰，抽象的方式表达其意图。泛型给予我们更抽象的封装函数或类的能力，不严谨的来讲，一门语言越抽象使用越方便。

声明一个Generics的格式如下：
>
>@interface 类名 <占位类型名称>
>
>@end

若不加入类型限制，则表示接受任意id类型。例如：
>@interface MBCollection<__covariant T>: NSObject
>
>@property (nonatomic, readonly) NSMutableArray  *elements;
>
>-(void)addObject:(T)object;
>
>-(BOOL)insertObject:(T)object atIndex: (NSUInteger)index;
>
>@end

其中T为我们提前声明好的占位类型名称，可自定义(如ObjectType等等)，需注意的是该T的作用域只限于@interface MBCollection到@end之间,至于泛型占位名称之前的修饰符则可分为两种：__covariant（协变）和 __contravariant（逆变）

两者的区别如下：
__covariant意为协变，意思是指子类可以强制转转换为(超类)父类，遵从的是SOLID中的L即里氏替换原则，大概可以描述为： 程序中的对象应该是可以在不改变程序正确性的前提下被它的子类所替换的。
__contravariant意为逆变，意思是指父类可以强制转为子类。

在上面这个例子中，声明属性时，还可以在泛型前添加__kindof关键词，表示其中的类型为该类型或者其子类。

