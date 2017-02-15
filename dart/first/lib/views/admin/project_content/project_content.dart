//import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:first/views/admin/side_bar_left/side_bar_left.dart';

import 'package:markdown/markdown.dart' as markdown;

import 'package:first/models/project.dart';
import 'package:first/services/firebase_service.dart';


@Component(selector: 'project-content',
    templateUrl: 'project_content.html',
    styleUrls: const ['project_content.css']
)
class ProjectContent implements OnInit {

  @Input()
  Project project;

  var preview_src;

  bool previewVisible = false;

  final FirebaseService fbService;
  ProjectContent(FirebaseService this.fbService);

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

  togglePreview(key) {
    TextAreaElement text = querySelector("#textbox$key");
    String newText = markdown.markdownToHtml(text.value);
    Element preview = querySelector('.preview-box');
    preview.setInnerHtml(newText, treeSanitizer: new NullTreeSanitizer());

    preview.classes.toggle('visible');
  }

  uploadImages(FileList files, Project project) {
    files.forEach((file) {
      fbService.uploadImage(file, project);
    });
  }



  void ngOnInit() {
    menuClick();
  }

}
class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}