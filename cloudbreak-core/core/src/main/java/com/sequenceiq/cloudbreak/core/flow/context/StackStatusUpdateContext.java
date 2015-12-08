package com.sequenceiq.cloudbreak.core.flow.context;

import com.sequenceiq.cloudbreak.common.type.CloudPlatform;

public class StackStatusUpdateContext extends DefaultFlowContext implements FlowContext {
    private boolean start;

    public StackStatusUpdateContext(Long stackId, CloudPlatform cloudPlatform, boolean start) {
        super(stackId, cloudPlatform);
        this.start = start;
    }

    public StackStatusUpdateContext(Long stackId, CloudPlatform cloudPlatform, boolean start, String statusReason) {
        super(stackId, cloudPlatform, statusReason);
        this.start = start;
    }

    public boolean isStart() {
        return start;
    }

}
