app.controller("chart-ctrl",function($scope,$http){
	$scope.status = 'd';
	$scope.chart = [];
	$scope.dataA = [];
	$scope.dataB = [];
	$scope.label = [];
	$scope.sumRevenue = 0;
	$scope.sumOrders = 0;
	$scope.from = new Date();
	$scope.to = new Date();
	
	$scope.revenue = function(){
		$scope.reset();
		var key = $scope.status;
		
		if($scope.from > new Date() || $scope.to > new Date()){
			alert("Date must be before today");
			document.getElementById("dateFrom").focus();
			return;
		}
		
		if($scope.from > $scope.to){
			alert("Date error logic");
			document.getElementById("dateFrom").focus();
			return;
		}
		
		if(key == 'd'){
			var from = $scope.from.toISOString().slice(0,10);
			var to = $scope.to.toISOString().slice(0,10);
			$http.get(`/rest/revenue/date/${from}/${to}`).then(resp => {
				$scope.chart = resp.data;
				console.log($scope.chart);
				$scope.chart.forEach(item => {
					$scope.label.push(item.time);
					$scope.dataA.push(item.revenue);
					$scope.dataB.push(item.orders);
					$scope.sumRevenue += Number(item.revenue);
					$scope.sumOrders += Number(item.orders);
				})
			}).catch(error => {
					alert("fail");
					console.log("Error",error);
			});
		}
		
		if(key == 'm'){
			var mF = $scope.from.getMonth()+1;
			var yF = $scope.from.getFullYear();
			var mT = $scope.to.getMonth()+1;
			var yT = $scope.to.getFullYear();
			
			$http.get(`/rest/revenue/month/${mF}/${yF}/${mT}/${yT}`).then(resp => {
				$scope.chart = resp.data;
				console.log($scope.chart);
				$scope.chart.forEach(item => {
					$scope.label.push(item.time);
					$scope.dataA.push(item.revenue);
					$scope.dataB.push(item.orders);
					$scope.sumRevenue += Number(item.revenue);
					$scope.sumOrders += Number(item.orders);
				})
			}).catch(error => {
					alert("fail");
					console.log("Error",error);
			});
		}
	}
	
	
	
	$scope.reset = function(){
		$scope.dataA.length = 0;
		$scope.dataB.length = 0;
		$scope.label.length = 0;
		$scope.sumRevenue = 0;
		$scope.sumOrders = 0;
	}
	
	
	$scope.resetChart = function(){
		$scope.dataA.length = 0;
		$scope.dataB.length = 0;
		$scope.label.length = 0;	
		$scope.sumRevenue = 0;
		$scope.sumOrders = 0;
	}
	
	$scope.labels = $scope.label;
  	$scope.series = ['Revenue (k)', 'Orders'];
  	$scope.data = [
	    $scope.dataA,$scope.dataB  
    ];

    $scope.onClick = function (points, evt) {
	    console.log(points, evt);
    };








  $scope.datasetOverride = [{ yAxisID: 'y-axis-1' }, { yAxisID: 'y-axis-2' }];
  $scope.options = {
    scales: {
      yAxes: [
        {
          id: 'y-axis-1',
          type: 'linear',
          display: true,
          position: 'left'
        },
        {
          id: 'y-axis-2',
          type: 'linear',
          display: true,
          position: 'right'
        }
      ]
    }
  };


});