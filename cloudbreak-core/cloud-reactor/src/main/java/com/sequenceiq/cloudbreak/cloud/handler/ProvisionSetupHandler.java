package com.sequenceiq.cloudbreak.cloud.handler;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.sequenceiq.cloudbreak.cloud.CloudConnector;
import com.sequenceiq.cloudbreak.cloud.context.AuthenticatedContext;
import com.sequenceiq.cloudbreak.cloud.context.CloudContext;
import com.sequenceiq.cloudbreak.cloud.event.setup.SetupRequest;
import com.sequenceiq.cloudbreak.cloud.event.setup.SetupResult;
import com.sequenceiq.cloudbreak.cloud.init.CloudPlatformConnectors;
import com.sequenceiq.cloudbreak.cloud.model.CloudStack;
import com.sequenceiq.cloudbreak.cloud.notification.ResourceNotifier;

import reactor.bus.Event;

@Component
public class ProvisionSetupHandler implements CloudPlatformEventHandler<SetupRequest> {

    private static final Logger LOGGER = LoggerFactory.getLogger(ProvisionSetupHandler.class);

    @Inject
    private CloudPlatformConnectors cloudPlatformConnectors;

    @Inject
    private ResourceNotifier resourceNotifier;

    @Override
    public Class<SetupRequest> type() {
        return SetupRequest.class;
    }

    @Override
    public void accept(Event<SetupRequest> event) {
        LOGGER.info("Received event: {}", event);
        SetupRequest request = event.getData();
        CloudContext cloudContext = request.getCloudContext();
        try {
            CloudConnector connector = cloudPlatformConnectors.get(cloudContext.getPlatformVariant());
            AuthenticatedContext auth = connector.authentication().authenticate(cloudContext, request.getCloudCredential());
            CloudStack cloudStack = request.getCloudStack();
            connector.setup().prerequisites(auth, cloudStack, resourceNotifier);

            request.getResult().onNext(new SetupResult(request));
            LOGGER.info("Provision setup finished for {}", cloudContext);
        } catch (Exception e) {
            request.getResult().onNext(new SetupResult(e, request));
        }
    }
}
