import 'package:angular2/core.dart';
import '../app_header/app_header.dart';

@Component(
    templateUrl: 'main_app.html',
    selector: 'main-app',
    styleUrls: const ['main_app.css'],
    directives: const [AppHeader])
class MainApp {}
