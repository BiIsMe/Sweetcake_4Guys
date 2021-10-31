 app = angular.module("adminApp", ["ngRoute"]);

 app.config(function ($routeProvider) {
      $routeProvider
      .when("/product", {
          templateUrl: "/admins/product/index.html",
			controller : "product-ctrl"
			
      })
      .when("/statistic", {
          templateUrl: "/admins/statistic/index.html",
			controller : "order-ctrl"
      })
      .when("/authorize", {
          templateUrl: "bst/lucyen.html"
      })
		.when("/unauthorize", {
          templateUrl: "bst/lucyen.html"
      })
		.when("/home", {
          templateUrl: "/admins/home.html"
      });
  });
