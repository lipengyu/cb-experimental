'use strict';

var log = log4javascript.getLogger("templateController-logger");

angular.module('uluwatuControllers').controller('templateController', ['$scope', '$rootScope', '$filter', 'UserTemplate', 'AccountTemplate', 'GlobalTemplate',
    function($scope, $rootScope, $filter, UserTemplate, AccountTemplate, GlobalTemplate) {

        $rootScope.templates = AccountTemplate.query();
        $scope.awsTemplateForm = {};
        $scope.gcpTemplateForm = {};
        $scope.openstackTemplateForm = {};
        $scope.awsInstanceType = {};
        initializeAzureTemp();
        initializeAwsTemp();
        initializeGcpTemp();
        initializeOpenstackTemp();
        $scope.showAlert = false;
        $scope.alertMessage = "";

        $scope.createAwsTemplateRequest = function() {
            $scope.azureTemplate = false;
            $scope.awsTemplate = true;
            $scope.gcpTemplate = false;
            $scope.openstackTemplate = false;
        }

        $scope.createAzureTemplateRequest = function() {
            $scope.azureTemplate = true;
            $scope.awsTemplate = false;
            $scope.gcpTemplate = false;
            $scope.openstackTemplate = false;
        }

        $scope.createGcpTemplateRequest = function() {
            $scope.azureTemplate = false;
            $scope.awsTemplate = false;
            $scope.gcpTemplate = true;
            $scope.openstackTemplate = false;
        }

        $scope.createOpenstackTemplateRequest = function() {
            $scope.azureTemplate = false;
            $scope.awsTemplate = false;
            $scope.gcpTemplate = false;
            $scope.openstackTemplate = true;
        }

        $scope.createAwsTemplate = function() {
            $scope.awsTemp.cloudPlatform = 'AWS';
            $scope.awsTemp.parameters.sshLocation = '0.0.0.0/0';
            if ($scope.awsTemp.public) {
                AccountTemplate.save($scope.awsTemp, function(result) {
                    handleAwsTemplateSuccess(result)
                }, function(error) {
                    $scope.showErrorMessageAlert(error, $rootScope.msg.aws_template_failed);
                    $scope.showErrorMessageAlert();
                });
            } else {
                UserTemplate.save($scope.awsTemp, function(result) {
                    handleAwsTemplateSuccess(result)
                }, function(error) {
                    $scope.showErrorMessageAlert(error, $rootScope.msg.aws_template_failed);
                    $scope.showErrorMessageAlert();
                });
            }

            function handleAwsTemplateSuccess(result) {
                $scope.awsTemp.id = result.id;
                $rootScope.templates.push($scope.awsTemp);
                initializeAwsTemp();
                $scope.showSuccess($filter("format")($rootScope.msg.aws_template_success, String(result.id)));
                $scope.awsTemplateForm.$setPristine();
                collapseCreateTemplateFormPanel();
                $scope.unShowErrorMessageAlert();
            }
        }

        $scope.createOpenstackTemplate = function() {
            $scope.openstackTemp.cloudPlatform = 'OPENSTACK';
            if ($scope.openstackTemp.public) {
                AccountTemplate.save($scope.openstackTemp, function(result) {
                    handleOpenstackTemplateSuccess(result)
                }, function(error) {
                    $scope.showError(error, $rootScope.msg.openstack_template_failed);
                    $scope.showErrorMessageAlert();
                });
            } else {
                UserTemplate.save($scope.openstackTemp, function(result) {
                    handleOpenstackTemplateSuccess(result)
                }, function(error) {
                    $scope.showError(error, $rootScope.msg.openstack_template_failed);
                    $scope.showErrorMessageAlert();
                });
            }

            function handleOpenstackTemplateSuccess(result) {
                $scope.openstackTemp.id = result.id;
                $rootScope.templates.push($scope.openstackTemp);
                initializeOpenstackTemp();
                $scope.showSuccess($filter("format")($rootScope.msg.openstack_template_success, String(result.id)));
                $scope.openstackTemplateForm.$setPristine();
                collapseCreateTemplateFormPanel();
                $scope.unShowErrorMessageAlert()
            }

        }

        $scope.createGcpTemplate = function() {
            $scope.gcpTemp.cloudPlatform = 'GCP';
            if ($scope.gcpTemp.public) {
                AccountTemplate.save($scope.gcpTemp, function(result) {
                    handleGcpTemplateSuccess(result)
                }, function(error) {
                    $scope.showError(error, $rootScope.msg.gcp_template_failed);
                    $scope.showErrorMessageAlert();
                });
            } else {
                UserTemplate.save($scope.gcpTemp, function(result) {
                    handleGcpTemplateSuccess(result)
                }, function(error) {
                    $scope.showError(error, $rootScope.msg.gcp_template_failed);
                    $scope.showErrorMessageAlert();
                });
            }

            function handleGcpTemplateSuccess(result) {
                $scope.gcpTemp.id = result.id;
                $rootScope.templates.push($scope.gcpTemp);
                initializeGcpTemp();
                $scope.showSuccess($filter("format")($rootScope.msg.gcp_template_success, String(result.id)));
                $scope.gcpTemplateForm.$setPristine();
                collapseCreateTemplateFormPanel();
                $scope.unShowErrorMessageAlert();
            }
        }

        $scope.createAzureTemplate = function() {
            $scope.azureTemp.cloudPlatform = "AZURE";
            if ($scope.azureTemp.public) {
                AccountTemplate.save($scope.azureTemp, function(result) {
                    handleAzureTemplateSuccess(result)
                }, function(error) {
                    $scope.showError(error, $rootScope.msg.azure_template_failed);
                    $scope.showErrorMessageAlert();
                });
            } else {
                UserTemplate.save($scope.azureTemp, function(result) {
                    handleAzureTemplateSuccess(result)
                }, function(error) {
                    $scope.showError(error, $rootScope.msg.azure_template_failed);
                    $scope.showErrorMessageAlert();
                });
            }

            function handleAzureTemplateSuccess(result) {
                $scope.azureTemp.id = result.id;
                $rootScope.templates.push($scope.azureTemp);
                initializeAzureTemp();
                $scope.showSuccess($filter("format")($rootScope.msg.azure_template_success, String(result.id)));
                $scope.azureTemplateForm.$setPristine();
                collapseCreateTemplateFormPanel();
                $scope.unShowErrorMessageAlert();
            }
        }

        $scope.deleteTemplate = function(template) {
            GlobalTemplate.delete({
                id: template.id
            }, function(success) {
                $rootScope.templates.splice($rootScope.templates.indexOf(template), 1);
                $scope.showSuccess($filter("format")($rootScope.msg.template_delete_success, String(template.id)));
            }, function(error) {
                $scope.showError(error, $rootScope.msg.template_delete_failed)
            });
        }

        $scope.filterByVolumetype = function(volume) {
            try {
                if ((isAwsVolumeEncryptable(volume) && isAwsEncryptionSet()) || !isAwsEncryptionSet()) {
                    return true;
                }
                return false;
            } catch (err) {
                return true;
            }
        }

        function isAwsEncryptionSet() {
            return $scope.awsTemp.parameters.encrypted;
        }

        function isAwsVolumeEncryptable(volume) {
            return volume !== 'ephemeral';
        }

        $scope.changeAwsInstanceType = function() {
            var instanceType = $scope.awsTemp.parameters.instanceType;
            $scope.awsInstanceType = $filter('filter')($rootScope.params.vmTypes.AWS, {
                value: instanceType
            }, true)[0];
            if ($scope.awsTemp.parameters.volumeType == 'ephemeral') {
                $scope.awsTemp.parameters.encrypted = false;
            }
        }

        function collapseCreateTemplateFormPanel() {
            angular.element(document.querySelector('#panel-create-templates-collapse-btn')).click();
        }

        function initializeAwsTemp() {
            $scope.awsTemp = {
                volumeCount: 1,
                volumeSize: 100,
                parameters: {
                    sshLocation: "0.0.0.0/0",
                    instanceType: $rootScope.params.defaultVmTypes.AWS,
                    volumeType: $rootScope.params.defaultDisks.AWS,
                    encrypted: false
                }
            }
        }

        function initializeAzureTemp() {
            $scope.azureTemp = {
                volumeCount: 1,
                volumeSize: 100,
                parameters: {
                    vmType: $rootScope.params.defaultVmTypes.AZURE_RM,
                    volumeSize: 100
                }
            }
        }

        function initializeOpenstackTemp() {
            $scope.openstackTemp = {
                volumeCount: 1,
                volumeSize: 100,
                parameters: {}
            }
        }

        function initializeGcpTemp() {
            $scope.gcpTemp = {
                volumeCount: 1,
                volumeSize: 100,
                parameters: {
                    gcpInstanceType: $rootScope.params.defaultVmTypes.GCP,
                    volumeType: $rootScope.params.defaultDisks.GCP
                }
            }
        }

        $scope.unShowErrorMessageAlert = function() {
            $scope.showAlert = false;
            $scope.alertMessage = "";
        }

        $scope.showErrorMessageAlert = function() {
            $scope.showAlert = true;
            $scope.alertMessage = $scope.statusMessage;
        }
    }
]);