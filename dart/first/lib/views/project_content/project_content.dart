import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:first/views/side_bar_left/side_bar_left.dart';

import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'project-content',
    templateUrl: 'project_content.html',
    styleUrls: const ['project_content.css'],
    providers: const [ProjectService]
)
class ProjectContent implements OnInit {

  @Input()
  Project project;

  void menuClick(){
    querySelectorAll('.menu-item').onClick.listen((MouseEvent e) {
      Element target = e.target;
      print('hallo');
    });
  }

  void ngOnInit() {
    menuClick;
  }
}