class Test {

  /**
   * downloadURL : "http://statics.bjoil.com/mobile/mobile/onekey_addoil.apk"
   * buildVersionNo : "692"
   * buildVersion : "6.9.2"
   */

  String downloadURL;
  String buildVersionNo;
  String buildVersion;

  static Test fromMap(Map<String, dynamic> map) {
    Test test = new Test();
    test.downloadURL = map['downloadURL'];
    test.buildVersionNo = map['buildVersionNo'];
    test.buildVersion = map['buildVersion'];
    return test;
  }

  static List<Test> fromMapList(dynamic mapList) {
    List<Test> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}
