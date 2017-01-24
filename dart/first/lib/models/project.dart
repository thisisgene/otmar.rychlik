class Project {
  final String id;
  String name;
  bool hasParent;
  String parentId;
  String parentName;
  bool hasChildren;
  List childIds;
  int typeOfLayout;
  String contentTextMD;
  String contentTextHtml;
  String lastEdit;
  bool isVisible;
  bool isDeleted;


  Project(
      this.id,
      this.name,
      this.hasParent,
      this.parentId,
      this.parentName,
      this.hasChildren,
      this.childIds,
      this.typeOfLayout,
      this.contentTextHtml,
      this.contentTextMD,
      this.lastEdit,
      this.isVisible,
      this.isDeleted
      );
}