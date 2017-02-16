import 'package:first/models/image.dart';

const String name = "name";
const String contentTextMD = "contentTextMD";
const String contentTextHtml = "contentTextHtml";
const String hasParent = "hasParent";
const String parentId = "parentId";
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
  String parentId;
  bool hasChildren;
  String layoutClass;
  List<Image> imageList;
  bool isVisible;
  bool isDeleted;
  String key;

  Project(
    this.name,
    [this.contentTextMD,
    this.contentTextHtml,
    this.hasParent,
    this.parentId,
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
    "parentId": parentId,
    "hasChildren": hasChildren,
    "layoutClass": layoutClass,
    "imageList": imageList,
    "isVisible": isVisible,
    "isDeleted": isDeleted
  };

}