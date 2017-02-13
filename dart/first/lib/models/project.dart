//class Project {
//  String id;
//  String name;
//  bool hasParent;
//  String parentId;
//  String parentName;
//  bool hasChildren;
//  List childIds;
//  int typeOfLayout;
//  String contentTextMD;
//  String contentTextHtml;
//  String lastEdit;
//  bool isVisible;
//  bool isDeleted;
//  String key;
//
//
//
//  Project(
//      this.id,
//      this.name,
//      [this.hasParent,
//      this.parentId,
//      this.parentName,
//      this.hasChildren,
//      this.childIds,
//      this.typeOfLayout,
//      this.contentTextHtml,
//      this.contentTextMD,
//      this.lastEdit,
//      this.isVisible,
//      this.isDeleted,
//      this.key]
//      );
//
//  Project.fromMap(Map map) : this(
//      map['id'],
//      map['name'],
//      map['hasParent'],
//      map['parentId'],
//      map['parentName'],
//      map['hasChildren'],
//      map['childIds'],
//      map['typeOfLayout'],
//      map['contentTextHtml'],
//      map['contentTextMD'],
//      map['lastEdit'],
//      map['isVisible'],
//      map['isDeleted'],
//      map['key']
//
//  );
//
//  Map toMap() => {
//    "id": id,
//    "name": name,
//    "hasParent": hasParent,
//    "parentId": parentId,
//    "parentName": parentName,
//    "hasChildren": hasChildren,
//    "childIds": childIds,
//    "typeOfLayout": typeOfLayout,
//    "contentTextHtml": contentTextHtml,
//    "contentTextMD": contentTextMD,
//    "lastEdit": lastEdit,
//    "isVisible": isVisible,
//    "isDeleted": isDeleted
//  };
//
//}

const String name = "name";
const String contentTextMD = "contentTextMD";
const String contentTextHtml = "contentTextHtml";
const String hasParent = "hasParent";
const String hasChildren = "hasChildren";
const String layoutClass = "layoutClass";
const String isVisible = "isVisible";
const String isDeleted = "isDeleted";

class Project {
  String name;
  String contentTextMD;
  String contentTextHtml;
  bool hasParent;
  bool hasChildren;
  String layoutClass;
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
    "isVisible": isVisible,
    "isDeleted": isDeleted
  };

}