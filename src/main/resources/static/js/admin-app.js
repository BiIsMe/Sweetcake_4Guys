 app = angular.module("adminApp", ["ngRoute","chart.js"]);

app.controller("myctrl",function($scope,$http){
	$scope.indexUser = {};
	$scope.username = '';
	$scope.indexName = '';
	
	$scope.initial = function(){
		username = localStorage.getItem("username");
		
		$http.get(`/rest/account/${username}`).then(resp =>{
			$scope.indexUser = resp.data;
			$scope.indexUser.dob = new Date($scope.indexUser.dob);
			$scope.indexName = resp.data.fullname;
		})
	}
	
	$scope.initial();
	
	$scope.logout = function(){
		localStorage.removeItem("username");
	}
	
	
	
});

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
		.when("/chart", {
          templateUrl: "/admins/chart/index.html",
          	controller : "chart-ctrl"
      })
		.when("/profile", {
          templateUrl: "/admins/profile/index.html",
          	controller : "profile-ctrl"
      })
		.when("/home", {
          templateUrl: "/admins/home.html"
      });
  });


