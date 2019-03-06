import 'package:flutter/material.dart';

import './pages/index_page.dart';
void main() => runApp(MyApp());
/**
 * 程序入口
 */
 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Container(
       child: MaterialApp(
         title: '百姓生活+',
         theme: ThemeData(

           //主题颜色
           primarySwatch: Colors.pink
         ),
         debugShowCheckedModeBanner: false,
         home: IndexPage(),
       ),
     );
   }
 }
