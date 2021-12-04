app.controller("profile-ctrl",function($scope,$http){
	
	$scope.currentPass = '';
	$scope.newPass = '';
	$scope.confirmPass = '';
	
	$scope.updateInfor = function(){
		var user = angular.copy(this.indexUser);
		var id = user.username;
		//var year = this.indexUser.dob.getFullYear();
		var ageDifMs = Date.now() - this.indexUser.dob.getTime();
    	var ageDate = new Date(ageDifMs); // miliseconds from epoch
   		var result = Math.abs(ageDate.getUTCFullYear() - 1970);
		if(result < 18){
			alert("The user must be >= 18 ys");
			document.getElementById("dob").focus();
			return;
		}

		var ok = confirm("Do you want to update your information ?")
		if(ok){
			$http.put(`/rest/account/staff/${id}`,user).then(resp => {
				alert("update infor successfully");
				this.indexUser = resp.data;
				$scope.indexName = resp.data.fullname;
				location.reload();
			}).catch(error => {
				alert("fail");
				console.log("Error : "+error);
			});
		}
	}
	
	$scope.changePass = function(){
		var oldP = this.currentPass;
		var newP = this.newPass;
		if(oldP != this.indexUser.password){
			alert("The Current Password is not correct !");
			document.getElementById("current").focus();
		}
		else{
			$scope.indexUser.password = newP;
			var ok = confirm("Do you want to change your password ?")
			if(ok){
				$http.put(`/rest/account/staff/${this.indexUser.username}`, this.indexUser).then(resp =>{
					alert("change pass successfully");
					location.reload();
				}).catch(error => {
				alert("fail");
				console.log("Error : "+error);
			});
			}
		}
	}
	
	
	$scope.reset = function(){
		this.currentPass = '';
		this.newPass = '';
		this.confirmPass = '';
	}
	
	
	
});