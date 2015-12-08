'use strict';

var log = log4javascript.getLogger("blueprintController-logger");

angular.module('uluwatuControllers').controller('blueprintController', ['$scope', '$rootScope', '$filter', '$base64', 'File', 'UserBlueprint', 'AccountBlueprint', 'GlobalBlueprint', 'ErrorHandler',
    function($scope, $rootScope, $filter, $base64, File, UserBlueprint, AccountBlueprint, GlobalBlueprint, ErrorHandler) {
        $rootScope.blueprints = AccountBlueprint.query();
        initializeBlueprint();
        $scope.showAlert = false;
        $scope.alertMessage = "";

        $scope.createBlueprint = function() {
            if ($scope.blueprint.public) {
                AccountBlueprint.save($scope.blueprint, function(result) {
                    GlobalBlueprint.get({
                        id: result.id
                    }, function(success) {
                        handleBlueprintSuccess(success)
                    });
                }, function(error) {
                    $scope.showError(error, $rootScope.msg.blueprint_failed);
                    $scope.showErrorMessageAlert();
                });
            } else {
                UserBlueprint.save($scope.blueprint, function(result) {
                    GlobalBlueprint.get({
                        id: result.id
                    }, function(success) {
                        handleBlueprintSuccess(success)
                    });
                }, function(error) {
                    $scope.showError(error, $rootScope.msg.blueprint_failed);
                    $scope.showErrorMessageAlert();
                });
            }

            function handleBlueprintSuccess(success) {
                $rootScope.blueprints.push(success);
                initializeBlueprint();
                $scope.showSuccess($filter("format")($rootScope.msg.blueprint_success, String(success.id)));
                $scope.blueprintForm.$setPristine();
                angular.element(document.querySelector('#panel-create-blueprints-collapse-btn')).click();
                $scope.unShowErrorMessageAlert();
            }
        }

        $scope.copyAndEditBlueprint = function(blueprint) {
            var newBlueprint = angular.copy(blueprint)
            angular.element(document.querySelector('#panel-create-blueprints-collapse')).collapse('show');
            angular.element(document.querySelector('#panel-blueprint-collapse' + blueprint.id)).collapse('hide')
            $scope.blueprint = newBlueprint;
            $scope.blueprint.name = ""
            $scope.blueprint.ambariBlueprint.toString = jsonToString;
        }

        $scope.deleteBlueprint = function(blueprint) {
            GlobalBlueprint.delete({
                id: blueprint.id
            }, function(success) {
                $rootScope.blueprints.splice($rootScope.blueprints.indexOf(blueprint), 1);
                $scope.showSuccess($filter("format")($rootScope.msg.blueprint_delete_success, String(blueprint.id)));
            }, function(error) {
                $scope.showError(error, $rootScope.msg.blueprint_delete_failed);
            });
        }

        $scope.jsonBp = true;
        $scope.serviceBp = false;

        $scope.changeViewJsonBp = function() {
            $scope.jsonBp = true;
            $scope.serviceBp = false;
        }

        $scope.changeViewServiceBp = function() {
            $scope.jsonBp = false;
            $scope.serviceBp = true;
        }

        function initializeBlueprint() {
            $scope.blueprintType = 'TEXT';
            $scope.blueprintFileValid = null;
            $scope.blueprint = {}
        }

        function jsonToString() { // formatting textarea
            return JSON.stringify(this, null, "    ");
        }

        $scope.unShowErrorMessageAlert = function() {
            $scope.showAlert = false;
            $scope.alertMessage = "";
        }

        $scope.showErrorMessageAlert = function() {
            $scope.showAlert = true;
            $scope.alertMessage = $scope.statusMessage;
        }

        $scope.generateBlueprintFromFile = function() {
            $scope.blueprint.ambariBlueprint = "";
            File.getBase64ContentById("blueprintFile", function(content) {
                try {
                    $scope.blueprint.ambariBlueprint = JSON.parse(content ? $base64.decode(content) : "");
                    $scope.blueprint.ambariBlueprint.toString = jsonToString;
                    $scope.blueprintFileValid = true;
                } catch (e) {
                    $scope.blueprintFileValid = false;
                }
                $scope.$apply();
            });
            $scope.$apply();
        };
    }
]);