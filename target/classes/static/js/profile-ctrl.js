app.controller("profile-ctrl",function($scope,$http){
	$scope.districts = [];

	//initial
	$scope.initial = function(){
		//load dist
		$http.get("/rest/district").then(resp => {
			$scope.districts = resp.data;

		})		
	}
	
	$scope.initial();
	
	//update dist
	$scope.updateDist = function(item){
		var ok = confirm("Do you want to change value of "+item.name);
		if(ok){
			$http.put(`/rest/district/${item.id}`,item).then(resp => {
				var index = $scope.districts.findIndex(dist => dist.id = item.id);
				$scope.districts[index] = item;
				alert("success");
			}).catch(error => {
				alert("fail");
				console.log("Error :",error);
			});
		}
	}
	
	
	
	$scope.order = {
		ship : '',
	}
	
	$scope.change = function(){
		var id = $scope.order.quan.id;
		alert(id);
		$http.get(`/rest/district/${id}`).then(resp => {
			$scope.order.ship = resp.data.shipfee;
		})
	}
	
});