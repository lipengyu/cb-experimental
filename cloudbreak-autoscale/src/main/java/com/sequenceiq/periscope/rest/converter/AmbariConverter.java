package com.sequenceiq.periscope.rest.converter;

import org.springframework.stereotype.Component;

import com.sequenceiq.periscope.domain.Ambari;
import com.sequenceiq.periscope.rest.json.AmbariJson;

@Component
public class AmbariConverter extends AbstractConverter<AmbariJson, Ambari> {

    @Override
    public Ambari convert(AmbariJson source) {
        return new Ambari(source.getHost(), source.getPort(), source.getUser(), source.getPass());
    }

}
