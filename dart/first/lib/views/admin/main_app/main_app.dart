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
import 'package:first/services/project_service.dart';
import 'package:first/services/tooltip_service.dart';


@Component(
    templateUrl: 'main_app.html',
    selector: 'main-app',
    styleUrls: const ['main_app.css'],
    directives: const [AppHeader, SideBarLeft, ProjectContent, SideBarRight, TrashBar],
    providers: const [ProjectService, TooltipService])



class MainApp implements OnInit{

  Project selectedProject;


  List<Tooltip> tooltips;

  Tooltip currentTooltip;

  void getId(Project project) {
    selectedProject = project;
  }


  void checkForTooltip() {
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

  final TooltipService _tooltipService;
  MainApp(this._tooltipService);

  Future<Null> getTooltips() async {
    tooltips = await _tooltipService.getTooltips();
  }

  void ngOnInit() {
    checkForTooltip();
    getTooltips();
  }

}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}