# iOS传值方法小结

iOS 对象间传值常用的方式有：property赋值、delegate、KVO、block、多态、通知。除此之外，记录另外三种传值方式。

## 1、基于responder传值

此方法适用于action的传递。如果页面视图层级复杂，拆分出来的视图层级过多，可将action添加至respond上，app会沿着响应者链进行查找，找到第一个能响应该消息的Respond，将事件进行分发。

**使用方法：**	
1、如果使用xib或者storyboard，则需要在合适的地方添加响应的IBAction方法，然后直接连线至first Respond找到该方法即可。		
2、如果使用代码添加时间，可使用以下方法：

	- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event

该方法当target设置为nil时，会将此事件加到响应者链中，从first Respond依次查找能响应该消息的Respond。

此方法缺点在于不是很明确sender和action，特别在使用代码添加的时候，后续维护比较困难。

## 2、基于ResponderChain传值

此方法参考[这篇文章](https://casatwy.com/responder_chain_communication.html)

**实现思路：**		
当前responder可以通过nextResponder方法获取响应者链中的下一个responder对象。通过此方法可以添加一个responder的分类方法，并且默认实现是调用nextResponder的该分类方法，如果需要在某一层级的responder上实现action，则可以重写该分类方法，否则调用nextResponder的分类方法，如此实现了传值。

## 3、基于协议和弱引用指针的传值
此方法是为了解决对象属性变化从而更新多个模块设计的，设计之初用于列表中同一个id的数据对象变化，从而刷新该对象关联的所有UI。而后扩展到管理类的数据分发，即管理类管理n多个对象和m多个状态，一个对象变化后可能引起许多个对象的变化，因此使用弱指针容器管理n多个对象，若需要更新的时候，则遍历弱指针容器，调用协议方法，将对象的变法分发到各个对象中去。

实现可参考示例代码。


## 4、基于runtime关联对象传值
在使用过程中，我觉着此方法实际的使用价值在于临时保存数据对象，而不再传值。

**使用方法：**
1、引入头文件#import <objc/runtime.h>
2、使用objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)将value关联到对象object上去，key可看做是此关联的名字，policy指关联采用的协议。
3、通过objc_getAssociatedObject(id _Nonnull object, const void * _Nonnull key)取出对象object关联的value值。