import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:flutter/animation.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //底部导航items
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon( Icons.home  ),
        title: Text('首页' )),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: Text('会员中心')),
  ];


//底部导航对应的页面
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

//当前页面的索引
  int currentIndex = 0;
  PageController _controller;


//  //当前页面
//  Widget currentPage ;
  @override
  void initState() {
//    currentPage = tabBodies[currentIndex];
    super.initState();
    _controller = PageController(initialPage: currentIndex);
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return WillPopScope(
        child: Scaffold(
          //整个页面的背景色
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),

          bottomNavigationBar: BottomNavigationBar(
            //底部导航样式 一般使用fixed  不常用shifting
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.blue,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                  _controller.animateToPage(currentIndex, duration: Duration(milliseconds: 200),curve: Curves.decelerate);
//                  currentPage = tabBodies[currentIndex];
                });
              },
              currentIndex: currentIndex,
              items: bottomTabs),
          body: PageView.builder(
              itemBuilder: (BuildContext context,index){
                return tabBodies[index];
              },
            controller: _controller,
            itemCount: tabBodies.length,
            onPageChanged: (index){
                setState(() {
                  currentIndex = index;
                });
            },
              )

//          IndexedStack(
//            index: currentIndex,
//            children: tabBodies,
//          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('提示'),
        content: new Text('确定退出应用吗？'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('再看一会' ),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('退出'),
          ),
        ],
      ),
    ) ?? false;
  }

}
