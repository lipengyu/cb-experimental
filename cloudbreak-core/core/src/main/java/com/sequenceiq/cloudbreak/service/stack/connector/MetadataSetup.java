package com.sequenceiq.cloudbreak.service.stack.connector;

import java.util.Set;

import com.sequenceiq.cloudbreak.common.type.CloudPlatform;
import com.sequenceiq.cloudbreak.domain.InstanceGroup;
import com.sequenceiq.cloudbreak.domain.Resource;
import com.sequenceiq.cloudbreak.common.type.ResourceType;
import com.sequenceiq.cloudbreak.domain.Stack;
import com.sequenceiq.cloudbreak.service.stack.flow.CoreInstanceMetaData;
import com.sequenceiq.cloudbreak.service.stack.flow.InstanceSyncState;

public interface MetadataSetup {

    Set<CoreInstanceMetaData> collectMetadata(Stack stack);

    Set<CoreInstanceMetaData> collectNewMetadata(Stack stack, Set<Resource> resourceList, String instanceGroup, Integer scalingAdjustment);

    InstanceSyncState getState(Stack stack, InstanceGroup instanceGroup, String instanceId);

    CloudPlatform getCloudPlatform();

    ResourceType getInstanceResourceType();
}
