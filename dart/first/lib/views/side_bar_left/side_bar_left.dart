import 'dart:async';

import 'dart:html';
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
      if (target.classes.contains('icon')){
        target.parent.parent.classes.toggle('is-open');
      }
    });

  }

  void addClassOpen(MouseEvent e) {
    print('detail=${e.detail}');
    print('offset=${e.offset}');
    print('client=${e.client}');
    print('layer=${e.layer}');
    print('screen=${e.target}');
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

  void makeActive() {
    querySelectorAll('li')
      ..onClick.listen((event) => clickList(event, 'hallo'));
    print(querySelectorAll('li'));

  }

  void clickList(MouseEvent mouseEvent, String s) {
    print(s);
  }


}