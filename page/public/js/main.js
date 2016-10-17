angular.module("sampleApp",["ngRoute","appRoutes","MainCtrl","ProjectCtrl","ProjectService"]),angular.module("appRoutes",[]).config(["$routeProvider","$locationProvider",function(e,o){e.when("/",{templateUrl:"partials/home",controller:"MainController"}).when("/projects",{templateUrl:"partials/project",controller:"ProjectController"}),o.html5Mode(!0)}]);
//# sourceMappingURL=main.js.map
