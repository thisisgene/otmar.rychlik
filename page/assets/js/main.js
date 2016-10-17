angular.module('sampleApp', ['ngRoute', 'appRoutes', 'MainCtrl', 'ProjectCtrl', 'ProjectService']);


angular.module('appRoutes', []).config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {

	$routeProvider

		// home page
		.when('/', {
			templateUrl: 'partials/home',
			controller: 'MainController'
		})

		.when('/projects', {
			templateUrl: 'partials/project',
			controller: 'ProjectController'
		})


	$locationProvider.html5Mode(true);

}]);
