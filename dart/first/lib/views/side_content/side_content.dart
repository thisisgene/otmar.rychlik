import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'dart:async';
import 'dart:html';

import 'package:first/models/project.dart';
import 'package:first/services/fb_no_user_service.dart';
import 'package:first/views/center_content/center_content.dart';

@Component(selector: 'side-content',
    templateUrl: 'side_content.html',
    styleUrls: const ['side_content.css'],
    directives: const [ROUTER_DIRECTIVES, CenterContent],
    providers: const [ROUTER_PROVIDERS]
)
class SideContent {

  List<Project> projects;
  Project selectedProject;

  final FbNoUserService fbService;
  SideContent(this.fbService);

  @Output() EventEmitter<String> myEvent = new EventEmitter();

  void selectProject(project) {
    myEvent.emit(project);
    print(project.name);
  }

  void onSelect(Project project) {
    selectedProject = project;
  }

  void goBack(id) {
    print(id);
  }

}

