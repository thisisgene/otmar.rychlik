import 'dart:async';

import 'package:angular2/core.dart';
import 'package:first/views/app_header/app_header.dart';
import 'package:first/views/side_bar_left/side_bar_left.dart';
import 'package:first/models/project.dart';
import 'package:first/services/project_service.dart';



@Component(
    templateUrl: 'main_app.html',
    selector: 'main-app',
    styleUrls: const ['main_app.css'],
    directives: const [SideBarLeft, AppHeader],
    providers: const [ProjectService])
class MainApp {



}

