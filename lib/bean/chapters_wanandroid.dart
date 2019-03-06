class Chapters_wanandroid {



  String errorMsg;
  int errorCode;
  List<DataListBean> data;

  static Chapters_wanandroid fromMap(Map<String, dynamic> map) {
    Chapters_wanandroid chapters_wanandroid = new Chapters_wanandroid();
    chapters_wanandroid.errorMsg = map['errorMsg'];
    chapters_wanandroid.errorCode = map['errorCode'];
    chapters_wanandroid.data = DataListBean.fromMapList(map['data']);
    return chapters_wanandroid;
  }

  static List<Chapters_wanandroid> fromMapList(dynamic mapList) {
    List<Chapters_wanandroid> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class DataListBean {



  String name;
  bool userControlSetTop;
  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;

  static DataListBean fromMap(Map<String, dynamic> map) {
    DataListBean dataListBean = new DataListBean();
    dataListBean.name = map['name'];
    dataListBean.userControlSetTop = map['userControlSetTop'];
    dataListBean.courseId = map['courseId'];
    dataListBean.id = map['id'];
    dataListBean.order = map['order'];
    dataListBean.parentChapterId = map['parentChapterId'];
    dataListBean.visible = map['visible'];
    return dataListBean;
  }

  static List<DataListBean> fromMapList(dynamic mapList) {
    List<DataListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
