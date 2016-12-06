import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:first/views/side_bar_left/side_bar_left.dart';

import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'trash-bar',
    templateUrl: 'trash_bar.html',
    styleUrls: const ['trash_bar.css'],
    providers: const [TrashBar]
)
class TrashBar {

  void expandTrash() {
    querySelector('trash-bar').classes.toggle('expand');
  }
}