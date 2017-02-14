import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:first/views/admin/side_bar_left/side_bar_left.dart';

import 'package:first/models/project.dart';
import 'package:first/services/firebase_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'side-bar-right',
    templateUrl: 'side_bar_right.html',
    styleUrls: const ['side_bar_right.css'],
    providers: const [SideBarRight]
)
class SideBarRight implements OnInit {
  @Input()
  Project project;

  final FirebaseService fbService;

  String layoutClass = 'layout_img';

  SideBarRight(FirebaseService this.fbService);

  void updateProject(key) {
    if (key!=null) {
      String newContent;
      TextAreaElement contentText = querySelector('#textbox$key');
      newContent = contentText.value;
      fbService.updateProject(key, newContent, layoutClass);
    }
  }

  void layoutClick(){
    Element layoutWrapper = querySelector('.layout-wrapper');

    layoutWrapper.onClick.listen((MouseEvent e) {
      Element target = e.target;
      Element layoutElement = target.parent;
      if (!target.classes.contains('layout__active')) {
        querySelectorAll('.layout__active').classes.remove('layout__active');
        target.parent.classes.add('layout__active');
        layoutClass = layoutElement.dataset['tooltip'];

      }
    });
  }

  void ngOnInit() {
    layoutClick();
  }
}
