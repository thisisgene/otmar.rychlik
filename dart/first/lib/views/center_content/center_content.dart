import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';

import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'center-content',
    templateUrl: 'center_content.html',
    styleUrls: const ['center_content.css'],
    providers: const [ProjectService]
)
class CenterContent implements OnInit {

  @Input()
  Project project;

  void getProject() {
    print("das ist ein prepij");
  }

  void ngOnInit() {
    getProject();
  }

}