public with sharing class RemedyForceGlobalVariables {
	@TestVisible
	private static String businessServiceClassName = Label.CMDB_Class_Class_Name_Business_Service;
	@TestVisible
	private static BMCServiceDesk__CMDB_Class__c thisBusinessServiceCmdbClass {
		get {
			if (thisBusinessServiceCmdbClass == null) {
				List<BMCServiceDesk__CMDB_Class__c> cmdbClasses = [SELECT Id
																		FROM BMCServiceDesk__CMDB_Class__c
																		WHERE BMCServiceDesk__ClassName__c = :businessServiceClassName];

				if (cmdbClasses.isEmpty() == false) {
					thisBusinessServiceCmdbClass = cmdbClasses[0];
				}
			}

			return thisBusinessServiceCmdbClass;
		}
		set;
	}

	public static Id businessServiceClassId {
		get {
			return (thisBusinessServiceCmdbClass == null ? null : thisBusinessServiceCmdbClass.Id);
		}
	}

	@TestVisible
	private static String serviceRequestDefinitionName = Label.Request_Definition_Name_Decommission_Service;
	@TestVisible
	private static BMCServiceDesk__SRM_RequestDefinition__c serviceRequestDefinition {
		get {
			if (serviceRequestDefinition == null) {
				System.debug('serviceRequestDefinitionName=' + serviceRequestDefinitionName);
				System.debug('[SELECT Id,Name FROM BMCServiceDesk__SRM_RequestDefinition__c]=' + [SELECT Id,Name FROM BMCServiceDesk__SRM_RequestDefinition__c]);
				List<BMCServiceDesk__SRM_RequestDefinition__c> requestDefinitions = [SELECT Id
																						FROM BMCServiceDesk__SRM_RequestDefinition__c
																						WHERE Name = :serviceRequestDefinitionName];
				System.debug('requestDefinitions=' + requestDefinitions);

				if (requestDefinitions.isEmpty() == false) {
					serviceRequestDefinition = requestDefinitions[0];
				}
				System.debug('serviceRequestDefinition=' + serviceRequestDefinition);
			}

			return serviceRequestDefinition;
		}
		set;
	}

	public static Id serviceRequestDefinitionId {
		get {
			return (serviceRequestDefinition == null ? null : serviceRequestDefinition.Id);
		}
	}

	@TestVisible
	private static String serviceCloudIncidentTemplateName = Label.Template_Name_Service_Cloud;
	@TestVisible
	private static BMCServiceDesk__SYSTemplate__c serviceCloudIncidentTemplate {
		get {
			if (serviceCloudIncidentTemplate == null) {
				List<BMCServiceDesk__SYSTemplate__c> templates = [SELECT Id
																	FROM BMCServiceDesk__SYSTemplate__c
																	WHERE Name = :serviceCloudIncidentTemplateName];

				if (templates.isEmpty() == false) {
					serviceCloudIncidentTemplate = templates[0];
				}
			}

			return serviceCloudIncidentTemplate;
		}
		set;
	}

	public static Id serviceCloudIncidentTemplateId {
		get {
			return (serviceCloudIncidentTemplate == null ? null : serviceCloudIncidentTemplate.Id);
		}
	}

	@TestVisible
	private static String closedStatusName = Label.Status_Name_Closed;
	@TestVisible
	private static BMCServiceDesk__Status__c closedStatus {
		get {
			if (closedStatus == null) {
				List<BMCServiceDesk__Status__c> statusList = [SELECT Id
																FROM BMCServiceDesk__Status__c
																WHERE Name = :closedStatusName];

				if (statusList.isEmpty() == false) {
					closedStatus = statusList[0];
				}
			}

			return closedStatus;
		}
		set;
	}

	public static Id closedStatusId {
		get {
			return (closedStatus == null ? null : closedStatus.Id);
		}
	}
}