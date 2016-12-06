import 'dart:async';

import 'dart:html';

import 'package:dnd/dnd.dart';

import 'package:angular2/angular2.dart';
import 'package:first/views/project_content/project_content.dart';

import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'side-bar-left',
    templateUrl: 'side_bar_left.html',
    styleUrls: const ['side_bar_left.css'],
    directives: const [ProjectContent],
    providers: const [ProjectService]
)
class SideBarLeft implements OnInit {

  bool isClassVisible = false;

  String title = 'Otmar Rychlik';

  List<Project> projects;
  Project selectedProject;



  @Output() EventEmitter<String> myEvent = new EventEmitter();

  main() {
    // Install same elements as draggable and dropzone.
    Draggable draggable = new Draggable(querySelectorAll('.sortable'),
        avatarHandler: new AvatarHandler.clone());

    Dropzone dropzone = new Dropzone(querySelectorAll('.sortable'));

    // Swap elements when dropped.
    dropzone.onDrop.listen((DropzoneEvent event) {
      print('asdf');
      swapElements(event.draggableElement, event.dropzoneElement);
    });
  }

  void selectProject(project) {
    myEvent.emit(project);
  }



  void swapElements(Element elm1, Element elm2) {
    print('isdragged');
    var parent1 = elm1.parent;
    var next1   = elm1.nextElementSibling;
    var parent2 = elm2.parent;
    var next2   = elm2.nextElementSibling;

    parent1.insertBefore(elm2, next1);
    parent2.insertBefore(elm1, next2);
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

  final ProjectService _projectService;
  SideBarLeft(this._projectService);


  Future<Null> getProjects() async {
    projects = await _projectService.getProjects();
  }

  void ngOnInit() {
    getProjects();
    listenToClick();
  }

  void onSelect(Project project) {
    selectedProject = project;
  }


  //  void addClassOpen(MouseEvent e) {
//    print('detail=${e.detail}');
//    print('offset=${e.offset}');
//    print('client=${e.client}');
//    print('layer=${e.layer}');
//    print('screen=${e.target}');
//  }

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