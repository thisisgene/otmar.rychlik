import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:first/views/app_header/app_header.dart';
import 'package:first/views/side_content/side_content.dart';
import 'package:first/views/center_content/center_content.dart';
import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';


@Component(
    templateUrl: 'main_app.html',
    selector: 'main-app',
    styleUrls: const ['main_app.css'],
    directives: const [AppHeader, SideContent],
    providers: const [ProjectService]
)



class MainApp implements OnInit{

  Project selectedProject;


  void getId(Project project) {
    selectedProject = project;
  }

  void ngOnInit() {

  }

}