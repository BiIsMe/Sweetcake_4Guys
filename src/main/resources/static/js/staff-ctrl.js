app.controller("staff-ctrl",function($scope,$http){
	$scope.staffs = [];
	$scope.form = {};  	// form for create new
	$scope.form.gender = true;
	$scope.gender= '';
	$scope.begin = 0;
	$scope.limit = 7;
	$scope.totalPage = 0;
	$scope.pageIndex = 1;
	
	//initial
	$scope.initial = function(){
		//load staff
		$http.get("/rest/account/staff").then(resp => {
			$scope.staffs = resp.data;
			$scope.totalPage = Math.ceil($scope.staffs.length / $scope.limit);
		})
	}
	
	$scope.initial();
	
	//update staff
	$scope.updateStaff = function(item){
		var ok = confirm("Do you want to change value of "+item.username);
		if(ok){
			$http.put(`/rest/account/staff/${item.username}`,item).then(resp => {
				var index = $scope.staffs.findIndex( staff => staff.username = item.username);
				$scope.staffs[index] = item;
				alert("success");
			}).catch(error => {
				alert("fail");
				console.log("Error :",error);
			});
		}
	}
	
	//create Staffs
	$scope.createStaff = function(){
		$scope.form.active = true;
		$scope.form.dob = new Date();
		$scope.form.role = 'Staff';
		var item = angular.copy(this.form);
		$http.post("/rest/account/staff", item).then(resp => {
			alert("success");
			$scope.initial();
			$scope.reset();
		}).catch(error => {
			alert("fail");
			console.log("Error",error);
		})
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
			$scope.begin = $scope.pageIndex * $scope.limit;
			$scope.pageIndex += 1;		
		}
	}
	
	//prev
	$scope.prev = function(){
		if($scope.pageIndex > 1){
			$scope.pageIndex -= 1;		
			$scope.begin = ($scope.pageIndex-1) * $scope.limit;	
		}
	}
	
	//last
	$scope.last = function(){
		$scope.pageIndex = $scope.totalPage;
		$scope.begin = ($scope.totalPage-1) * $scope.limit;
	}
	
	
});