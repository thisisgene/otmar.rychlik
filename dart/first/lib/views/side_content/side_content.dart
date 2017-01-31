import 'package:angular2/angular2.dart';

import 'dart:async';

import 'dart:html';


import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';
import 'package:first/views/center_content/center_content.dart';

@Component(selector: 'side-content',
    templateUrl: 'side_content.html',
    styleUrls: const ['side_content.css'],
    directives: const [CenterContent],
    providers: const [ProjectService]
)
class SideContent implements OnInit {

  List<Project> projects;

  final ProjectService _projectService;
  SideContent(this._projectService);

  Future<Null> getProjects() async {
    projects = await _projectService.getProjects();
  }

  @Output() EventEmitter<String> myEvent = new EventEmitter();

  void selectProject(project) {
    myEvent.emit(project);
    print(project.name);
  }

  void listenToClick() {

    querySelector('.menu-list').onClick.listen((MouseEvent e) {

      Element target = e.target;
      ElementList allProjects = querySelectorAll('.project-element');

      if (target.classes.contains('project-element')){
        querySelectorAll('.active').classes.remove('active');
        target.classes.add('active');


        for (Element project in allProjects) {
          print(project);
          if (project != target) {
            project.parent.parent.classes.add('hidden');
          }
        }

      }
      if (target.classes.contains('icon-hasChildren')){
        target.parent.parent.classes.toggle('is-open');
      }
    });
  }

  void goBack(id) {
    print(id);
  }

  void ngOnInit() {
    getProjects();
    listenToClick();
  }

}

