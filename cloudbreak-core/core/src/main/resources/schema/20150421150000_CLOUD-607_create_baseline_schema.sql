-- // create baseline


--
-- Name: blueprint; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE blueprint (
    id bigint NOT NULL,
    account character varying(255),
    blueprintname character varying(255),
    blueprinttext text,
    description text,
    hostgroupcount integer NOT NULL,
    name character varying(255) NOT NULL,
    owner character varying(255),
    publicinaccount boolean NOT NULL
);

--
-- Name: blueprint_table; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE blueprint_table
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cloudbreakevent; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE cloudbreakevent (
    id bigint NOT NULL,
    account character varying(255),
    blueprintid bigint NOT NULL,
    blueprintname character varying(255),
    cloud character varying(255),
    eventmessage character varying(255),
    eventtimestamp timestamp without time zone,
    eventtype character varying(255),
    instancegroup character varying(255),
    nodecount integer,
    owner character varying(255),
    region character varying(255),
    stackid bigint,
    stackname character varying(255),
    stackstatus character varying(255)
);


--
-- Name: cloudbreakusage; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE cloudbreakusage (
    id bigint NOT NULL,
    account character varying(255),
    costs double precision,
    day timestamp without time zone,
    instancegroup character varying(255),
    instancehours bigint,
    instancetype character varying(255),
    owner character varying(255),
    provider character varying(255),
    region character varying(255),
    stackid bigint,
    stackname character varying(255)
);


