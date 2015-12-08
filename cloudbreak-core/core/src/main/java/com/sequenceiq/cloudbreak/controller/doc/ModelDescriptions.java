package com.sequenceiq.cloudbreak.controller.doc;

public class ModelDescriptions {

    public static final String ID = "id of the resource";
    public static final String NAME = "name of the resource";
    public static final String DESCRIPTION = "description of the resource";
    public static final String PUBLIC_IN_ACCOUNT = "resource is visible in account";
    public static final String CLOUD_PLATFORM = "type of cloud provider";
    public static final String OWNER = "id of the resource owner that is provided by OAuth provider";
    public static final String ACCOUNT = "account id of the resource owner that is provided by OAuth provider";

    private ModelDescriptions() {
    }

    public static class BlueprintModelDescription {
        public static final String URL = "url source of an ambari blueprint, set this or the ambariBlueprint field";
        public static final String BLUEPRINT_NAME = "gathered from blueprintName field from the blueprint JSON";
        public static final String AMBARI_BLUEPRINT = "ambari blueprint JSON, set this or the url field";
        public static final String HOST_GROUP_COUNT = "number of host groups";
    }

    public static class CredentialModelDescription {
        public static final String PUBLIC_KEY = "public key for accessing instances";
        public static final String LOGIN_USERNAME = "authentication name for machines";
        public static final String PARAMETERS = "cloud specific parameters for credential";
    }

    public static class TemplateModelDescription {
        public static final String VOLUME_COUNT = "number of volumes";
        public static final String VOLUME_SIZE = "size of volumes";
        public static final String PARAMETERS = "cloud specific parameters for template";
    }

    public static class StackModelDescription {
        public static final String STACK_ID = "id of the stack";
        public static final String STACK_NAME = "name of the stack";
        public static final String REGION = "region of the stack";
        public static final String AVAILABILITY_ZONE = "availability zone of the stack";
        public static final String CREDENTIAL_ID = "credential resource id for the stack";
        public static final String USERNAME = "ambari username";
        public static final String PASSWORD = "ambari password";
        public static final String CONSUL_SERVER_COUNT = "consul server count";
        public static final String CONSUL_SERVER_COUNT_BY_USER = "user defined consul server count";
        public static final String PARAMETERS = "additional cloud specific parameters for stack";
        public static final String SECURITY_GROUP_ID = "security group resource id for the stack";
        public static final String FAILURE_ACTION = "action on failure";
        public static final String FAILURE_POLICY = "failure policy in case of failures";
        public static final String STACK_STATUS = "status of the stack";
        public static final String STATUS_REASON = "status message of the stack";
        public static final String AMBARI_IP = "public ambari ip of the stack";
        public static final String HASH = "unique hash identifier for stack";
        public static final String BLUEPRINT_ID = "id of the referenced blueprint";
        public static final String NETWORK_ID = "network resource id for the stack";
        public static final String CERTIFICATE = "certificate used by the gateway";
        public static final String CLUSTER_STATUS = "status of the cluster";
        public static final String PLATFORM_VARIANT = "cloud provider api variant";
    }

    public static class ClusterModelDescription {
        public static final String STATUS = "status of the cluster";
        public static final String STATUS_REASON = "status message of the cluster";
        public static final String CLUSTER_NAME = "name of the cluster";
        public static final String BLUEPRINT_ID = "blueprint id for the cluster";
        public static final String HOURS = "duration - how long the cluster is running in hours";
        public static final String MINUTES = "duration - how long the cluster is running in minutes (minus hours)";
        public static final String EMAIL_NEEDED = "send email about the result of the cluster installation";
        public static final String SERVICE_ENDPOINT_MAP = "most important services in the cluster";
    }

    public static class AmbariStackDetailsDescription {
        public static final String STACK = "name of the stack, like HDP";
        public static final String VERSION = "version of the stack";
        public static final String OS = "operating system for the stack, like redhat6";
        public static final String STACK_REPO_ID = "id of the stack repository";
        public static final String UTILS_REPO_ID = "id of the stack utils repository";
        public static final String STACK_BASE_URL = "url of the stack repository";
        public static final String UTILS_BASE_URL = "url of the stack utils repository";
        public static final String VERIFY = "whether to verify or not the repo url";
    }

    public static class FileSystem {
        public static final String NAME = "name of the filesystem";
        public static final String TYPE = "type of the filesystem";
        public static final String DEFAULT = "true if fs.defaultFS should point to this filesystem";
        public static final String PROPERTIES = "configuration of the filesystem access as key-value pairs";
    }

