package com.sequenceiq.cloudbreak.converter;

import static com.sequenceiq.cloudbreak.common.type.Status.REQUESTED;

import org.springframework.stereotype.Component;

import com.sequenceiq.cloudbreak.controller.json.AmbariStackDetailsJson;
import com.sequenceiq.cloudbreak.controller.json.ClusterRequest;
import com.sequenceiq.cloudbreak.controller.json.FileSystemBase;
import com.sequenceiq.cloudbreak.domain.AmbariStackDetails;
import com.sequenceiq.cloudbreak.domain.Cluster;
import com.sequenceiq.cloudbreak.domain.FileSystem;

@Component
public class JsonToClusterConverter extends AbstractConversionServiceAwareConverter<ClusterRequest, Cluster> {
    @Override
    public Cluster convert(ClusterRequest source) {
        Cluster cluster = new Cluster();
        cluster.setName(source.getName());
        cluster.setStatus(REQUESTED);
        cluster.setDescription(source.getDescription());
        cluster.setEmailNeeded(source.getEmailNeeded());
        cluster.setUserName(source.getUserName());
        cluster.setPassword(source.getPassword());
        Boolean enableSecurity = source.getEnableSecurity();
        cluster.setSecure(enableSecurity == null ? false : enableSecurity);
        cluster.setKerberosMasterKey(source.getKerberosMasterKey());
        cluster.setKerberosAdmin(source.getKerberosAdmin());
        cluster.setKerberosPassword(source.getKerberosPassword());
        AmbariStackDetailsJson ambariStackDetails = source.getAmbariStackDetails();
        if (ambariStackDetails != null) {
            cluster.setAmbariStackDetails(getConversionService().convert(ambariStackDetails, AmbariStackDetails.class));
        }
        FileSystemBase fileSystem = source.getFileSystem();
        if (fileSystem != null) {
            cluster.setFileSystem(getConversionService().convert(fileSystem, FileSystem.class));
        }
        return cluster;
    }
}
