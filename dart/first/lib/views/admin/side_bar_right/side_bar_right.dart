import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:first/views/admin/main_app/main_app.dart';

import 'package:markdown/markdown.dart' as markdown;


import 'package:first/models/project.dart';
import 'package:first/services/firebase_service.dart';

//import '../../services/firebase_service.dart';

@Component(selector: 'side-bar-right',
    templateUrl: 'side_bar_right.html',
    styleUrls: const ['side_bar_right.css'],
    providers: const [SideBarRight, MainApp]
)
class SideBarRight implements AfterViewInit {
  @Input()
  Project project;

  final FirebaseService fbService;
  final MainApp mainApp;

  String layoutClass = 'layout_img';
  bool projectVisible = true;


  SideBarRight(
      FirebaseService this.fbService,
      MainApp this.mainApp
      );

  updateProject(key) async {

    if (key!=null) {
      Element spinScreen = querySelector('.spinning-screen');
      spinScreen.classes.add('is-loading');

      String newContent;
      String newContentHtml;

      TextAreaElement contentText = querySelector('#textbox$key');
      newContent = contentText.value;
      newContentHtml = markdown.markdownToHtml(newContent);
      print(newContentHtml);
      await fbService.updateProject(key, newContent, newContentHtml, layoutClass, projectVisible);

      spinScreen.classes.remove('is-loading');

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

  void toggleVisibility(event) {
    projectVisible = event.target.checked;
  }

  void ngAfterViewInit() {
    layoutClick();
    mainApp.checkForTooltip();
  }
}
