import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:first/views/admin/side_bar_left/side_bar_left.dart';

import 'package:first/models/project.dart';

import 'package:first/services/firebase_service.dart';

@Component(selector: 'trash-bar',
    templateUrl: 'trash_bar.html',
    styleUrls: const ['trash_bar.css']
)
class TrashBar {

  final FirebaseService fbService;

  TrashBar(FirebaseService this.fbService);

  void expandTrash() {
    querySelector('trash-bar').classes.toggle('expand');
    querySelector('.trash-icon-wrapper').classes.toggle('expand');
  }
}