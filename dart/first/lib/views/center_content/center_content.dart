import 'dart:html';
import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:first/models/project.dart';
import 'package:first/services/fb_no_user_service.dart';

import '../../services/fb_no_user_service.dart';

@Component(selector: 'center-content',
    templateUrl: 'center_content.html',
    styleUrls: const ['center_content.css'],
    directives: const [ROUTER_DIRECTIVES]
)
class CenterContent implements AfterContentInit {
  Project project;
  List<Project> childProjects;

  final FbNoUserService _fbService;
  final RouteParams _routeParams;
  final Location _location;

  CenterContent(this._fbService, this._routeParams, this._location);


  Future ngAfterContentInit() async {
    var key = _routeParams.get('key');
    print(key);

    if (key != null) {
      project = await _fbService.getProject(key);
      print(project);
      if (project?.hasChildren == true) {
        childProjects = await (_fbService.getChildren(key));
        print(childProjects);
      }
    }
  }


}