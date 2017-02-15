const String name = "name";
const String contentTextMD = "contentTextMD";
const String contentTextHtml = "contentTextHtml";
const String hasParent = "hasParent";
const String hasChildren = "hasChildren";
const String layoutClass = "layoutClass";
const String imageList = "imageList";
const String isVisible = "isVisible";
const String isDeleted = "isDeleted";

class Project {
  String name;
  String contentTextMD;
  String contentTextHtml;
  bool hasParent;
  bool hasChildren;
  String layoutClass;
  List imageList;
  bool isVisible;
  bool isDeleted;
  String key;

  Project(
    this.name,
    [this.contentTextMD,
    this.contentTextHtml,
    this.hasParent,
    this.hasChildren,
    this.layoutClass,
    this.imageList,
    this.isVisible,
    this.isDeleted,
    this.key]
  );

  Map toMap() => {

    "name": name,
    "contentTextMD": contentTextMD,
    "contentTextHtml": contentTextHtml,
    "hasParent": hasParent,
    "hasChildren": hasChildren,
    "layoutClass": layoutClass,
    "imageList": imageList,
    "isVisible": isVisible,
    "isDeleted": isDeleted
  };

}