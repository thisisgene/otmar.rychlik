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

  bool listReady = false;

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

  Future _authChanged(fb.AuthEvent event) async {
    user = event.user;
    if (user != null) {
      projects = [];


    }

  }

  Future<List<Project>> getAllProjects() async {
    _fbRefProjects.onChildAdded.listen(_newProject);
//    _fbRefProjects.onValue.listen((fb.QueryEvent event){
//      fb.DataSnapshot snap = event.snapshot;
//      snap.forEach((s) {
//
//        var val = s.val();
//        var key = s.key;
//        print(val[name]);
//        if (!val[isDeleted] && val[isVisible]) {
//          Project project = new Project(
//              val[name],
//              val[urlName],
//              val[contentTextMD],
//              val[contentTextHtml],
//              val[hasParent],
//              val[parentId],
//              val[parentName],
//              val[hasChildren],
//              val[layoutClass],
//              val[imageList],
//              val[lastEdit],
//              val[isVisible],
//              val[isDeleted],
//              key);
//          projects.add(project);
//        }
//
//      });
//    });
//    print("All $projects");
//    return(projects);
  }

  _newProject(fb.QueryEvent event) {
    String key = event.snapshot.key;
    var val = event.snapshot.val();
//    print(val[isDeleted]);
    if (!val[isDeleted] && val[isVisible]) {
      Project project = new Project(
          val[name],
          val[urlName],
          val[contentTextMD],
          val[contentTextHtml],
          val[hasParent],
          val[parentId],
          val[parentName],
          val[hasChildren],
          val[layoutClass],
          val[imageList],
          val[lastEdit],
          val[isVisible],
          val[isDeleted],
          key);
      projects.add(project);

    }
    listReady = true;
  }

  getProject(String key) {
    Project my_project;
//    await _fbRefProjects.child(key).once('value').then((fb.QueryEvent event) {
//      var val = event.snapshot.val();
//      my_project = new Project(
//          val[name],
//          val[urlName],
//          val[contentTextMD],
//          val[contentTextHtml],
//          val[hasParent],
//          val[parentId],
//          val[parentName],
//          val[hasChildren],
//          val[layoutClass],
//          val[imageList],
//          val[lastEdit],
//          val[isVisible],
//          val[isDeleted],
//          key);
//    });
    projects.forEach((project) {
      if (project.key==key) my_project = project;
    });
    return(my_project);
  }

  Future<List<Project>> getChildren(key) async {
    List<Project> childProjects = [];

    await projects.forEach((project) {
      if(project.parentId == key) {
        childProjects.add(project);
      }
    });
    return childProjects;
  }

  Future<List<Image>> getImages(key) async {
    images = [];
    _fbRefImages.onValue.listen((fb.QueryEvent event) {
      fb.DataSnapshot snap = event.snapshot;
      snap.forEach((s) {
        var val = s.val();
        print(val[parentId]);
        print(key);
        if (val[imgParent] == key) {
          print(key);
          Image image = new Image(
              val[imgId],
              val[imgName],
              val[imgPath],
              val[imgParent]

          );
          images.add(image);
        }
      });
      print(images);
    });

    return(images);

  }

}