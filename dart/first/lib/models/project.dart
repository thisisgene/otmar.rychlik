import 'package:first/models/image.dart';

const String name = "name";
const String urlName = "urlName";
const String contentTextMD = "contentTextMD";
const String contentTextHtml = "contentTextHtml";
const String hasParent = "hasParent";
const String parentId = "parentId";
const String parentName = "parentName";
const String hasChildren = "hasChildren";
const String layoutClass = "layoutClass";
const String imageList = "imageList";
const String lastEdit = "lastEdit";
const String isVisible = "isVisible";
const String isDeleted = "isDeleted";

class Project {
  String name;
  String urlName;
  String contentTextMD;
  String contentTextHtml;
  bool hasParent;
  String parentId;
  String parentName;
  bool hasChildren;
  String layoutClass;
  List<Image> imageList;
  String lastEdit;
  bool isVisible;
  bool isDeleted;
  String key;

  Project(
    this.name,
    this.urlName,
    [this.contentTextMD,
    this.contentTextHtml,
    this.hasParent,
    this.parentId,
    this.parentName,
    this.hasChildren,
    this.layoutClass,
    this.imageList,
    this.lastEdit,
    this.isVisible,
    this.isDeleted,
    this.key]
  );

  Map toMap() => {

    "name": name,
    "urlName": urlName,
    "contentTextMD": contentTextMD,
    "contentTextHtml": contentTextHtml,
    "hasParent": hasParent,
    "parentId": parentId,
    "parentName": parentName,
    "hasChildren": hasChildren,
    "layoutClass": layoutClass,
    "imageList": imageList,
    "lastEdit": lastEdit,
    "isVisible": isVisible,
    "isDeleted": isDeleted
  };

}