--
-- Name: cluster; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE cluster (
    id bigint NOT NULL,
    account character varying(255),
    creationfinished bigint,
    creationstarted bigint,
    description text,
    emailneeded boolean,
    kerberosadmin character varying(255),
    kerberosmasterkey character varying(255),
    kerberospassword character varying(255),
    name character varying(255) NOT NULL,
    owner character varying(255),
    secure boolean,
    status character varying(255),
    statusreason text,
    upsince bigint,
    blueprint_id bigint
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE credential (
    dtype character varying(31) NOT NULL,
    id bigint NOT NULL,
    account character varying(255),
    description text,
    name character varying(255) NOT NULL,
    owner character varying(255),
    publicinaccount boolean NOT NULL,
    publickey text,
    endpoint character varying(255),
    password character varying(255),
    tenantname character varying(255),
    username character varying(255),
    projectid character varying(255),
    serviceaccountid character varying(255),
    serviceaccountprivatekey text,
    keypairname character varying(255),
    rolearn character varying(255),
    cerfile text,
    jks character varying(255),
    jksfile text,
    postfix character varying(255),
    sshcerfile text,
    subscriptionid character varying(255),
    temporaryawscredentials_accesskeyid character varying(255)
);

--
-- Name: credential_table; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE credential_table
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failurepolicy; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE failurepolicy (
    id bigint NOT NULL,
    adjustmenttype character varying(255),
    threshold bigint
);


--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: hostgroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE hostgroup (
    id bigint NOT NULL,
    name character varying(255),
    cluster_id bigint,
    instancegroup_id bigint
);



--
-- Name: hostgroup_recipe; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE hostgroup_recipe (
    hostgroup_id bigint NOT NULL,
    recipes_id bigint NOT NULL
);



--
-- Name: hostmetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE hostmetadata (
    id bigint NOT NULL,
    hostname character varying(255),
    hostgroup_id bigint
);


--
-- Name: instancegroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE instancegroup (
    id bigint NOT NULL,
    groupname character varying(255),
    instancegrouptype character varying(255),
    nodecount integer,
    stack_id bigint,
    template_id bigint
);


--
-- Name: instancemetadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE instancemetadata (
    id bigint NOT NULL,
    ambariserver boolean,
    consulserver boolean,
    containercount integer,
    dockersubnet character varying(255),
    instanceid character varying(255),
    instancestatus character varying(255),
    longname character varying(255),
    privateip character varying(255),
    publicip character varying(255),
    startdate bigint,
    terminationdate bigint,
    volumecount integer,
    instancegroup_id bigint
);



--
-- Name: recipe; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE recipe (
    id bigint NOT NULL,
    account character varying(255),
    description character varying(255),
    name character varying(255),
    owner character varying(255),
    publicinaccount boolean NOT NULL,
    timeout integer
);



--
-- Name: recipe_keyvalues; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE recipe_keyvalues (
    recipe_id bigint NOT NULL,
    value text,
    key character varying(255) NOT NULL
);


--
-- Name: recipe_plugins; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE recipe_plugins (
    recipe_id bigint NOT NULL,
    execution_type character varying(255),
    plugin character varying(255) NOT NULL
);


--
-- Name: resource; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE resource (
    id bigint NOT NULL,
    instancegroup character varying(255),
    resourcename character varying(255),
    resourcetype character varying(255),
    resource_stack bigint
);


--
-- Name: sequence_table; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sequence_table
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stack; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE stack (
    id bigint NOT NULL,
    account character varying(255),
    ambariip character varying(255),
    consulservers integer NOT NULL,
    description text,
    hash character varying(255),
    image character varying(255),
    metadataready boolean NOT NULL,
    name character varying(255) NOT NULL,
    onfailureactionaction character varying(255),
    owner character varying(255),
    password character varying(255),
    publicinaccount boolean NOT NULL,
    region character varying(255),
    status character varying(255),
    statusreason text,
    username character varying(255),
    version bigint,
    cluster_id bigint,
    credential_id bigint,
    failurepolicy_id bigint
);


--
-- Name: stack_parameters; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE stack_parameters (
    stack_id bigint NOT NULL,
    value text,
    key character varying(255) NOT NULL
);


--
-- Name: stack_table; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stack_table
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subnet; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE subnet (
    id bigint NOT NULL,
    cidr character varying(255),
    modifiable boolean NOT NULL,
    stack_id bigint
);


--
-- Name: subscription; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE subscription (
    id bigint NOT NULL,
    clientid character varying(255),
    endpoint character varying(255)
);


--
-- Name: template; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE template (
    dtype character varying(31) NOT NULL,
    id bigint NOT NULL,
    account character varying(255),
    deleted boolean NOT NULL,
    description text,
    name character varying(255) NOT NULL,
    owner character varying(255),
    publicinaccount boolean NOT NULL,
    volumecount integer,
    volumesize integer,
    gccinstancetype character varying(255),
    gccrawdisktype character varying(255),
    instancetype character varying(255),
    publicnetid character varying(255),
    encrypted character varying(255),
    spotprice double precision,
    sshlocation character varying(255),
    volumetype character varying(255),
    vmtype character varying(255)
);


--
-- Name: temporaryawscredentials; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE temporaryawscredentials (
    accesskeyid character varying(255) NOT NULL,
    secretaccesskey character varying(255),
    sessiontoken text,
    validuntil bigint NOT NULL
);


--
-- Name: blueprint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY blueprint
    ADD CONSTRAINT blueprint_pkey PRIMARY KEY (id);


--
-- Name: cloudbreakevent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY cloudbreakevent
    ADD CONSTRAINT cloudbreakevent_pkey PRIMARY KEY (id);


--
-- Name: cloudbreakusage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY cloudbreakusage
    ADD CONSTRAINT cloudbreakusage_pkey PRIMARY KEY (id);


--
-- Name: cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY cluster
    ADD CONSTRAINT cluster_pkey PRIMARY KEY (id);


--
-- Name: credential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT credential_pkey PRIMARY KEY (id);


--
-- Name: failurepolicy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY failurepolicy
    ADD CONSTRAINT failurepolicy_pkey PRIMARY KEY (id);


--
-- Name: hostgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY hostgroup
    ADD CONSTRAINT hostgroup_pkey PRIMARY KEY (id);


--
-- Name: hostgroup_recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY hostgroup_recipe
    ADD CONSTRAINT hostgroup_recipe_pkey PRIMARY KEY (hostgroup_id, recipes_id);


--
-- Name: hostmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY hostmetadata
    ADD CONSTRAINT hostmetadata_pkey PRIMARY KEY (id);


--
-- Name: instancegroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY instancegroup
    ADD CONSTRAINT instancegroup_pkey PRIMARY KEY (id);


--
-- Name: instancemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY instancemetadata
    ADD CONSTRAINT instancemetadata_pkey PRIMARY KEY (id);


--
-- Name: recipe_keyvalues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY recipe_keyvalues
    ADD CONSTRAINT recipe_keyvalues_pkey PRIMARY KEY (recipe_id, key);


--
-- Name: recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY recipe
    ADD CONSTRAINT recipe_pkey PRIMARY KEY (id);


--
-- Name: recipe_plugins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY recipe_plugins
    ADD CONSTRAINT recipe_plugins_pkey PRIMARY KEY (recipe_id, plugin);


--
-- Name: resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);


--
-- Name: stack_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY stack_parameters
    ADD CONSTRAINT stack_parameters_pkey PRIMARY KEY (stack_id, key);


--
-- Name: stack_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY stack
    ADD CONSTRAINT stack_pkey PRIMARY KEY (id);


--
-- Name: subnet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY subnet
    ADD CONSTRAINT subnet_pkey PRIMARY KEY (id);


--
-- Name: subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (id);


--
-- Name: template_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY template
    ADD CONSTRAINT template_pkey PRIMARY KEY (id);


--
-- Name: temporaryawscredentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY temporaryawscredentials
    ADD CONSTRAINT temporaryawscredentials_pkey PRIMARY KEY (accesskeyid);


--
-- Name: uk_4k41j29yr72m8g4jswkxae3wf; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT uk_credential_account_name UNIQUE (account, name);


--
-- Name: uk_6linr69q0qs341t4dwksmj2k5; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY blueprint
    ADD CONSTRAINT uk_blueprint_account_name UNIQUE (account, name);


