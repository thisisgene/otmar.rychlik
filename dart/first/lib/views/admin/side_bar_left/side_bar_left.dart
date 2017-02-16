import 'dart:async';

import 'dart:html';

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
  bool subInputExist = false;
  String title = 'Otmar Rychlik';

  List<Project> projects;
  Project selectedProject;



  @Output() EventEmitter<String> myEvent = new EventEmitter();


  void addProject() {

    InputElement projectInput = querySelector('.add-project-input');
    String projectName = projectInput.value;
    if (projectName != '') {
      bool hasParent = false;
      String parentKey = '';
      String parentName = '';


      fbService.addProject(projectName, hasParent, parentKey, parentName);

    }
  }

  openDeleteDialog(Event e) {
    Element eli = e.target;
    eli.nextElementSibling.classes.add('box-active');
  }

  closeDeleteDialog(Event e) {
    Element eli = e.target;
    print(eli);
    eli.parent.parent.parent.parent.classes.remove('box-active');
  }

  deleteProject(key) async {
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

  Future submitSubProject(String name, Project project) {
    print(name);
  }

  void addSubProject(Project project, Event e) {
    if (!subInputExist) {
      String subName;
      Element thisElement = e.target;
      Element projectElement = thisElement.parent;
      InputElement nameInput = new InputElement();
      projectElement.children.add(nameInput);
      nameInput.focus();
      subInputExist = true;
      nameInput.onBlur.listen((_) {
        nameInput.remove();
        subInputExist = false;
      });
      nameInput.onKeyUp.listen((KeyboardEvent e) {
        subName = nameInput.value;
        if (e.keyCode == KeyCode.ENTER) {
          if (subName!='') {
            submitSubProject(subName, project);
            fbService.addProject(subName, true, project.key, project.name);
            fbService.projectHasChild(project.key, true);
          }
        }
        if (e.keyCode == KeyCode.ESC) {
          nameInput.remove();
          subInputExist = false;
        }
      });
    }
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