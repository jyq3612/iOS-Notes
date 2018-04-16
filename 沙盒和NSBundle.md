#沙盒和NSbundle
沙盒时文件系统，而bundle是目录结构。
## 沙盒
>iOS中的沙盒机制是一种安全体系。每个iOS程序都有一个独立的文件系统（存储空间），而且只能在对应的文件系统中进行操作，此区域被称为沙盒。应用必须待在自己的沙盒里，其他应用不能访问该沙盒。所有的非代码文件都要保存在此，例如属性文件plist、文本文件、图像、图标、媒体资源等。沙盒是用来存入缓冲区的，APP关掉，缓存被自动清理。

###1、沙盒目录结构
>1、/AppName.app 应用程序的程序包目录，包含应用程序的本身。此目录不能修改.

>2、/Documents/ 保存应用程序的重要数据文件和用户数据文件等。用于下载的数据基本都存贮在这里。该文件夹会在应用程序更新的时候自动备份，连接iTunes也会备份。

>3、/Library 这个目录下有两个子目录：/Library/Caches(缓存)和/Library/Preferences（偏好)。Caches保存应用程序使用时产生的支持文件和缓存文件，不会被备份，并且可能会被其他工具清理掉数据。Preferences保存应用程序的偏好文件（如NSUserDefaults和plist文件），此文件不应手动创建，连接iTunes会自动备份。
此目录下还可以自己创建子文件夹。

>4、/tmp/ 保存应用运行时所需要的临时数据，该路径下的文件不会被iTunes备份。手机重启时，该目录文件会被自动清除。例如录制的视频就是默认存在该目录下，需要手动转移到相册中，负责会被自动清除。

###2、访问沙盒
直接访问
>[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/"];  ///Caches目录
...

通过NSSearchPathForDirectoriesInDomains方法访问
> NSString*docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]

## NSBundle
bundle 是一个目录，其中包含了程序会使用到的资源，这些资源包含了图像，声音，编译好的代码，nib文件。
### 通过bundle访问资源
>通过[NSBundle mainBundle]访问系统默认的bundle，也可以通过path访问其他的bundle。
>访问bundle中的资源可以通过pathForResource: ofType:方法。
>访问bundle中的类：Class A = [bundle classNamed:@"A"]或者[bundle principalClass]
>通过bundle访问应用的详细信息：[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]///版本号 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]///应用名称
