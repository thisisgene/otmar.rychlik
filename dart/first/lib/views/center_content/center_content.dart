import 'dart:html';
import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:first/models/project.dart';
import 'package:first/models/image.dart';
import 'package:first/services/fb_no_user_service.dart';

//import '../../services/fb_no_user_service.dart';

@Component(selector: 'center-content',
    templateUrl: 'center_content.html',
    styleUrls: const ['center_content.css'],
    directives: const [ROUTER_DIRECTIVES]
)
class CenterContent implements OnInit {
  Project project;
  List<Project> childProjects;
  List<Image> images;

  final FbNoUserService fbService;
  final RouteParams _routeParams;
  final Location _location;

  CenterContent(this.fbService, this._routeParams, this._location);

  Future getCurrentProject() async {
    var key = _routeParams.get('key');

    if (key != null) {
      project = await fbService.getProject(key);
      if (project?.hasChildren == true) {
        childProjects = await (fbService.getChildren(key));
        print("hallo child, $childProjects");
      }
      if (project?.imageList != null) {
        await fbService.getImages(key);
        images = await fbService.images;
      }
    }

    print("hallo $project");

  }

  void ngOnInit(){
    getCurrentProject();

  }

}