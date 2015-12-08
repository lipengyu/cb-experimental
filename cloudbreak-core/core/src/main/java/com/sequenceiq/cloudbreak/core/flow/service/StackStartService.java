package com.sequenceiq.cloudbreak.core.flow.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.sequenceiq.cloudbreak.core.CloudbreakException;
import com.sequenceiq.cloudbreak.core.flow.context.FlowContext;
import com.sequenceiq.cloudbreak.core.flow.context.StackStatusUpdateContext;
import com.sequenceiq.cloudbreak.domain.Stack;
import com.sequenceiq.cloudbreak.repository.StackRepository;
import com.sequenceiq.cloudbreak.service.CloudPlatformResolver;

@Service
public class StackStartService {

    private static final Logger LOGGER = LoggerFactory.getLogger(StackStartService.class);

    @Inject
    private StackRepository stackRepository;

    @Inject
    private CloudPlatformResolver platformResolver;

    public FlowContext start(FlowContext context) throws CloudbreakException {
        StackStatusUpdateContext stackStatusUpdateContext = (StackStatusUpdateContext) context;
        Stack stack = stackRepository.findOneWithLists(stackStatusUpdateContext.getStackId());
        platformResolver.connector(stack.cloudPlatform()).startAll(stack);
        return stackStatusUpdateContext;
    }
}
