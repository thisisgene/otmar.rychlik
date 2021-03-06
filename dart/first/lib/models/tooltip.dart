const String ttname = "name";
const String header = "header";
const String content = "content";

class Tooltip {
  final String id;
  String name;
  String header;
  String content;


  Tooltip(
    this.id,
    this.name,
    this.header,
    this.content
  );

  Map toMap() => {

    "name": name,
    "header": header,
    "content": content
  };
}