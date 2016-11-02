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
    querySelector('.menu-selection').onClick.listen((MouseEvent e) {
      Element target = e.target;
      if (!target.classes.contains('menu-item__active')) {
        querySelectorAll('.menu-item__active').classes.remove('menu-item__active');
        target.classes.add('menu-item__active');

        if (target.classes.contains('menu-item__text')) {
          querySelector('.text-wrapper').classes.add('visible');
          querySelector('.img-wrapper').classes.remove('visible');
        }
        else if (target.classes.contains('menu-item__img')) {
          querySelector('.text-wrapper').classes.remove('visible');
          querySelector('.img-wrapper').classes.add('visible');
        }
      }
    });
  }

  void ngOnInit() {
    menuClick();
  }
}