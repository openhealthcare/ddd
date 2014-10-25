var app = angular.module('ddd', ['angularTreeview', 'ui.ace']);

app.controller('EditorCtrl', function($scope, $http){
    console.log('ddd');
    $http.get('/api/v0.1/rules/').then(function(response){
        var treeview = [];
        var dirs = _.keys(response.data);
        _.each(dirs, function(dirname){
            var dir = {
                label: dirname,
                id: dirname,
                children: _.map(response.data[dirname], function(behaviourfile){
		    
                    return {
                        label : behaviourfile,
                        id : dirname + "/" + behaviourfile,
                        children: []
                    }
                })
            };
            treeview.push(dir);
        });
        
        $scope.treedata = treeview;
    });
    $scope.treedata = [];

    $scope.get_contents = function(path){
	$http.get('/api/v0.1/rules/contents/' + path).then(function(response){
	    console.log(response);
	    $scope._session.setValue(response.data);
	});
    };

    $scope.aceLoaded = function(_editor){
	
	$scope._session = _editor.getSession();
	$scope._renderer = _editor.renderer;
	
    };
    
    $scope.$watch('behaviours.currentNode', function(selected, old){
	console.log('node selected: ');
	console.log(selected);
	if(selected){
	    $scope.get_contents(selected.id);
	}
    });

});