--
-- Name: uk_mo42wgq8xghku0pud0d7u9gxq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY recipe
    ADD CONSTRAINT uk_recipe_account_name UNIQUE (account, name);


--
-- Name: uk_pcvp0gu76lf195n5e4bwn62hb; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY template
    ADD CONSTRAINT uk_template_account_name UNIQUE (account, name);


--
-- Name: uk_q7w7pdmjrdfy3qfst9l8nr2qb; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY stack
    ADD CONSTRAINT uk_stack_account_name UNIQUE (account, name);


--
-- Name: uk_qdso8lss2eqqwfaombyqmv02g; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY cluster
    ADD CONSTRAINT uk_cluster_account_name UNIQUE (account, name);


--
-- Name: fk_51q9ax178o05oeghwi0hr8is5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT fk_credential_temporaryawscredentials_accesskeyid FOREIGN KEY (temporaryawscredentials_accesskeyid) REFERENCES temporaryawscredentials(accesskeyid);


--
-- Name: fk_5k57kt8hao4tipnk2umnxe0yn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hostmetadata
    ADD CONSTRAINT fk_credential_hostgroup_id FOREIGN KEY (hostgroup_id) REFERENCES hostgroup(id);


--
-- Name: fk_7175vk9tgmhvq04moxgqv5e8o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stack
    ADD CONSTRAINT fk_stack_credential_id FOREIGN KEY (credential_id) REFERENCES credential(id);


--
-- Name: fk_72cagekv8hcc33jeb47cyxyri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stack
    ADD CONSTRAINT fk_stack_failurepolicy_id FOREIGN KEY (failurepolicy_id) REFERENCES failurepolicy(id);


--
-- Name: fk_8u5d88nlm8c16970kb9km4sft; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recipe_keyvalues
    ADD CONSTRAINT fk_recipe_keyvalues_recipe_id FOREIGN KEY (recipe_id) REFERENCES recipe(id);


--
-- Name: fk_92s82wcie3ogn4ohtjrbrmhaq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instancegroup
    ADD CONSTRAINT fk_instancegroup_stack_id FOREIGN KEY (stack_id) REFERENCES stack(id);


--
-- Name: fk_al5gsr371caho71l56lx1c9ff; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stack
    ADD CONSTRAINT fk_stack_cluster_id FOREIGN KEY (cluster_id) REFERENCES cluster(id);


--
-- Name: fk_exmyy4cp2bumxgas1fu7ngsn0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT fk_resource_resource_stack FOREIGN KEY (resource_stack) REFERENCES stack(id);


--
-- Name: fk_hqexgxamn3rb3rb1tqeieoabx; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stack_parameters
    ADD CONSTRAINT fk_stack_parameters_stack_id FOREIGN KEY (stack_id) REFERENCES stack(id);


--
-- Name: fk_i1l3439ihtev4gi9fqkj2f8ko; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recipe_plugins
    ADD CONSTRAINT fk_recipe_plugins_recipe_id FOREIGN KEY (recipe_id) REFERENCES recipe(id);


--
-- Name: fk_illyjalblhf0o1eilo7r65rdd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cluster
    ADD CONSTRAINT fk_cluster_blueprint_id FOREIGN KEY (blueprint_id) REFERENCES blueprint(id);


--
-- Name: fk_k6ykksyri55tik7p4njurovk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hostgroup_recipe
    ADD CONSTRAINT fk_hostgroup_recipe_recipes_id FOREIGN KEY (recipes_id) REFERENCES recipe(id);


--
-- Name: fk_m9cnw9ixk8y44uvdaq41wxu91; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instancemetadata
    ADD CONSTRAINT fk_instancemetadata_instancegroup_id FOREIGN KEY (instancegroup_id) REFERENCES instancegroup(id);


--
-- Name: fk_ninuqigdnafac9fuwm5ia0np3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hostgroup_recipe
    ADD CONSTRAINT fk_hostgroup_recipe_hostgroup_id FOREIGN KEY (hostgroup_id) REFERENCES hostgroup(id);


--
-- Name: fk_ofdfpdym6h4ri22dx5d41txe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subnet
    ADD CONSTRAINT fk_subnet_stack_id FOREIGN KEY (stack_id) REFERENCES stack(id);


--
-- Name: fk_r1jejvs5t9rcnr5grr0popkp7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instancegroup
    ADD CONSTRAINT fk_instancegroup_template_id FOREIGN KEY (template_id) REFERENCES template(id);


--
-- Name: fk_skihiei13mu259om0q2ic83y1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hostgroup
    ADD CONSTRAINT fk_hostgroup_cluster_id FOREIGN KEY (cluster_id) REFERENCES cluster(id);


--
-- Name: fk_sridmlmxkiqigk3p62kh52sdx; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hostgroup
    ADD CONSTRAINT fk_hostgroup_instancegroup_id FOREIGN KEY (instancegroup_id) REFERENCES instancegroup(id);




-- //@UNDO

