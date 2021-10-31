app.controller("order-ctrl",function($scope,$http){
	$scope.orderComplete = '';
	$scope.orders = [];
	$scope.order={};
	$scope.orderdetails=[];
	$scope.date={
		from : new Date(),
		to : new Date(),
		status :'all'
	};
	
	$scope.initial = function(){
		$http.get("/rest/order").then(resp =>{
			$scope.orders = resp.data;
			$scope.orders.forEach( item => {
				item.createdate = new Date(item.createdate);
			})
		});
	}
	
	$scope.initial();
	
	$scope.edit = function(item){
		$http.get(`/rest/orderdetails/${item.id}`).then(resp =>{
			$scope.orderdetails = resp.data;
			$scope.order = angular.copy(item);
			$scope.orderComplete = $scope.order.orderstatus ;
		}).catch(error =>{
			alert("fail");
			console.log("Error",error);
		})	
		
	}
	
	$scope.updateStatus = function(){
		var item = angular.copy($scope.order);
		var ok = confirm("Are you want to Update");
		if(ok == true){
			$http.put(`/rest/order/${item.id}`,item).then( resp =>{
				var index = $scope.orders.findIndex(o => o.id == item.id );
				$scope.orders[index] = item;
				$scope.orderComplete = item.orderstatus ;
				alert("success");			
			}).catch(error => {
				alert("fail");
				console.log("Error",error);
			});	
		}
	}
	
	
	$scope.findDate = function(){
		
		var from = $scope.date.from.toISOString("vn-VN", {timeZone: "Asia/Ho_Chi_Minh"}).slice(0, 10).replace('T', ' ');
		var to = $scope.date.to.toISOString("vn-VN", {timeZone: "Asia/Ho_Chi_Minh"}).slice(0, 10).replace('T', ' ');
		var status = $scope.date.status;
		alert(from);
		$http.get(`/rest/order/${from}/${to}/${status}`).then(resp =>{
			$scope.orders = resp.data;
			$scope.orders.forEach( item => {
				item.createdate = new Date(item.createdate);
			})
		}).catch(error => {
			alert("fail");
			console.log("Error",error);
		});
		
	}
	
	
	$scope.pager= {
		page : 0,
		size : 8,
		get orders(){
			var start =  this.page * this.size;
			return $scope.orders.slice(start,start+this.size);
		},
		
		get count(){
			return Math.ceil(1.0 * $scope.orders.length/this.size);
		},
		
		first(){
			this.page =0;
		},
		
		prev(){
			if(this.page>0)
				this.page--;
			else
				this.page=0;
		},
		
		next(){
			if(this.page < this.count-1)
				this.page++;
			else
				this.page= this.count-1;
		},
		
		last(){
			this.page = this.count -1;
		}
	}
	
});