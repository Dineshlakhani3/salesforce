<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Your_loan_has_been_approved</fullName>
        <description>Your loan has been approved</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Approved</template>
    </alerts>
    <alerts>
        <fullName>Your_loan_has_been_reject</fullName>
        <description>Your loan has been reject</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Reject</template>
    </alerts>
</Workflow>
