import 'dart:async';

import 'package:angular2/core.dart';

import 'package:first/models/project.dart';
import 'mock_projects.dart';

@Injectable()
class ProjectService {
  Future<List<Project>> getProjects() async => mockProjects;
}
