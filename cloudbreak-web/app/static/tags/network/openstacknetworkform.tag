<div class="form-group" ng-class="{ 'has-error': openstackNetworkForm.openstack_networkName.$dirty && openstackNetworkForm.openstack_networkName.$invalid }">
    <label class="col-sm-3 control-label" for="openstack_networkName">{{msg.name_label}}</label>

    <div class="col-sm-9">
        <input type="text" class="form-control" ng-pattern="/^[a-zA-Z][-a-zA-Z0-9]*$/" name="openstack_networkName" ng-model="network.name" ng-minlength="5" ng-maxlength="100" required id="openstack_networkName" placeholder="{{msg.name_placeholder}}">
        <div class="help-block" ng-show="openstackNetworkForm.openstack_networkName.$dirty && openstackNetworkForm.openstack_networkName.$invalid">
            <i class="fa fa-warning"></i> {{msg.network_name_invalid}}
        </div>
    </div>
    <!-- .col-sm-9 -->
</div>
<div class="form-group" ng-class="{ 'has-error': openstackNetworkForm.openstack_networkDescription.$dirty && openstackNetworkForm.openstack_networkDescription.$invalid }">
    <label class="col-sm-3 control-label" for="openstack_networkDescription">{{msg.description_label}}</label>

    <div class="col-sm-9">
        <input type="text" class="form-control" name="openstack_networkDescription" ng-model="network.description" ng-maxlength="1000" id="openstack_networkDescription" placeholder="{{msg.network_form_description_placeholder}}">
        <div class="help-block" ng-show="openstackNetworkForm.openstack_networkDescription.$dirty && openstackNetworkForm.openstack_networkDescription.$invalid">
            <i class="fa fa-warning"></i> {{msg.netowrk_description_invalid}}
        </div>
    </div>
    <!-- .col-sm-9 -->
</div>
<div class="form-group" ng-class="{ 'has-error': openstackNetworkForm.openstack_networkSubnet.$dirty && openstackNetworkForm.openstack_networkSubnet.$invalid }">
    <label class="col-sm-3 control-label" for="openstack_networkSubnet">{{msg.network_form_subnet_label}}</label>

    <div class="col-sm-9">
        <input type="text" class="form-control" name="openstack_networkSubnet" ng-model="network.subnetCIDR" ng-maxlength="30" id="openstack_networkSubnet" placeholder="{{msg.network_form_subnet_placeholder}}" required>
        <div class="help-block" ng-show="openstackNetworkForm.openstack_networkSubnet.$dirty && openstackNetworkForm.openstack_networkSubnet.$invalid">
            <i class="fa fa-warning"></i> {{msg.network_subnet_invalid}}
        </div>
    </div>
    <!-- .col-sm-9 -->
</div>



<div class="form-group" ng-class="{ 'has-error': openstackNetworkForm.openstack_publicNetId.$dirty && openstackNetworkForm.openstack_publicNetId.$invalid }">
    <label class="col-sm-3 control-label" for="openstack_publicNetId">{{msg.network_openstack_form_public_network_id_label}}</label>

    <div class="col-sm-9">
        <input type="text" class="form-control" name="openstack_publicNetId" ng-model="network.parameters.publicNetId" ng-minlength="10" ng-maxlength="60" id="openstack_publicNetId" placeholder="{{msg.network_openstack_form_public_network_id_placeholder}}" required>
        <div class="help-block" ng-show="openstackNetworkForm.openstack_publicNetId.$dirty && openstackNetworkForm.openstack_publicNetId.$invalid">
            <i class="fa fa-warning"></i> {{msg.network_publicnetid_invalid}}
        </div>
    </div>
    <!-- .col-sm-9 -->
</div>


<div class="form-group">
    <label class="col-sm-3 control-label" for="openstack_network_public">{{msg.public_in_account_label}}</label>
    <div class="col-sm-9">
        <input type="checkbox" name="openstack_network_public" id="openstack_network_public" ng-model="network.publicInAccount">
    </div>
    <!-- .col-sm-9 -->
</div>

<div class="row btn-row">
    <div class="col-sm-9 col-sm-offset-3">
        <a id="createAwsTemplate" ng-disabled="openstackNetworkForm.$invalid" class="btn btn-success btn-block" ng-click="createOpenStackNetwork()" role="button"><i class="fa fa-plus fa-fw"></i>
                {{msg.network_form_create}}</a>
    </div>
</div>