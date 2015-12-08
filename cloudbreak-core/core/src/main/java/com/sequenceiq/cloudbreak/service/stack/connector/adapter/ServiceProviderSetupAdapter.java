package com.sequenceiq.cloudbreak.service.stack.connector.adapter;

import static com.sequenceiq.cloudbreak.cloud.model.AvailabilityZone.availabilityZone;
import static com.sequenceiq.cloudbreak.cloud.model.Location.location;
import static com.sequenceiq.cloudbreak.cloud.model.Region.region;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.sequenceiq.cloudbreak.cloud.context.CloudContext;
import com.sequenceiq.cloudbreak.cloud.event.setup.CheckImageRequest;
import com.sequenceiq.cloudbreak.cloud.event.setup.CheckImageResult;
import com.sequenceiq.cloudbreak.cloud.event.setup.PrepareImageRequest;
import com.sequenceiq.cloudbreak.cloud.event.setup.PrepareImageResult;
import com.sequenceiq.cloudbreak.cloud.event.setup.SetupRequest;
import com.sequenceiq.cloudbreak.cloud.event.setup.SetupResult;
import com.sequenceiq.cloudbreak.cloud.model.CloudCredential;
import com.sequenceiq.cloudbreak.cloud.model.CloudStack;
import com.sequenceiq.cloudbreak.cloud.model.Image;
import com.sequenceiq.cloudbreak.cloud.model.Location;
import com.sequenceiq.cloudbreak.common.type.CloudPlatform;
import com.sequenceiq.cloudbreak.common.type.ImageStatusResult;
import com.sequenceiq.cloudbreak.converter.spi.CredentialToCloudCredentialConverter;
import com.sequenceiq.cloudbreak.converter.spi.StackToCloudStackConverter;
import com.sequenceiq.cloudbreak.domain.Stack;
import com.sequenceiq.cloudbreak.service.image.ImageService;
import com.sequenceiq.cloudbreak.service.stack.connector.OperationException;
import com.sequenceiq.cloudbreak.service.stack.connector.ProvisionSetup;
import com.sequenceiq.cloudbreak.service.stack.event.PrepareImageComplete;
import com.sequenceiq.cloudbreak.service.stack.event.ProvisionEvent;
import com.sequenceiq.cloudbreak.service.stack.event.ProvisionSetupComplete;

import reactor.bus.Event;
import reactor.bus.EventBus;

@Component
public class ServiceProviderSetupAdapter implements ProvisionSetup {

    private static final Logger LOGGER = LoggerFactory.getLogger(ServiceProviderSetupAdapter.class);

    @Inject
    private EventBus eventBus;
    @Inject
    private StackToCloudStackConverter cloudStackConverter;
    @Inject
    private CredentialToCloudCredentialConverter credentialConverter;
    @Inject
    private ImageService imageService;

    @Override
    public CloudPlatform getCloudPlatform() {
        return CloudPlatform.ADAPTER;
    }

    @Override
    public ProvisionEvent prepareImage(Stack stack) throws Exception {
        CloudPlatform cloudPlatform = stack.cloudPlatform();
        Location location = location(region(stack.getRegion()), availabilityZone(stack.getAvailabilityZone()));
        CloudContext cloudContext = new CloudContext(stack.getId(), stack.getName(), stack.cloudPlatform().name(), stack.getOwner(), stack.getPlatformVariant(),
                location);
        CloudCredential cloudCredential = credentialConverter.convert(stack.getCredential());
        Image image = imageService.getImage(stack.getId());
        PrepareImageRequest<PrepareImageResult> prepareImageRequest = new PrepareImageRequest<>(cloudContext, cloudCredential, image);
        LOGGER.info("Triggering event: {}", prepareImageRequest);
        eventBus.notify(prepareImageRequest.selector(), Event.wrap(prepareImageRequest));
        try {
            PrepareImageResult res = prepareImageRequest.await();
            LOGGER.info("Result: {}", res);
            if (res.getErrorDetails() != null) {
                LOGGER.error("Failed to prepare image", res.getErrorDetails());
                throw new OperationException(res.getErrorDetails());
            }
            return new PrepareImageComplete(cloudPlatform, stack.getId());
        } catch (InterruptedException e) {
            LOGGER.error("Error while executing prepare image", e);
            throw new OperationException(e);
        }
    }

    @Override
    public ImageStatusResult checkImage(Stack stack) throws Exception {
        Location location = location(region(stack.getRegion()), availabilityZone(stack.getAvailabilityZone()));
        CloudContext cloudContext = new CloudContext(stack.getId(), stack.getName(), stack.cloudPlatform().name(), stack.getOwner(), stack.getPlatformVariant(),
                location);
        CloudCredential cloudCredential = credentialConverter.convert(stack.getCredential());
        Image image = imageService.getImage(stack.getId());
        CheckImageRequest<CheckImageResult> checkImageRequest = new CheckImageRequest<>(cloudContext, cloudCredential, image);
        LOGGER.info("Triggering event: {}", checkImageRequest);
        eventBus.notify(checkImageRequest.selector(), Event.wrap(checkImageRequest));
        try {
            CheckImageResult res = checkImageRequest.await();
            LOGGER.info("Result: {}", res);
            if (res.getErrorDetails() != null) {
                LOGGER.error("Failed to check image state", res.getErrorDetails());
                throw new OperationException(res.getErrorDetails());
            }
            return new ImageStatusResult(res.getImageStatus(), res.getStatusProgressValue());
        } catch (InterruptedException e) {
            LOGGER.error("Error while executing check image", e);
            throw new OperationException(e);
        }
    }

    @Override
    public ProvisionEvent setupProvisioning(Stack stack) throws Exception {
        CloudPlatform cloudPlatform = stack.cloudPlatform();
        Location location = location(region(stack.getRegion()), availabilityZone(stack.getAvailabilityZone()));
        CloudContext cloudContext = new CloudContext(stack.getId(), stack.getName(), stack.cloudPlatform().name(), stack.getOwner(), stack.getPlatformVariant(),
                location);
        CloudCredential cloudCredential = credentialConverter.convert(stack.getCredential());
        CloudStack cloudStack = cloudStackConverter.convert(stack);
        SetupRequest<SetupResult> setupRequest = new SetupRequest<>(cloudContext, cloudCredential, cloudStack);
        LOGGER.info("Triggering event: {}", setupRequest);
        eventBus.notify(setupRequest.selector(), Event.wrap(setupRequest));
        try {
            SetupResult res = setupRequest.await();
            LOGGER.info("Result: {}", res);
            if (res.getErrorDetails() != null) {
                LOGGER.error("Failed to setup provisioning", res.getErrorDetails());
                throw new OperationException(res.getErrorDetails());
            }
            return new ProvisionSetupComplete(cloudPlatform, stack.getId());
        } catch (InterruptedException e) {
            LOGGER.error("Error while executing provisioning setup", e);
            throw new OperationException(e);
        }
    }
}
