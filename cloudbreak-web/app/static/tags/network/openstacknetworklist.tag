<form class="form-horizontal" role="document">
    <!-- role: 'document' - non-editable "form" -->
    <div ng-include src="'tags/network/commonnetworkfieldslist.tag'"></div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="{{network.name}}-publicnetid">{{msg.network_openstack_form_public_network_id_label}}</label>

        <div class="col-sm-9">
            <p id="{{network.name}}-publicnetid" class="form-control-static">{{network.parameters.publicNetId}}</p>
        </div>
        <!-- .col-sm-9 -->
    </div>
</form>