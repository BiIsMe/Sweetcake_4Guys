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
      .when("/areaShip", {
          templateUrl: "/admins/areaShip/index.html",
          	controller : "areaShip-ctrl"
      })
      .when("/staff", {
          templateUrl: "/admins/staffAccount/index.html",
          	controller : "staff-ctrl"
      })
      .when("/voucher", {
          templateUrl: "/admins/coupon/index.html",
          	controller : "coupon-ctrl"
      })
      .when("/customer", {
          templateUrl: "/admins/customer/index.html",
          	controller : "customer-ctrl"
      })
		.when("/unauthorize", {
          templateUrl: "bst/lucyen.html"
      })
		.when("/home", {
          templateUrl: "/admins/home.html"
      });
  });
