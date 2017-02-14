import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:first/views/admin/app_header/app_header.dart';
import 'package:first/views/admin/side_bar_left/side_bar_left.dart';
import 'package:first/views/admin/project_content/project_content.dart';
import 'package:first/views/admin/side_bar_right/side_bar_right.dart';
import 'package:first/views/admin/trash_bar/trash_bar.dart';
import 'package:first/models/project.dart';
import 'package:first/models/tooltip.dart';

import 'package:first/services/tooltip_service.dart';
import 'package:first/services/firebase_service.dart';


@Component(
    templateUrl: 'main_app.html',
    selector: 'main-app',
    styleUrls: const ['main_app.css'],
    directives: const [AppHeader, SideBarLeft, ProjectContent, SideBarRight, TrashBar],
    providers: const [FirebaseService, TooltipService]
)



class MainApp implements AfterViewInit {

  Project selectedProject;

  List<Tooltip> tooltips;

  var isLoading = false;

  void getId(Project project) {
    if (fbService.user!=null) {
      selectedProject = project;

    }
    print('hallo jetzt wissen wirs');
  }

  isItLoading(status) {
    isLoading = status;
    print(isLoading);
  }

  void checkForTooltip() {
    getTooltips();
    Element infoHeader = querySelector('.info-header');
    Element infoText = querySelector('.info-text');

    querySelectorAll('.has-tooltip').onMouseEnter.listen((MouseEvent e) {

      Element tooltipElement = e.target;
      String tooltipName = tooltipElement.dataset['tooltip'];
      tooltips.forEach((element) {
        if (element.name == tooltipName) {
          infoHeader.text = element.header;
          infoText.setInnerHtml(element.content, treeSanitizer: new NullTreeSanitizer());
        }
      });
    });
  }

  final FirebaseService fbService;
  final TooltipService tooltipService;
  MainApp(FirebaseService this.fbService, TooltipService this.tooltipService);

//
  Future<Null> getTooltips() async {
    tooltips = await tooltipService.getTooltips();
    print(tooltips);
  }
//
  void ngAfterViewInit() {

  }

}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}