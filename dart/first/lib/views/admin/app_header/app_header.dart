import 'dart:async';

import 'dart:html';

import 'package:angular2/angular2.dart';

import 'package:first/services/firebase_service.dart';

@Component(selector: 'app-header',
    templateUrl: 'app_header.html',
    styleUrls: const ['app_header.css']
)
class AppHeader {
  final FirebaseService fbService;

  AppHeader(FirebaseService this.fbService);

  void signIn() {
    InputElement emailInput = querySelector("#useremail");
    InputElement passwordInput = querySelector("#password");
    String email = emailInput.value;
    String password = passwordInput.value;
    fbService.signIn(email, password);
  }
}


// TODO Login, auth, etc.