    public static class RecipeModelDescription {
        public static final String TIMEOUT = "recipe timeout in minutes";
        public static final String PLUGINS = "list of consul plugins with execution types";
        public static final String PROPERTIES = "additional plugin properties";
    }

    public static class InstanceGroupModelDescription {
        public static final String INSTANCE_GROUP_NAME = "name of the instance group";
        public static final String INSTANCE_GROUP_TYPE = "type of the instance group";
        public static final String NODE_COUNT = "number of nodes";
        public static final String TEMPLATE_ID = "referenced template id";
        public static final String STATUS = "status of the instance";
    }

    public static class InstanceGroupAdjustmentModelDescription {
        public static final String SCALING_ADJUSTMENT = "scaling adjustment of the instance groups";
        public static final String WITH_CLUSTER_EVENT = "on stack update, update cluster too";
    }

    public static class HostGroupModelDescription {
        public static final String RECIPE_IDS = "referenced recipe ids";
        public static final String HOST_GROUP_NAME = "name of the host group";
    }

    public static class UserNamePasswordModelDescription {
        public static final String NEW_USER_NAME = "new user name in ambari";
        public static final String OLD_PASSWORD = "old password in ambari";
        public static final String NEW_PASSWORD = "new password in ambari";
    }

    public static class HostMetadataModelDescription {
        public static final String STATE = "state of the host";
    }

    public static class HostGroupAdjustmentModelDescription {
        public static final String SCALING_ADJUSTMENT = "scaling adjustment of the host groups";
        public static final String WITH_STACK_UPDATE = "on cluster update, update stack too";
    }

    public static class InstanceMetaDataModelDescription {
        public static final String PRIVATE_IP = "private ip of the insctance";
        public static final String PUBLIC_IP = "public ip of the instance";
        public static final String INSTANCE_ID = "id of the instance";
        public static final String VOLUME_COUNT = "number of volumes";
        public static final String AMBARI_SERVER = "ambari server address";
        public static final String DOCKER_SUBNET = "docker subnet";
        public static final String DISCOVERY_FQDN = "the fully qualified domain name of the node in the service discovery cluster";
        public static final String CONTAINER_COUNT = "number of the containers";
    }

    public static class FailurePolicyModelDescription {
        public static final String THRESHOLD = "threshold of failure policy";
    }

    public static class UsageModelDescription {
        public static final String PROVIDER = "cloud provider of the stack";
        public static final String COSTS = "computed costs of instance usage";
        public static final String DAY = "days since the instance is running";
        public static final String INSTANCE_HOURS = "hours since the instance is running";
        public static final String INSTANCE_TYPE = "type of instance";
        public static final String INSTANCE_GROUP = "group name of instance";
    }

    public static class EventModelDescription {
        public static final String NODE_COUNT = "computed node count of the stack";
        public static final String TYPE = "type of the event";
        public static final String TIMESTAMP = "timestamp of the event";
        public static final String MESSAGE = "message of the event";
    }

    public static class NetworkModelDescription {
        public static final String PARAMETERS = "provider specific parameters of the specified network";
        public static final String SUBNET_CIDR = "the subnet definition of the network in CIDR format";
    }

    public static class SecurityGroupModelDescription {
        public static final String SECURITY_RULES = "list of security rules that relates to the security group";
    }

    public static class SecurityRuleModelDescription {
        public static final String SUBNET = "definition of allowed subnet in CIDR format";
        public static final String PORTS = "comma separated list of accessible ports";
        public static final String PROTOCOL = "protocol of the rule";
        public static final String MODIFIABLE = "flag for making the rule modifiable";
    }

    public static class AccountPreferencesModelDescription {
        public static final String MAX_NO_CLUSTERS = "max number of clusters in the account (0 when unlimited)";
        public static final String MAX_NO_NODES_PER_CLUSTER = "max number of vms in a cluster of account (0 when unlimited)";
        public static final String MAX_NO_CLUSTERS_PER_USER = "max number of clusters for user within the account (0 when unlimited)";
        public static final String ALLOWED_INSTANCE_TYPES = "allowed instance types in the account (empty list for no restriction)";
        public static final String CLUSTER_TIME_TO_LIVE = "lifecycle of the cluster in hours (0 for immortal clusters)";
        public static final String ACCOUNT_TIME_TO_LIVE = "lifecycle of the account and its clusters in hours (0 for immortal account)";
    }
}
