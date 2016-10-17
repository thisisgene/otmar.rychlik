angular.module('appRoutes', []).config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {

  $routeProvider

    .when('/', {
      templateUrl: 'views/home.html',
      controller: 'MainController'
    })

    .when('/projects', {
      templateUrl: 'views/project.html',
      controller: 'ProjectController'
    });

  $locationProvider.html5Mode(true);

}]);
