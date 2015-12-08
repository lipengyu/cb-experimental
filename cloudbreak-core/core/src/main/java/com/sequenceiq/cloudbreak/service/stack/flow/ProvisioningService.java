package com.sequenceiq.cloudbreak.service.stack.flow;

import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.sequenceiq.cloudbreak.common.type.CloudPlatform;
import com.sequenceiq.cloudbreak.core.CloudbreakSecuritySetupException;
import com.sequenceiq.cloudbreak.domain.Resource;
import com.sequenceiq.cloudbreak.domain.Stack;
import com.sequenceiq.cloudbreak.repository.StackRepository;
import com.sequenceiq.cloudbreak.service.CloudPlatformResolver;
import com.sequenceiq.cloudbreak.service.TlsSecurityService;
import com.sequenceiq.cloudbreak.service.stack.connector.CloudPlatformConnector;
import com.sequenceiq.cloudbreak.service.stack.event.ProvisionComplete;

@Service
public class ProvisioningService {
    public static final String PLATFORM = "platform";
    private static final Logger LOGGER = LoggerFactory.getLogger(ProvisioningService.class);

    @Inject
    private StackRepository stackRepository;

    @Inject
    private CloudPlatformResolver cloudPlatformResolver;

    @Inject
    private TlsSecurityService tlsSecurityService;

    public ProvisionComplete buildStack(final CloudPlatform cloudPlatform, Stack stack, Map<String, Object> setupProperties)
            throws CloudbreakSecuritySetupException {
        stack = stackRepository.findOneWithLists(stack.getId());
        CloudPlatformConnector connector = cloudPlatformResolver.connector(cloudPlatform);
        Set<Resource> resources = connector.buildStack(stack, setupProperties);
        return new ProvisionComplete(cloudPlatform, stack.getId(), resources);
    }
}
