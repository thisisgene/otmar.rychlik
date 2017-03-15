import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:first/views/app_header/app_header.dart';
import 'package:first/views/side_content/side_content.dart';
import 'package:first/views/center_content/center_content.dart';
import 'package:first/views/spinner/spinner.dart';
import 'package:first/models/project.dart';
import 'package:first/services/fb_no_user_service.dart';



@Component(
    templateUrl: 'main_app.html',
    selector: 'main-app',
    styleUrls: const ['main_app.css'],
    directives: const [ROUTER_DIRECTIVES, AppHeader, SideContent, Spinner],
    providers: const [FbNoUserService]
)

@RouteConfig(const [
  const Route(path: '/', name: 'Index', component: SideContent),
  const Route(path: '/site/:key', name: 'Site', component: CenterContent)
])

class MainApp implements OnInit {


  Project selectedProject;

  final FbNoUserService fbService;
//  final RouteParams _routeParams;
  MainApp(this.fbService);

  void getId(Project project) {
    selectedProject = project;
  }

  void ngOnInit() {
    fbService.getAllProjects();
  }

}