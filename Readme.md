Queueable Example

---------------------------------------------------------------------------------------------------------------------------------------------------
Create a custom sObject "Pay Check" which will be the child to Contact Standard sObject.
	On Contact create a Number Field called "Total Pays".
	Create a Queueable class which should be enqueued to create multiple Pay Checks records on Contact based on the value-added in Contact's "Total Pays" and test class for the same.
	e.g. If Contact.Total_Pays__c = 5 then, Create 5 Pay Check Records on the Same Contact.
	Now, Create a custom Setting "Limit" and a Number Field on the same Custom Setting with the name of "ThresHold" and store 25 as a value there.
	If the Contact.Total_Pays__c < Limit.Threshold(fetch the value from Custom Setting) then, add the creation logic of Pay Check records inside the Queueable's Execute.
	Again, If the Contact.Total_Pays__c > Limit.Threshold(fetch the from Custom Setting), then call a Batch class named "PayCheckBatch" where you'll Pass the Same Contacts to create "Pay Check" records based on the Contact.Total_Pays__c value.
	For the above, you'll have to create a Batch Class called "PayCheckBatch" and test class for the same.
	The Timeline for the above task is tomorrow's First half.

---------------------------------------------------------------------------------------------------------------------------------------------------
