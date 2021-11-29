const app = angular.module("shopping-cart-app", []);
app.controller("shopping-cart-ctrl", function($scope, $http){
    // QUẢN LÝ GIỎ HÀNG
	// Quận
	
	  $scope.district=[];
		$scope.initialize=function(){
			$http.get("/rest/district").then(resp=>{
				$scope.district = resp.data;
			});
		}
		$scope.initialize();
		
		
    $scope.cart = {
        items:[],
        
        // Thêm sản phẩm vào giỏ hàng
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
        // Xóa sản phẩm khỏi giỏ hàng
        remove(id){
        	var index = this.items.findIndex(item => item.id == id);
			var item = this.items.find(item => item.id == id);
			var ok = confirm("Bạn muốn xóa : "+item.name+"???");
			if(ok){
				this.items.splice(index,1);
				this.saveToLocalStorage();
			}		
        },
        // Xóa sạch các mặt hàng trong giỏ
        clear(){
        	var ok = confirm("Bạn muốn xóa toàn bộ sản phẩm trong giỏ ?")
			if(ok){
				this.items=[];
				this.saveToLocalStorage();
			}
        },
        clearAll(){
			this.items=[];
			this.saveToLocalStorage();
		},
        // Tính thành tiền của 1 sản phẩm
        amt_of(item){},
        // Tính tổng số lượng các mặt hàng trong giỏ
        get count(){
            return this.items
                .map(item => item.qty)
                .reduce((total, qty) => total += qty, 0);
        },
        // Tổng thành tiền các mặt hàng trong giỏ
        get amount(){
            return this.items
                .map(item => item.qty * item.price)
                .reduce((total, qty) => total += qty, 0);
        },
        get amountTotal(){
            return this.items
                .map(item => item.qty * item.price)
                .reduce((total, qty) => total += qty, 0);
        },
        // Lưu giỏ hàng vào local storage
        saveToLocalStorage(){
            var json = JSON.stringify(angular.copy(this.items));
            localStorage.setItem("cart", json);
        },
        // Đọc giỏ hàng từ local storage
        loadFromLocalStorage(){
            var json = localStorage.getItem("cart");
            this.items = json ? JSON.parse(json):[];
        }
    }
    $scope.cart.loadFromLocalStorage();

    $scope.order = {
        createdate: new Date(),
        address: "",	
        phone: "",
        district: {id:""},
        paymentmethod:"COD",
        shipfee:"",
        price: $scope.cart.amount,
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
        	
            var valid = document.getElementById("myTextarea").value;
            if ($scope.order.district.id != "" && $scope.order.district.id != undefined)
            	$scope.msg = 'Quận: '+$scope.order.district.id;
            	else
            	$scope.msg = 'Hãy chọn một quận!';
            if(valid.length == 0){
				alert("Không được để trống địa chỉ!");
				document.getElementById("myTextarea").focus();
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
            // Thực hiện đặt hàng
            
        }
    }
    
   $scope.change = function(){
    	var id = $scope.order.district.id;
    	$http.get(`/rest/district/${id}`).then(resp=>{
    		var newdist = resp.data;
    		$scope.order.shipfee = newdist.shipfee;
    	})
    }	
    
    $scope.phoneNumbr = /^\+?\d{2}[- ]?\d{3}[- ]?\d{5}$/;
    
})