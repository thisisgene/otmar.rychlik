import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:uuid/uuid.dart';

import 'package:first/models/project.dart';
import 'package:first/models/image.dart';


@Injectable()
class FbNoUserService {
  fb.Auth _fbAuth;
  fb.Database _fbDatabase;
  fb.Storage _fbStorage;
  fb.DatabaseReference _fbRefProjects;
  fb.DatabaseReference _fbRefImages;

  fb.User user;

  List<Project> projects;
  List<Image> images;

  var uuid = new Uuid();


  FbNoUserService() {
    fb.initializeApp(
        apiKey: "AIzaSyAr0Syw8nfvs79Yd6w42pX3ley3KFecDNs",
        authDomain: "otmar-rychlik.firebaseapp.com",
        databaseURL: "https://otmar-rychlik.firebaseio.com",
        storageBucket: "otmar-rychlik.appspot.com"
    );
    _fbAuth = fb.auth();
    _fbAuth.signInAnonymously().then((user) {
      _fbAuth.onAuthStateChanged.listen(_authChanged);

    });


    _fbDatabase = fb.database();
    _fbRefProjects = _fbDatabase.ref("projects");
    _fbRefImages = _fbDatabase.ref("images");

    _fbStorage = fb.storage();
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;
    if (user != null) {
      projects = [];

      _fbRefProjects.onChildAdded.listen(_newProject);
      print('heyhou');
    }

  }

  Future _newProject(fb.QueryEvent event) async {
    String key = event.snapshot.key;
    var val = event.snapshot.val();
//    print(val[isDeleted]);
    if (!val[isDeleted] && val[isVisible]) {
      Project project = new Project(
          val[name],
          val[contentTextMD],
          val[contentTextHtml],
          val[hasParent],
          val[parentId],
          val[hasChildren],
          val[layoutClass],
          val[imageList],
          val[lastEdit],
          val[isVisible],
          val[isDeleted],
          key);
      await projects.add(project);
      print(project.name);

    }
//    print(projects);
  }

}