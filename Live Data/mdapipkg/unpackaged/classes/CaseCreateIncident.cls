public with sharing class CaseCreateIncident {
    @TestVisible
    public Boolean hasGlobalError {
        get {
            if (hasGlobalError == null) {
                hasGlobalError = false;
            }

            return hasGlobalError;
        }
        private set;
    }

	public Case thisCase {
        get {
            if (thisCase == null) {
                thisCase = new Case();
            }

            return thisCase;
        }
        set;
    }

    public CaseCreateIncident(ApexPages.StandardController std) {
        Id caseId;
        if (std != null) {
            caseId = std.getId();
        }

        List<Case> cases = [SELECT Id, CaseNumber, AccountId, Incident__c, Subject, Description
                                FROM Case
                                WHERE Id = :caseId];

        if (cases.isEmpty()) {
            addGlobalError('Case not found');

            thisCase = new Case();
        } else {
            thisCase = cases[0];

            if (thisCase.Incident__c != null) {
                addGlobalError('An incident already exists for this Case');
            }
        }
    }

    @TestVisible
    private void addGlobalError(String errorMessage) {
        hasGlobalError = true;

        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, errorMessage));
    }

    public PageReference createIncident() {
        PageReference returnReference;

        if (hasGlobalError == false) {
            System.Savepoint thisSavepoint = Database.setSavepoint();

            BMCServiceDesk__Incident__c thisIncident = IncidentUtilities.getServiceCloudIncident(null, thisCase);

            Database.SaveResult incidentSaveResult = Database.insert(thisIncident, false);

            if (incidentSaveResult.isSuccess()) {
                thisCase.Incident__c = thisIncident.Id;

                Database.SaveResult caseSaveResult = Database.update(thisCase, false);

                if (caseSaveResult.isSuccess()) {
                    returnReference = (new ApexPages.StandardController(thisCase)).view();
                } else {
                    returnReference = handleDatabaseErrors(thisSavepoint, caseSaveResult);
                }
            } else {
                returnReference = handleDatabaseErrors(thisSavepoint, incidentSaveResult);
            }
        }

        return returnReference;
    }

    @TestVisible
    private PageReference handleDatabaseErrors(System.Savepoint thisSavepoint, Database.SaveResult thisSaveResult) {
        if (thisSaveResult != null) {
            for (Database.Error thisError : thisSaveResult.getErrors()) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, thisError.getMessage()));
            }
        }

        if (thisSavepoint != null) {
            Database.rollback(thisSavepoint);
        }

        return null;
    }
}