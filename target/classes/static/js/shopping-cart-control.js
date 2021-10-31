const app = angular.module("shopping-cart-app",[]);

app.controller("shopping-cart-ctrl",function($scope,$http){
	/*
		CART CONTROL
	*/
	$scope.cart = {
		items:[],
		
		add(id){
			var item = this.items.find(item => item.id == id);
			if(item){
				item.quantity++;
				this.saveToLocalStorage();
				alert("Add to cart");
			}
			else{
				$http.get(`/rest/product/${id}`)
				.then(resp =>{
					resp.data.quantity=1;
					this.items.push(resp.data);
					this.saveToLocalStorage();
					alert("Add to cart");
				})
			}
		},
		
		remove(id){
			var index = this.items.findIndex(item => item.id == id);
			var item = this.items.find(item => item.id == id);
			var ok = confirm("Do you want to delete : "+item.name);
			if(ok){
				this.items.splice(index,1);
				this.saveToLocalStorage();
			}		
		},
		
		clear(){
			var ok = confirm("Do you want to clear all ?")
			if(ok){
				this.items=[];
				this.saveToLocalStorage();
			}
		},
		
		clearAll(){
			this.items=[];
			this.saveToLocalStorage();
		},
		
		
		amt_of(item){},
		
		get count(){
			return this.items
				.map(item => item.quantity)
				.reduce((total,quantity) => total+= quantity,0);
		},
		
		get amount(){
			return this.items
				.map(item => item.quantity * item.price)
				.reduce((total,quantity) => total+= quantity,0);
		},
		
		saveToLocalStorage(){
			var json = JSON.stringify(angular.copy(this.items));
			localStorage.setItem("cart",json);
		},
		
		loadFromLocalStorage(){
			var json = localStorage.getItem("cart");
			this.items = json?JSON.parse(json):[];
		}
		
	};
	
	$scope.cart.loadFromLocalStorage();
	
	/*
		ORDER
	*/
	$scope.order = {
		createdate : new Date(),
		address: "",
		phone:"0000000000",
		status:"accepted",
		price: $scope.cart.amount,
		account:{username:$("#username").text()},
		get orderdetails(){
			return $scope.cart.items.map(item => {
				return {
					product:{id:item.id},
					price : item.price,
					quantity: item.quantity
				}
			});
		},
		
		purchase(){
			var valid = document.getElementById("myTextarea").value;
			if(valid.length == 0){
				alert("Plese input address");
				document.getElementById("myTextarea").focus();
			}else{
				var order = angular.copy(this);
				//do order
				$http.post("/rest/order",order).then(resp => {
					alert("order success");
					$scope.cart.clearAll();
					location.href="/order/detail/"+resp.data.id;
				}).catch(error => {
					alert("fail");
					console.log(error);
				})
			}
		}
	}
	
	
})