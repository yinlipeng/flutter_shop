import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/net/dio_manager.dart';
import 'package:flutter_shop/api/common_service.dart';
import 'dart:io';
import '../config/service_url.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../bean/chapters_wanandroid.dart';
import 'new_page.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),
      elevation: 0.0,),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
                future: getHomePageContent(),
                builder: ( context,  snapshot){
                  if(snapshot.hasData){
                    var data = json.decode(snapshot.data.toString());
                    List<Map> swipe = (data['data']['slides'] as List).cast();
                    List<Map> categoryList = (data['data']['category'] as List).cast();
                    String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'] ;
                    String leaderImage = data['data']['shopInfo']['leaderImage'] ;
                    String leaderPhone = data['data']['shopInfo']['leaderPhone'] ;
                    List<Map> recommendList = (data['data']['recommend'] as List).cast();
                    String pictureAddress1 = data['data']['floor1Pic']['PICTURE_ADDRESS'] ;
                    String pictureAddress2 = data['data']['floor2Pic']['PICTURE_ADDRESS'] ;
                    String pictureAddress3 = data['data']['floor3Pic']['PICTURE_ADDRESS'] ;
                    List<Map> floor1 = (data['data']['floor1'] as List).cast();
                    List<Map> floor2 = (data['data']['floor2'] as List).cast();
                    List<Map> floor3 = (data['data']['floor3'] as List).cast();


                    return  SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SwipeWidge(swipe),
                          CategoryWidget(categoryList),
                          AdBanner(adPicture),
                          ShopInfoWidget(leaderImage, leaderPhone),
                          RecommendWidget(recommendList),
                          FloorPicWidget(pictureAddress1),
                          FloorWidget(floor1),
                          FloorPicWidget(pictureAddress2),
                          FloorWidget(floor2),
                          FloorPicWidget(pictureAddress3),
                          FloorWidget(floor3),
                        ],
                      ),
                    );

                  }else{
                    return Center(child: Text('数据为空'),);
                  }
                }),
           
          ],
        ),
      ),
    );
  }

  /**
   * 获取首页数据
   */
  Future getHomePageContent() async {
    try {
      print('开始获取首页数据...............');
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded");
      var formData = {'lon': '115.02932', 'lat': '35.76189'};
      response = await dio.post(servicePath['homePageContext'], data: formData);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      return print('ERROR:======>${e}');
    }
  }

}
/**
 * 轮播图
 */
class SwipeWidge extends StatelessWidget {
  final List swipeDataList;

  SwipeWidge(this.swipeDataList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(330),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
          itemCount: swipeDataList.length,
          itemBuilder: (context,index){
            return Image.network('${swipeDataList[index]['image']}',fit: BoxFit.fill,);
          },
        autoplay: true,
        pagination: SwiperPagination(),
        onTap: (index){
            print(index);
        },
      ),
    );
  }
}
/**
 * 商品类别
 */
class CategoryWidget extends StatelessWidget {
final  List categoryList;

CategoryWidget(this.categoryList);

Widget _buildItem(BuildContext context,item){
  return InkWell(
    onTap: (){print('点击了导航');},
    child: Column(
      children: <Widget>[
        Image.network(item['image'],width:ScreenUtil().setWidth(95)),
        Text(item['mallCategoryName'])
      ],
    ),
  );

}

@override
  Widget build(BuildContext context) {

     if(categoryList.length > 10){
       categoryList.removeRange(10, categoryList.length);
     }

    return Container(
      height: ScreenUtil().setHeight(330),
      padding:EdgeInsets.all(3.0),
      child: GridView.count(
          crossAxisCount: 5,
          children: categoryList.map((item){
              return _buildItem(context, item);
            }).toList(),
      ),
    );
  }
}
/**
 * 广告
 */
class AdBanner extends StatelessWidget {
  final String adPicture;


  AdBanner(this.adPicture);

  @override
  Widget build(BuildContext context) {
    return Image.network(adPicture);
  }
}
/**
 * 店长信息
 */
class ShopInfoWidget extends StatelessWidget {
  final String leadImage;
  final String leadPhone;

  ShopInfoWidget(this.leadImage, this.leadPhone);

   void _launchURL() async {
     print('==========================');
     String url = 'tel:'+leadPhone;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Image.network(leadImage),
    );
  }
}
/**
 * 商品推荐
 */
class RecommendWidget extends StatelessWidget {
  List recommendList;

  RecommendWidget(this.recommendList);
  Widget _buildRecommendText(){
    return Container(

      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(width:0.5,color:Colors.black12)
        )
      ),
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 5.0),
      child: Text('商家推荐',style: TextStyle(color: Colors.pink),),
    );

  }

  Widget _item( index){
    return Container(
      height: ScreenUtil().setHeight(330),
      width: ScreenUtil().setWidth(250),
      padding: EdgeInsets.all(8.0),
      decoration:BoxDecoration(
          color:Colors.white,
          border:Border(
              left: BorderSide(width:0.5,color:Colors.black12)
          )
      ),
      child: Column(
        children: <Widget>[
          Image.network('${recommendList[index]['image']}'),
          Text('${recommendList[index]['mallPrice']}'),
          Text('${recommendList[index]['price']}',
            style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black12),

          ),

        ],
      ),
    );

  }

  Widget _buildList(BuildContext context){
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context,index){
            return _item(index);
          }),
    );
  }


  @override
  Widget build(BuildContext context) {
    recommendList.add(recommendList[0]);

    return  Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _buildRecommendText(),
          _buildList(context)
        ],

      ),
    );
  }


}

class FloorPicWidget extends StatelessWidget {
  final String floorPicUrl;

  FloorPicWidget(this.floorPicUrl);

  @override
  Widget build(BuildContext context) {
    return Image.network(floorPicUrl );
  }
}

class FloorWidget extends StatelessWidget {
  final List floorList;


  FloorWidget(this.floorList);

  Widget _buildFirstFloor(){
    return Row(
      children: <Widget>[
        Image.network('${floorList[0]['image']}',width: ScreenUtil().setWidth(375),),
        Expanded(child: Column(
          children: <Widget>[
            Image.network('${floorList[1]['image']}'),
            Image.network('${floorList[2]['image']}'),
          ],
        ))


      ],
    );
  }
  Widget _buildSecondFloor(){
    return Row(
      children: <Widget>[
        Expanded(child:  Image.network('${floorList[3]['image']}')),
        Expanded(child:  Image.network('${floorList[4]['image']}')),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildFirstFloor(),
        _buildSecondFloor()
      ],

    );
  }
}









