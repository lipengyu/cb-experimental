package com.sequenceiq.cloudbreak.cloud.model;

import com.sequenceiq.cloudbreak.cloud.model.generic.StringType;

public class Region extends StringType {

    private Region(String value) {
        super(value);
    }

    public static Region region(String value) {
        return new Region(value);
    }

}
