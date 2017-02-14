import 'dart:async';

import 'dart:html';
import 'dart:math';

import 'package:dnd/dnd.dart';

import 'package:angular2/angular2.dart';
import 'package:first/views/admin/project_content/project_content.dart';

import 'package:first/models/project.dart';
import 'package:first/services/firebase_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'side-bar-left',
    templateUrl: 'side_bar_left.html',
    styleUrls: const ['side_bar_left.css'],
    directives: const [ProjectContent]
)
class SideBarLeft implements OnInit {

  bool isClassVisible = false;

  String title = 'Otmar Rychlik';

  List<Project> projects;
  Project selectedProject;



  @Output() EventEmitter<String> myEvent = new EventEmitter();


  void addProject(type, {project}) {

    InputElement projectInput = querySelector('.add-project-input');
    String projectName = projectInput.value;
    print(projectName);
    if (projectName != '') {

      String parentKey = '';
      String parentName = '';

      bool hasParent = false;
      if (type != 'main') hasParent = true;
      if (project != null) {
        parentKey = project.key;
        parentName = project.name;
      }
      fbService.addProject(projectName, hasParent, parentKey, parentName);
      print('hallo das ist '+projectName);
    }
  }

  void deleteProject(key) {
    Element project = querySelector("#project$key");
    project.remove();
    fbService.deleteProject(key);
  }

  void selectProject(project) {
    myEvent.emit(project);
  }


  void listenToClick() {

    querySelector('.project-list').onClick.listen((MouseEvent e) {

      Element target = e.target;
      if (target.classes.contains('project-element')){
        querySelectorAll('.active').classes.remove('active');
        target.classes.add('active');

      }
      if (target.classes.contains('icon-hasChildren')){
        target.parent.parent.classes.toggle('is-open');
      }
    });
  }


  void addSubProject(Project project, Element thisElement) {
    Element projectElement = thisElement.parent;
    InputElement nameInput = new InputElement();
    projectElement.children.add(nameInput);
  }

  final FirebaseService fbService;

  SideBarLeft(FirebaseService this.fbService);

//
//  final ProjectService _projectService;
//  SideBarLeft(this._projectService);
//
//
//  Future<Null> getProjects() async {
//    projects = await _projectService.getProjects();
//  }

  void ngOnInit() {
//    getProjects();
    listenToClick();
  }

  void onSelect(Project project) {
    selectedProject = project;
  }


//  void makeActive() {
//    querySelectorAll('li')
//      ..onClick.listen((event) => clickList(event, 'hallo'));
//    print(querySelectorAll('li'));
//
//  }
//
//  void clickList(MouseEvent mouseEvent, String s) {
//    print(s);
//  }
//


}

//TODO: adding, editing and removing projects