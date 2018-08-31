#OC弱引用容器

在OC中Foundation框架中的常用容器类（NSSet，NSDictionary，NSArray）及其可变子类在加入元素时，均会对元素进行强引用。但有的时候我们希望有对应的弱引用容器使用，比如：持有多个Delegate对象时。
##1、容器本身支持弱引用
Foundation框架中有3个本身支持弱引用的容器：
>1、NSHashTable-对应NSMutebleSet
>
>2、NSMapTable-对应NSMutebleDictionary
>
>3、NSPointerArray-对应NSMutebleArray

这3个容器本身都是可变的，没有不可变父类。	
其共同点是addObject方法参数声明为nullable即不用判断是否为nil来避免崩溃，而且若存储对象释放后，不用手动移除，对象的弱引用会自动从容器中移除。	

且都拥有初始化方法- (instancetype)initWithOptions:(NSPointerFunctionsOptions)options，options代表其所支持的放入对象的指针管理选项。可以指定弱指针。还可以指定是否添加成员变量的时候复制成员。

	
可以随意的存储指针并且利用指针的唯一性来进行hash同一性检查（检查成员变量是否有重复）和对比操作（equal）。

<注意>测试发现，对象释放后，容器中的对象引用会移除，但count貌似不对😳，暂时不清楚为啥。

缺点：性能相比对应强引用容器在性能上有所欠缺。（待测试）

##2、CFFoundation框架里对应容器类自定义内存管理选项
使用CFFoundation里的容器类实现后转成Foundation对象
>例如可变数组：(__bridge_transfer NSMutableArray *）CFMutableArrayRef CFArrayCreateMutable(CFAllocatorRef allocator, CFIndex capacity, const CFArrayCallBacks *callBacks); 这样生成的数组可以通过设置callBacks来决定数组对象的内存管理方式、copyDescription和hash。设置为nil时，加入或者移除对象则不会对队形的retainCount进行操作，可以当做对象的弱引用容器使用。

<注意>测试发现，此方法生成的容器，在容器中的对象已经释放后，容器依然会持有对象的地址，若使用过程中不加判断会引起野指针的错误，慎用。可参考的解决办法是定义强引用容器的分类用作弱引用容器，自定义容器生成、添加、移除方法，通过给弱引用队形动态绑定中间对象检测该弱引用队形的释放时机，释放时自动从容器中移除该弱引用对象。参考git开源项目：[OCWeakContainer](https://github.com/Nemocdz/OCWeakContainer)

##3、间接存储弱引用对象
###1、使用NSValue，初始化时使用nonretainedObjectValue方法。
###2、使用block持有对象的若引用，若对象释放，block则返回nil。

此方法没办法使用容器的泛型进行约束和警告，需要的对象销毁后也不能自动释放容器中的对象，使用时需要依次判断。

##小结：
如果弱引用容器使用不频繁，且存储的数据量不大的话，使用Foundation框架提供的容器是完全OK的，如果对性能要求很高的话可以结合辅助对象自定义一个容器的分类。
