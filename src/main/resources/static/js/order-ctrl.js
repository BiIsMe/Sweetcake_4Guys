app.controller("order-ctrl",function($scope,$http){
	$scope.orderComplete = '';
	$scope.orders = [];
	$scope.order={};
	$scope.orderdetails=[];
	$scope.id='';
	$scope.customer='';
	$scope.begin = 0;
	$scope.limit = 6;
	$scope.totalPage = 0;
	$scope.pageIndex = 1;
	$scope.property = 'date';
	$scope.reverse = true;
	$scope.reasonForm = '';
	$scope.initialPrice = 0;
	
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
				item.accountName = item.account.username;
			})
			$scope.totalPage = Math.ceil($scope.orders.length / $scope.limit);
		})
	}
	
	$scope.initial();
	
	$scope.edit = function(item){
		$http.get(`/rest/orderdetails/${item.id}`).then(resp =>{
			$scope.orderdetails = resp.data;
			$scope.order = angular.copy(item);
			$scope.initialPrice = 0;
			$scope.orderdetails.forEach(item => {
				$scope.initialPrice += Number(item.price) * Number(item.quantity);
			})
			$scope.orderComplete = $scope.order.orderstatus ;
		}).catch(error =>{
			alert("fail");
			console.log("Error",error);
		})	
		
	}
	
	$scope.updateStatus = function(){
		var item = angular.copy($scope.order);
		var status = $scope.order.orderstatus;
		if(status == 'accepted')
			item.orderstatus = 'delivery';
		else if(status == 'delivery')
			item.orderstatus = 'completed';
		var ok = confirm("Put the order on next stage?");
		if(ok == true){
			$http.put(`/rest/order/${item.id}`,item).then( resp =>{
				var index = $scope.orders.findIndex(o => o.id == item.id );
				$scope.orders[index] = item;
				$scope.order.orderstatus = item.orderstatus ;
				alert("success");			
			}).catch(error => {
				alert("fail");
				console.log("Error",error);
			});	
		}
	}
	
	
	$scope.cancelOrder = function(){
		var item = angular.copy($scope.order);
		var ok = confirm("Are you sure to cancel the order : "+$scope.order.id);
		item.reason = $scope.reasonFrom;
		if(ok == true){
			item.orderstatus = 'canceled';
			item.reason = this.reasonFrom;
			item.whocancel = false;
			this.reason
			
			$http.put(`/rest/order/${item.id}`,item).then( resp =>{
				var index = $scope.orders.findIndex(o => o.id == item.id );
				$scope.orders[index] = item;
				$scope.order.orderstatus = item.orderstatus ;
				$scope.order.reason = item.reason;
				alert("success");
				this.reasonFrom = '';	
				$('.modal').modal('hide');	
			}).catch(error => {
				alert("fail");
				console.log("Error",error);
			});	
		}
	}
	
	
	$scope.findDate = function(){
		if($scope.date.from > new Date()){
			alert("Date of from must be before today");
			document.getElementById("dateFrom").focus();
			return;
		}
		
		if($scope.date.from > $scope.date.to){
			alert("date error logic");
			document.getElementById("dateFrom").focus();
			return;
		}
		
		var from = $scope.date.from.toISOString().slice(0,10);
		var to = $scope.date.to.toISOString().slice(0,10);
		var status = $scope.date.status;
		$http.get(`/rest/order/${from}/${to}/${status}`).then(resp =>{
			$scope.orders = resp.data;
			$scope.orders.forEach( item => {
				item.createdate = new Date(item.createdate);
				item.accountName = item.account.username;
			})
			$scope.totalPage = Math.ceil($scope.orders.length / $scope.limit);
		}).catch(error => {
			alert("fail");
			console.log("Error",error);
		});
		
	}
	
	//orderBy
	$scope.sortBy = function(property) {
	    $scope.reverse = ($scope.property === property) ? !$scope.reverse : $scope.reverse;
	    $scope.property = property;
	  };
	
	
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