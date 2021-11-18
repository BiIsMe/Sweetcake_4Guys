const app = angular.module("shopping-cart-app", []);
app.controller("shopping-cart-ctrl", function($scope, $http){
    //QUẢN LÝ GIỎ HÀNG
	
    $scope.cart = {
        items:[],
        //Thêm sản phẩm vào giỏ hàng
        add(id){
            var item = this.items.find(item => item.id == id);
            if(item){
                item.qty++;
                this.saveToLocalStorage();
                alert("Thêm sản phẩm thành công!!!")
            }
            else{
                $http.get(`/rest/products/${id}`).then(resp =>{
                    resp.data.qty = 1;
                    this.items.push(resp.data);
                    this.saveToLocalStorage();
                    alert("Thêm sản phẩm thành công!!!")
                })
            }
        },
        //Xóa sản phẩm khỏi giỏ hàng
        remove(id){
        	var index = this.items.findIndex(item => item.id == id);
			var item = this.items.find(item => item.id == id);
			var ok = confirm("Do you want to delete : "+item.name);
			if(ok){
				this.items.splice(index,1);
				this.saveToLocalStorage();
			}		
        },
        //Xóa sạch các mặt hàng trong giỏ
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
        //Tính thành tiền của 1 sản phẩm
        amt_of(item){},
        //Tính tổng số lượng các mặt hàng trong giỏ
        get count(){
            return this.items
                .map(item => item.qty)
                .reduce((total, qty) => total += qty, 0);
        },
        //Tổng thành tiền các mặt hàng trong giỏ
        get amount(){
            return this.items
                .map(item => item.qty * item.price)
                .reduce((total, qty) => total += qty, 0);
        },
        //Lưu giỏ hàng vào local storage
        saveToLocalStorage(){
            var json = JSON.stringify(angular.copy(this.items));
            localStorage.setItem("cart", json);
        },
        //Đọc giỏ hàng từ local storage
        loadFromLocalStorage(){
            var json = localStorage.getItem("cart");
            this.items = json ? JSON.parse(json):[];
        }
    }
    $scope.cart.loadFromLocalStorage();

    $scope.order = {
        createdate: new Date(),
        address: "",
        email: "",
        phone: "",
        orderstatus:"accepted",
        account: {username: $("#customerid").text()},
        get orderDetails(){
            return $scope.cart.items.map(item =>{
                return{
                    product: {id: item.id},
                    price: item.price,
                    quantity: item.qty
                }
            });
        },
        purchase(){
        	var validPhone = document.getElementById("phone").value;
        	var validEmail = document.getElementById("email").value;
            var valid = document.getElementById("myTextarea").value;
            if(validEmail.length == 0){
				alert("Plese input Email");
				document.getElementById("email").focus();
			}
            if(valid.length == 0){
				alert("Plese input address");
				document.getElementById("myTextarea").focus();
			}
            if(validPhone.length == 0){
				alert("Plese input phone");
				document.getElementById("phone").focus();
			}
            else{
				var order = angular.copy(this);
				$http.post("/rest/orders", order).then(resp =>{
	                alert("Đặt hàng thành công");
	                $scope.cart.clearAll();
	                location.href = "/order/detail/"+ resp.data.id;
	            }).catch(error =>{
	                alert("Đặt hàng lỗi")
	                console.log(error)
	            })
			}
            //Thực hiện đặt hàng
            
        }
    }
//    
//	$scope.form={};
//	$scope.district=[];
//	$scope.initialize=function(){
//		$http.get("/rest/district").then(rest=>{
//			$scope.district = resp.data;
//			console.log(district)
//		})
//	}
//	$scope.initialize();
})