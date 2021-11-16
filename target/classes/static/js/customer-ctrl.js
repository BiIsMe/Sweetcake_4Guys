app.controller("customer-ctrl",function($scope,$http){
	$scope.customers = [];
	$scope.form = {};  	// form for create new
	$scope.form.gender = true;
	$scope.gender= '';
	$scope.shopping = '';
	$scope.begin = 0;
	$scope.limit = 7;
	$scope.totalPage = 0;
	$scope.pageIndex = 1;
	
	//initial
	$scope.initial = function(){
		//load staff
		$http.get("/rest/account/customer").then(resp => {
			$scope.customers = resp.data;
			//get order list
			$scope.customers.forEach(cust => {
				$http.get(`/rest/order/account/${cust.username}`).then(resp => {
					cust.orderList = resp.data;
					if(cust.orderList.length > 0)
						cust.shopping = true;
					else
						cust.shopping = false;
				})
			})
			
			$scope.totalPage = Math.ceil($scope.customers.length / $scope.limit);
		})
	}
	
	$scope.initial();
	
	//update staff
	$scope.updateCust = function(item){
		var ok = confirm("Do you want to change status of "+item.username);
		if(ok){
			$http.put(`/rest/account/staff/${item.username}`,item).then(resp => {
				var index = $scope.customers.findIndex( cust => cust.username = item.username);
				$scope.customers[index] = item;
				alert("success");
			}).catch(error => {
				alert("fail");
				console.log("Error :",error);
			});
		}
	}
	
	//create Staffs
	$scope.createStaff = function(){
		alert("success");
		var item = angular.copy($scope.customers[0]);
		$http.get(`/rest/order/account/${item.username}`).then(resp => {
			item.orderList = resp.data;
		})
		console.log(item);
	}
	
	$scope.reset = function(){
		$scope.form = {};
		$scope.form.gender = true;
	}
	
	
	/* paging */
	
	//first
	$scope.first = function(){
		$scope.pageIndex  = 1;
		$scope.begin = 0;
	}
	
	//next
	$scope.next = function(){
		if($scope.pageIndex < $scope.totalPage){
			$scope.begin = $scope.pageIndex * 7;
			$scope.pageIndex += 1;		
		}
	}
	
	//prev
	$scope.prev = function(){
		if($scope.pageIndex > 1){
			$scope.pageIndex -= 1;		
			$scope.begin = ($scope.pageIndex-1) * 7;	
		}
	}
	
	//last
	$scope.last = function(){
		$scope.pageIndex = $scope.totalPage;
		$scope.begin = ($scope.totalPage-1) * 7;
	}
	
	
});