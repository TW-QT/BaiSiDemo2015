---
title: 模仿百思不得姐项目开发总结
date: 2015-3-12
categories: iOS,原创
keywords: iOS项目,个人项目,百思不得姐,开发,流程,完整

---


# 模仿百思不得姐项目 开发总结

`申明:本篇博文内容属原创,如需转载请注明出处.`


项目Gif图如下：
![BaiSiDemo2015 GIF](ReadmeImages/BaiSiDemo2015.gif)

---

## 项目
首先做要准备好项目所需的资源.
项目资源与工具:
1.IPA文件:图片,图标,声音等资源
找到IPA包,用Zip解压,查看包里面的内容就可以找到自己想要的文件(例如:IPA中会有 tabBar,Navigation...)
2.利用Charles拦截API接口
3.利用Reveal分析UI


首先基本配置,然后搭建基本的骨架
项目的实现使用代码+xib实现

TFTabBarController -> 4个子控制器


---

### 基本配置
图片,启动图片,软件名称,目录结构
项目目录结构的整理:
1.资源文件放到Supporting Files里面
2.把图标放到AppIcon.
3.设置启动图片删除Launch Screen File中的初始设置,设置Launch images source->Migrate->Launchimages,然后将图片放入其中即可.暂时不适用,也可以删除Launchscreen.xib文件.
4.改变软件的显示名称,info.plist-> Bundle name ->改成产品名称即:百思不得姐
5.整个项目采用代码+xib的形式实现.不适用storyboard,所以可以删除main interface中的main.storyboard的配置,此时没有程序启动时没有可以加载的storyboard,要自己在appdelege中自己创建窗口,设置窗口的根控制器,然后显示窗口即可.


--- 

### 配置tabBar,自定义TFTabBarController
- UITabBarController设置为根窗口的根控制器,要向UITabBarController中添加子控制器,添加四个字控制器.设置子控制器的tabBarItem.title和tabBarItem.image.
- 这个项目中UITabBarController不能实现需求,所以在此我们要自定义自己的UITabBarController:TFTabBarController,将添加子控制器等操作封装到自定义的TFTabBarController里面.改变图片的rendering mode,保证图片不会被默认的渲染.设置tabBarItem的文字属性:NSForegroundColorAttributeName.
- 设置tabBarItem,`appearance`的使用(后面带有UI_APPEARANCE_SELECTOR的方法都可以通过appearance对象来统一设置).设置UITabBarItem的appearance,通过appearance统一设置所有UITabBarItem的文字属性
- tabBarItem的设置要在initialize中设置.
- TFTabBarController中添加子控制器的方法的重构,即初始化子控制器方法的封装.
- 4个子控制器外层包装一个导航控制器


### 自定义tabBar
按钮当前背景图片的尺寸currentBackgroundImage
设置中间按钮的位置要自定义TFTabBar,在TFTabBar的layoutSubviews中设置位置.此时更换tabBar时遇到只读时可以使用KVC实现.
在initWithFrame方法中添加中间的按钮,layoutSubviews中设置子控件的位置.

### 设置导航栏

```objc

self.title=@"我的关注";
//等价于
self.navigationItem.title=@"我的关注";
self.tabBarItem.title=@"我的关注";

```

---


### 创建UIBarButtonItem的分类

写个类方法快速返回一个对象,封装UIBarButtonItem的创建.


### 导航栏左边的返回按钮的统一设置
自定义导航控制器,拦截导航控制器的push方法.自定义导航控制器:TFNavigationController,重写pushViewController方法(调用super),在此方法中设置返回按钮的样式. 在这个方法中拦截所有push进来的控制器,push进入其他控制器时隐藏tabBar.[UINavigationBar appearance]方法的调用要放在initialize方法中.

### 关注模块
采用XIB的方式实现.设置Xib的file's owner.

#### 推荐关注的实现
用到SVProgressHUD,AFNetworking,SDWebImage
TFRecommandViewController用两个tableView实现,
自定义cell的setSelected方法要自己控制,出现什么样的结果可以在此方法中实现.左边的tableView显示推荐关注的内容的分类,右边的tableView显示左边tableView选中的tableView中的具体的cell分类的内容.
其中要解决的三个问题:
1.点击左边的cell重复发送请求,请求右边tableView的数据,造成用户流量的浪费.
- 如果右边曾经没有数据发送请求,如果有数据刷新表格直接显示.一个类别对应一个数据,在类别数据模型中加入一个可变的数组,用懒加载.解决问题1,把分类的右边的用户数据加到类别模型的数据中这样问题就很容易解决.
2.网络慢的情况的解决.
赶紧刷新右边表格数据(如果没有数据,刷新出的表格会是空的),以免显示旧的数据给用户造成假象
3.只能显示1页数据
添加网络请求参数,在底部添加一个footerView,此时回出现表格公用footerView的情况,要来回切换状态.
设置header,footer,以及header,footer中的方法实现网络数据的请求.下一页数据的请求要多下一页参数,这个数据要存在类别的数据模型中.这个项目的服务器返回的数据有问题,
- 每次刷新右边的数据时都控制右边的footer的显示或者隐藏
- 在block中控制刷新控件是否结束刷新状态

```objc
/**这个类别对应的用户数据*/
@property (nonatomic,strong)   NSMutableArray *users;

```

不同的网路请求进入block中时会出现很多复杂的情况,处理办法如下:

```objc
//处理不需要的请求,不是最后一次请求
if(_params!=params) return;

```

`特别注意退出控制器之前,要阻止请求回来,AFN发送的请求要用请求管理者(所有的请求都是他来管理)[]self.manager.operationQueue cancelAllOperations]`


####分页的两种实现方法
1.传页码
2.传ID(最后面的ID)




### 磨刀不误砍材工
1.该项目的类前缀:TF
2.项目目录的整理:采用MVC模式
3.PCH文件,项目名称,分类的导入
- Prefix header -> 设置路径





