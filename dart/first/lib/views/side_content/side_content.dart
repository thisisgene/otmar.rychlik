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
    directives: const [ROUTER_DIRECTIVES, CenterContent]
)
//@RouteConfig(const [
//  const Route(path: '/site/:key', name: 'Site', component: CenterContent)
//])


class SideContent {

  List<Project> projects;
  Project selectedProject;

  final FbNoUserService fbService;
//  final RouteParams _routeParams;
  SideContent(this.fbService);



  @Output() EventEmitter<String> myEvent = new EventEmitter();

  void selectProject(project, key) {
    myEvent.emit(project);
    LIElement li_project = querySelector('#li$key');
    li_project.classes.add('active');
    querySelector('.back-arrow').classes.add('show');
  }

  void onSelect(Project project) {
    selectedProject = project;


  }

  void goBack() {
    window.history.back();
  }

}

