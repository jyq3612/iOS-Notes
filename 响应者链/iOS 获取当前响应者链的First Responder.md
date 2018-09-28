# iOS 获取当前响应者链的First Responder


此文章转载[此篇](https://www.jianshu.com/p/84c0eddf2378)

此处的关键是以下方法：

	- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event

当target为nil时，app会自动发消息给first responder，然后沿着响应者链条进行查找，直到找到能响应action的responder。此解决方案的思路是创建responder的一个分类，当需要获取first responder时，调用以上方法，并设置target为nil，此时使用静态全局变量将能响应该消息的responder记录下来即就是要找的first responder；