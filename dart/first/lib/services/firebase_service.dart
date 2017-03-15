import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import 'package:first/models/project.dart';
import 'package:first/models/image.dart';


@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.Database _fbDatabase;
  fb.Storage _fbStorage;
  fb.DatabaseReference _fbRefProjects;
  fb.DatabaseReference _fbRefImages;

  fb.User user;

  List<Project> projects;
  List<Image> images;

  var uuid = new Uuid();


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
    _fbRefImages = _fbDatabase.ref("images");

    _fbStorage = fb.storage();
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;
    if (user != null) {
      projects = [];

      _fbRefProjects.onChildAdded.listen(_newProject);
//      _fbRefProjects.onChildChanged.listen(_newProject);        make it happen!

    }
  }

  void _newProject(fb.QueryEvent event) {
    String key = event.snapshot.key;
    var val = event.snapshot.val();
    Project project = new Project(val[name], val[urlName], val[contentTextMD], val[contentTextHtml], val[hasParent], val[parentId], val[parentName], val[hasChildren], val[layoutClass], val[imageList], val[lastEdit], val[isVisible], val[isDeleted], key);
    projects.add(project);
    print(projects.length);
  }



  Future addProject(String name, bool hasParent, String parentId, String parentName) async {

    var formatter = new DateFormat('dd.MM.yyyy');

    var sani = const HtmlEscape();
    String urlName = Uri.encodeComponent(name);

    String currentDate = formatter.format(new DateTime.now());
    try {
      Project project = new Project(name, urlName, null, null, hasParent, parentId, parentName, false, "layout_menu", [], currentDate, true, false);
      await _fbRefProjects.push(project.toMap());
    }
    catch (error) {
      print("$runtimeType::addProject() -- $error");
    }
  }

  Future addImage(Image newImage) async {
    try {

      await _fbRefImages.push(newImage.toMap());
    }
    catch (error) {
      print("$runtimeType::addProject() -- $error");
    }
  }

  Future updateProject(String key, String newName, String newContent, String newContentHtml, String layoutClass, bool isVisible) async {
    var formatter = new DateFormat('dd.MM.yyyy');
    String currentDate = formatter.format(new DateTime.now());
    try {
      await _fbRefProjects.child(key).update({
        "name"            : newName,
        "contentTextMD"   : newContent,
        "contentTextHtml" : newContentHtml,
        "layoutClass"     : layoutClass,
        "lastEdit"        : currentDate,
        "isVisible"       : isVisible
      });

    } catch (e) {
      print("Error in deleting $key: $e");
    }

//    TODO: Updating without refreshing
  }

  Future projectHasChild(String key, bool doesIt, subName, bool hasParent, String parentKey, String parentName) async {
    try {
      await _fbRefProjects.child(key).update({
        "hasChildren" : doesIt

      });
      print(doesIt);
      addProject(subName, hasParent, parentKey, parentName);
    } catch (e) {
      print(e);
    }
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

  Future buildImage(val) async{

    try {

        Image img = new Image(val[imgId], val[imgName], val[imgPath], val[imgParent]);
        images.add(img);
        print(val[imgName]);

    } catch (e){
      print(e);

    }
  }

  Future getImages(String parentKey) async {
    var imgRef;
    var i = 0;
    images = [];


    _fbRefImages.onChildAdded.listen((e) {
      fb.DataSnapshot snapshot = e.snapshot;
      var val = snapshot.val();
      if (val[imgParent] == parentKey) {
        buildImage(val);
      }
    });


    try {
//    await findImage(imgRef);

    } catch (e) {
      print(e);
    }


  }

  Future uploadImage(File file, Project project) async {
    String fileName = file.name;
    String fileId = uuid.v1();
    String filePath = "img/${fileId}/${fileName}";

    fb.StorageReference fbRefImage = _fbStorage.ref(filePath);



    fb.UploadTask task =
    fbRefImage.put(file, new fb.UploadMetadata(contentType: file.type));

    StreamSubscription sub;

    sub = task.onStateChanged.listen((fb.UploadTaskSnapshot snapshot) {
      print("Uploading Image -- Transfered ${snapshot.bytesTransferred}/${snapshot.totalBytes}...");

      if (snapshot.bytesTransferred == snapshot.totalBytes) {
        sub.cancel();
      }
    }, onError: (fb.FirebaseError error) {
      print(error.message);
    });

    try {
      fb.UploadTaskSnapshot snapshot = await task.future;

      if (snapshot.state == fb.TaskState.SUCCESS) {
        saveImageToProject(fileId, fileName, snapshot.downloadURL.toString(), project.key);
      }
    } catch (error) {
      print(error);
    }
  }

  Future saveImageToProject(String fileId, String fileName, String path, String key) async {
    var projectRef = _fbRefProjects.child(key);
    Image newImage = new Image(fileId, fileName, path, key);
    addImage(newImage);
    try {
      await projectRef.once('value').then((e) {
        var val = e.snapshot.val();
        List imgList = val[imageList];
        if (imgList!=null) {
          imgList.add(fileId);

        }
        else {
          imgList = [fileId];
        }
        projectRef.update({"imageList": imgList});
      });

    } catch (e) {
      print("Error $key: $e");
    }

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