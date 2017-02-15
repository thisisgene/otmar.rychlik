const String imgId = "imgId";
const String imgName = "imgName";
const String imgPath = "imgPath";
const String imgParent = "imgParent";

class Image {
  final String imgId;
  String imgName;
  String imgPath;
  String imgParent;


  Image(
      this.imgId,
      this.imgName,
      this.imgPath,
      this.imgParent
      );

  Map toMap() => {
    "imgId": imgId,
    "imgName": imgName,
    "imgPath": imgPath,
    "imgParent": imgParent
  };
}
