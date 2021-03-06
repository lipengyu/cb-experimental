package com.sequenceiq.cloudbreak.cloud.gcp.network;

import java.util.Arrays;

import org.springframework.stereotype.Service;

import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.services.compute.Compute;
import com.google.api.services.compute.model.Firewall;
import com.google.api.services.compute.model.Operation;
import com.sequenceiq.cloudbreak.cloud.context.AuthenticatedContext;
import com.sequenceiq.cloudbreak.cloud.gcp.GcpResourceException;
import com.sequenceiq.cloudbreak.cloud.gcp.context.GcpContext;
import com.sequenceiq.cloudbreak.cloud.model.CloudResource;
import com.sequenceiq.cloudbreak.cloud.model.Network;
import com.sequenceiq.cloudbreak.cloud.model.Security;
import com.sequenceiq.cloudbreak.common.type.ResourceType;

@Service
public class GcpFirewallInternalResourceBuilder extends AbstractGcpNetworkBuilder {

    @Override
    public CloudResource create(GcpContext context, AuthenticatedContext auth) {
        String resourceName = getResourceNameService().resourceName(resourceType(), context.getName());
        return createNamedResource(resourceType(), resourceName);
    }

    @Override
    public CloudResource build(GcpContext context, AuthenticatedContext auth, Network network, Security security, CloudResource buildableResource)
            throws Exception {
        String projectId = context.getProjectId();

        Firewall firewall = new Firewall();
        Firewall.Allowed allowed1 = new Firewall.Allowed();
        allowed1.setIPProtocol("tcp");
        allowed1.setPorts(Arrays.asList("1-65535"));

        Firewall.Allowed allowed2 = new Firewall.Allowed();
        allowed2.setIPProtocol("icmp");

        Firewall.Allowed allowed3 = new Firewall.Allowed();
        allowed3.setIPProtocol("udp");
        allowed3.setPorts(Arrays.asList("1-65535"));

        firewall.setAllowed(Arrays.asList(allowed1, allowed2, allowed3));
        firewall.setName(buildableResource.getName());
        firewall.setSourceRanges(Arrays.asList(network.getSubnet().getCidr()));
        firewall.setNetwork(String.format("https://www.googleapis.com/compute/v1/projects/%s/global/networks/%s", projectId,
                context.getParameter(GcpNetworkResourceBuilder.NETWORK_NAME, String.class)));

        Compute.Firewalls.Insert firewallInsert = context.getCompute().firewalls().insert(projectId, firewall);
        try {
            Operation operation = firewallInsert.execute();
            if (operation.getHttpErrorStatusCode() != null) {
                throw new GcpResourceException(operation.getHttpErrorMessage(), resourceType(), buildableResource.getName());
            }
            return createOperationAwareCloudResource(buildableResource, operation);
        } catch (GoogleJsonResponseException e) {
            throw new GcpResourceException(checkException(e), resourceType(), buildableResource.getName());
        }
    }

    @Override
    public CloudResource delete(GcpContext context, AuthenticatedContext auth, CloudResource resource) throws Exception {
        try {
            Operation operation = context.getCompute().firewalls().delete(context.getProjectId(), resource.getName()).execute();
            return createOperationAwareCloudResource(resource, operation);
        } catch (GoogleJsonResponseException e) {
            exceptionHandler(e, resource.getName(), resourceType());
            return null;
        }
    }

    @Override
    public ResourceType resourceType() {
        return ResourceType.GCP_FIREWALL_INTERNAL;
    }

    @Override
    public int order() {
        return 1;
    }
}
