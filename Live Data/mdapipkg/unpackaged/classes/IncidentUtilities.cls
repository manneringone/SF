public class IncidentUtilities {
	@TestVisible
	private static BMCServiceDesk__Incident__c getIncident(BMCServiceDesk__BMC_BaseElement__c thisBaseElement) {
		BMCServiceDesk__Incident__c thisIncident = new BMCServiceDesk__Incident__c();
		thisIncident.BMCServiceDesk__FKClient__c = UserInfo.getUserId();

		if (thisBaseElement != null) {
			if (thisBaseElement.BMCServiceDesk__CMDB_Class__c == RemedyForceGlobalVariables.businessServiceClassId) {
				thisIncident.BMCServiceDesk__FKBusinessService__c = thisBaseElement.Id;
			} else {
				thisIncident.BMCServiceDesk__FKBMC_BaseElement__c = thisBaseElement.Id;
			}
		} else {
			thisIncident.BMCServiceDesk__FKBusinessService__c = null;
			thisIncident.BMCServiceDesk__FKBMC_BaseElement__c = null;
		}

		return thisIncident;
	}

	public static BMCServiceDesk__Incident__c getServiceCloudIncident(BMCServiceDesk__BMC_BaseElement__c thisBaseElement, Case thisCase) {
		BMCServiceDesk__Incident__c thisIncident = getIncident(thisBaseElement);
        thisIncident.BMCServiceDesk__FKTemplate__c = RemedyForceGlobalVariables.serviceCloudIncidentTemplateId;
        thisIncident.BMCServiceDesk__FKAccount__c = (thisCase == null ? null : thisCase.AccountId);
        thisIncident.BMCServiceDesk__shortDescription__c = (thisCase == null ? null : thisCase.Subject);
        thisIncident.BMCServiceDesk__incidentDescription__c = (thisCase == null ? null : thisCase.Description);

		return thisIncident;
	}

	public static BMCServiceDesk__Incident__c getServiceRequestIncident(BMCServiceDesk__BMC_BaseElement__c thisBaseElement) {
		BMCServiceDesk__Incident__c thisIncident = getIncident(thisBaseElement);
		thisIncident.BMCServiceDesk__FKRequestDefinition__c = RemedyForceGlobalVariables.serviceRequestDefinitionId;

		return thisIncident;
	}
}