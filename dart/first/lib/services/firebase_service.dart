import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

import 'package:first/models/project.dart';


@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.Database _fbDatabase;
  fb.Storage _fbStorage;
  fb.DatabaseReference _fbRefProjects;

  fb.User user;

  List<Project> projects;


  FirebaseService() {
    fb.initializeApp(
        apiKey: "AIzaSyAr0Syw8nfvs79Yd6w42pX3ley3KFecDNs",
        authDomain: "otmar-rychlik.firebaseapp.com",
        databaseURL: "https://otmar-rychlik.firebaseio.com",
        storageBucket: "otmar-rychlik.appspot.com"
    );
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);

    _fbDatabase = fb.database();
    _fbRefProjects = _fbDatabase.ref("projects");

    _fbStorage = fb.storage();
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;
    if (user != null) {
      projects = [];

      _fbRefProjects.onChildAdded.listen(_newProject);

    }
  }

  void _newProject(fb.QueryEvent event) {
    String key = event.snapshot.key;
    var val = event.snapshot.val();
    Project project = new Project(val[name], val[contentTextMD], val[contentTextHtml], val[hasParent], val[hasChildren], val[layoutClass], val[imageList], val[isVisible], val[isDeleted], key);
    projects.add(project);
  }



  Future addProject(String name, bool hasParent, String parentId, String parentName) async {
    try {
      Project project = new Project(name, null, null, hasParent, false, "layout_img", [], true, false);
      await _fbRefProjects.push(project.toMap());
    }
    catch (error) {
      print("$runtimeType::addProject() -- $error");
    }
  }

  Future updateProject(String key, String newContent, String newContentHtml, String layoutClass, bool isVisible) async {
    try {
      await _fbRefProjects.child(key).update({
        "contentTextMD"   : newContent,
        "contentTextHtml" : newContentHtml,
        "layoutClass"     : layoutClass,
        "isVisible"       : isVisible
      });

    } catch (e) {
      print("Error in deleting $key: $e");
    }

//    TODO: Updating without refreshing
  }

  Future deleteProject(key) async {
    print(key);
    try {
      await _fbRefProjects.child(key).update({"isDeleted": true});
      _fbRefProjects.onChildAdded.listen(_newProject);
    } catch (e) {
      print("Error in deleting $key: $e");
    }
  }

  Future uploadImage(File file, Project project) async {
    saveImageToProject(file.name, project.key);

//    print(file.name);
//    fb.StorageReference fbRefImage =
//    _fbStorage.ref("${project.name}/${new DateTime.now()}/${file.name}");
//
//    print(fbRefImage);
//
//
//    fb.UploadTask task =
//    fbRefImage.put(file, new fb.UploadMetadata(contentType: file.type));
//
//    StreamSubscription sub;
//
//    sub = task.onStateChanged.listen((fb.UploadTaskSnapshot snapshot) {
//      print("Uploading Image -- Transfered ${snapshot.bytesTransferred}/${snapshot.totalBytes}...");
//
//      if (snapshot.bytesTransferred == snapshot.totalBytes) {
//        sub.cancel();
//      }
//    }, onError: (fb.FirebaseError error) {
//      print(error.message);
//    });
//
//    try {
//      fb.UploadTaskSnapshot snapshot = await task.future;
//
//      if (snapshot.state == fb.TaskState.SUCCESS) {
//        saveImageToProject(file.name, project.key);
//      }
//    } catch (error) {
//      print(error);
//    }
  }

  Future saveImageToProject(String filename, String key) async {
    var projectRef = _fbRefProjects.child(key).startAt(priority: (snapshotPriority == null) ? null : snapshotPriority).limit(pageSize+1);
    await projectRef.once('value').then((snapshot) {
      snapshot.forEach((itemSnapshot) {
        print(itemSnapshot);
      });
    });

    //    try {
//      await _fbRefProjects.child(key);
//
//    } catch (e) {
//      print("Error in deleting $key: $e");
//    }
  }


  Future signIn(email, password) async {
    try {
      await _fbAuth.signInWithEmailAndPassword(email, password);
    }
    catch (error) {
      print("$runtimeType::login() -- $error");
      window.alert('Email oder Passwort falsch!');
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }
}