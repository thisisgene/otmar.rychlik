import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';

import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'side-bar-left',
    templateUrl: 'side_bar_left.html',
    styleUrls: const ['side_bar_left.css'],
    providers: const [ProjectService]
)
class SideBarLeft implements OnInit {

  bool isClassVisible = false;

  String title = 'Otmar Rychlik';
  List<Project> projects;

  Project selectedProject;

  final ProjectService _projectService;
  SideBarLeft(this._projectService);


  Future<Null> getProjects() async {
    print('jafj');
    projects = await _projectService.getProjects();
    print(projects);
  }

  void ngOnInit() {
    getProjects();
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