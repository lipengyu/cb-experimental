package com.sequenceiq.cloudbreak.service.credential;

import com.sequenceiq.cloudbreak.common.type.CloudPlatform;
import com.sequenceiq.cloudbreak.domain.Credential;

public interface CredentialHandler<T extends Credential> {

    CloudPlatform getCloudPlatform();

    T init(T credential);

    T update(T credential) throws Exception;
}
