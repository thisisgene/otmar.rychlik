import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:first/views/side_bar_left/side_bar_left.dart';

import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'side-bar-right',
    templateUrl: 'side_bar_right.html',
    styleUrls: const ['side_bar_right.css'],
    providers: const [SideBarRight]
)
class SideBarRight implements OnInit {
  @Input()
  Project project;

  void layoutClick(){
    querySelector('.layout-wrapper').onClick.listen((MouseEvent e) {
      Element target = e.target;
      if (!target.classes.contains('layout__active')) {
        querySelectorAll('.layout__active').classes.remove('layout__active');
        target.parent.classes.add('layout__active');

//        if (target.classes.contains('menu-item__text')) {
//          querySelector('.text-wrapper').classes.add('visible');
//          querySelector('.img-wrapper').classes.remove('visible');
//        }
//        else if (target.classes.contains('menu-item__img')) {
//          querySelector('.text-wrapper').classes.remove('visible');
//          querySelector('.img-wrapper').classes.add('visible');
//        }
      }
    });
  }

  void ngOnInit() {
    layoutClick();
  }
}
