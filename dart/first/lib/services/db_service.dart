import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
//import 'package:mongo_dart/mongo_dart.dart';

import 'package:uuid/uuid.dart';

import 'package:first/models/project.dart';
import 'package:first/models/image.dart';



@Injectable()
class DbService {
  Db db = new Db("mongodb://accountAdmin:sVr!sf_6D2d-7zzMP@zR~cMd@localhost:27017/rychlik");
  var pro = new Project("Harry", "aasd").toMap();

  DbService() {



  }
  Future initDb() async {
    print('ahoi!');
    var colProjects = db.collection('project');
    await db.open();
    await colProjects.insert(pro);
    return('huch');
  }
}

