<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Xrm Service Toolkit Test(Html)</title>
    <!--    <link rel="stylesheet" href="new_qunit.css" type="text/css" media="screen" />
        <script type="text/javascript" src="ClientGlobalContext.js.aspx"></script>
        <script type="text/javascript" src="new_json2.js"></script>
        <script type="text/javascript" src="new_jquery.js"></script>
        <script type="text/javascript" src="new_qunit.js"></script>
        <script type="text/javascript" src="new_XrmServiceToolkit.js"></script>-->
    <link rel="stylesheet" href="Scripts/qunit/qunit.css" type="text/css" media="screen" />
    <script src="Scripts/helper/PageData.js" type="text/javascript"></script>
    <script src="Scripts/helper/XrmPageTemplate.js" type="text/javascript"></script>
    <script type="text/javascript" src="Scripts/helper/json2.js"></script>
    <script type="text/javascript" src="Scripts/helper/jquery.js"></script>
    <script type="text/javascript" src="Scripts/qunit/qunit.js"></script>
    <script type="text/javascript" src="Scripts/helper/XrmServiceToolkit.js"></script>
    <script type="text/javascript">

        /**
        * MSCRM 2011 Web Service Toolkit UnitTest and Example for JavaScript
        * @author Jaimie Ji
        * @current version : 2.0.1 (beta)
        *   Date: April, 2014
        *   CRM 2013 Beta release 
        *   Development Tool: VS2012, CRM2013 SDK beta release
        * Credits:
        *   The idea of this library and Unit Testing was inspired by Daniel Cai's CrmWebServiceToolkit.
        * Date: November, 2012
        */
        var guidExpr = /^(\{)?([0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12})(\})?$/;
        var contactId = "00000000-0000-0000-0000-000000000000";
        var birthDate = new Date("20 Feb 1955");
        var currentUserId = "00000000-0000-0000-0000-000000000000";
        var whoamiUserId = "00000000-0000-0000-0000-000000000000";
        var accountId = "00000000-0000-0000-0000-000000000000";
        var emailId = "00000000-0000-0000-0000-000000000000";

        //Test Rest and Soap Functions
        try {
            QUnit.config.reorder = false;

            
            var fetchXml =
                  "<fetch mapping='logical'>" +
                     "<entity name='contact'>" +
                        "<attribute name='contactid' />" +
                        "<attribute name='firstname' />" +
                        "<attribute name='lastname' />" +
                        "<attribute name='middlename' />" +
                        "<attribute name='familystatuscode' />" +
                        "<attribute name='ownerid' />" +
                        "<attribute name='creditlimit' />" +
                        "<attribute name='birthdate' />" +
                        "<attribute name='accountrolecode' />" +
                        "<attribute name='donotemail' />" +
                        "<attribute name='donotphone' />" +
                        "<filter>" +
                           "<condition attribute='statecode' operator='eq' value='" + 0 + "' />" +
                        "</filter>" +
                     "</entity>" +
                  "</fetch>";

            var retrievedContacts = XrmServiceToolkit.Soap.Fetch(fetchXml, false);

            //test("Test XrmServiceToolkit.Soap.Fetch() method to retrieve a CRM record (account)", function () {

            //    var fetchXml = "<fetch version='1.0' output-format='xml-platform' mapping='logical' distinct='false'>" +
            //                     "<entity name='account'>" +
            //                       "<attribute name='name' />" +
            //                       "<attribute name='address1_city' />" +
            //                       "<attribute name='primarycontactid' />" +
            //                       "<attribute name='telephone1' />" +
            //                       "<attribute name='accountid' />" +
            //                       "<order attribute='name' descending='false' />" +
            //                       "<order attribute='createdon' descending='false' />" +
            //                       "<filter type='and'>" +
            //                         "<condition attribute='statecode' operator='eq' value='0' />" +
            //                       "</filter>" +
            //                       "<link-entity name='contact' from='contactid' to='primarycontactid' visible='false' link-type='outer' alias='primarycontact'>" +
            //                         "<attribute name='emailaddress1' />" +
            //                         "<attribute name='statuscode' />" +
            //                         "<attribute name='statecode' />" +
            //                         "<attribute name='numberofchildren' />" +
            //                         "<attribute name='exchangerate' />" +
            //                         "<attribute name='educationcode' />" +
            //                         "<attribute name='creditonhold' />" +
            //                         "<attribute name='createdby' />" +
            //                         "<attribute name='parentcustomerid' />" +
            //                         "<attribute name='birthdate' />" +
            //                         "<attribute name='annualincome' />" +
            //                         "<attribute name='address1_line1' />" +
            //                         "<attribute name='description' />" +
            //                         "<attribute name='address1_latitude' />" +
            //                         "<attribute name='createdon' />" +
            //                         "<attribute name='creditlimit' />" +
            //                       "</link-entity>" +
            //                     "</entity>" +
            //                   "</fetch>";

            //    var results = XrmServiceToolkit.Soap.Fetch(fetchXml, true);

            //    var entity = new XrmServiceToolkit.Soap.BusinessEntity("account", results[0].id);
            //    var name = results[0].attributes["name"].value;
            //    entity.attributes["name"] = "Updated " + name;
            //    var updateResult = XrmServiceToolkit.Soap.Update(entity);

            //    ok(results.length > 0, "Total Records returned " + results.length.toString());
            //});

            //test("Test XrmServiceToolkit.Soap.QueryByAttribute() method to retrieve a CRM record (contact) using two criteria", function () {
            //    var queryOptions = {
            //        entityName: "contact",
            //        attributes: ["statecode"],
            //        values: ["aaajsjsjs"],
            //        columnSet: ["firstname", "lastname", "middlename", "familystatuscode", "ownerid", "creditlimit", "birthdate", "donotemail", "donotphone"],
            //        orderBy: ["firstname", "lastname"] // Order by firstname and then lastname even though we are only getting one record back
            //    };

            //    var fetchedContacts = XrmServiceToolkit.Soap.QueryByAttribute(queryOptions);

            //    ok(fetchedContacts.length >= 1, "at least there should be one matched contact record, which is what we just created");
            //});

            /*
            module("[Rest Functions]");

            jQuery.support.cors = true;

            test("Test XrmServiceToolkit.Rest.Create() method to create a new record", function () {

                var contact = {};
                contact.FirstName = "Diane";
                contact.LastName = "Morgan";
                contact.MiddleName = "<&>";
                contact.GenderCode = { Value: 2 };
                contact.CreditLimit = { Value: "2.00" };
                contact.BirthDate = birthDate;
                contact.DoNotEMail = true;
                contact.DoNotPhone = true;

                XrmServiceToolkit.Rest.Create(
                  contact,
                  "ContactSet",
                  function (result) {
                      contactId = result.ContactId;
                      ok(guidExpr.test(result.ContactId), "Creating a contact should returned the new record's ID in GUID format. ");
                  },
                  function (error) {
                      equal(true, false, error.message);
                  },
                  false
              );
            });

            test("Test XrmServiceToolkit.Rest.Create() method to create a new record", function () {

                var account = {};
                account.Name = "Test Account Name";
                account.Description = "This account was created by the XrmServiceToolkit.Rest.Create() sample.";
                if (contactId != null) {
                    //Set a lookup value
                    account.PrimaryContactId = { Id: contactId, LogicalName: "contact" };
                }
                //Set a picklist value
                account.PreferredContactMethodCode = { Value: 2 }; //E-mail

                //Set a money value
                account.Revenue = { Value: "2000000.00" }; //Set Annual Revenue

                //Set a Boolean value
                account.DoNotPhone = true; //Do Not Allow

                //Add Two Tasks
                var today = new Date();
                var startDate = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 3); //Set a date three days in the future.

                var LowPriTask = { Subject: "Low Priority Task", ScheduledStart: startDate, PriorityCode: { Value: 0 } }; //Low Priority Task
                var HighPriTask = { Subject: "High Priority Task", ScheduledStart: startDate, PriorityCode: { Value: 2 } }; //High Priority Task
                account.Account_Tasks = [LowPriTask, HighPriTask];
                XrmServiceToolkit.Rest.Create(
                  account,
                  "AccountSet",
                  function (result) {
                      accountId = result.AccountId;
                      ok(guidExpr.test(result.AccountId), "Creating a account should returned the new record's ID in GUID format. ");
                  },
                  function (error) {
                      equal(true, false, error.message);
                  },
                  false
              );
            });

            test("Test XrmServiceToolkit.Rest.Retrieve() method to retrieve a record", function () {

                XrmServiceToolkit.Rest.Retrieve(
                  accountId,
                  "AccountSet",
                  null, null,
                  function (result) {
                      var Id = result.AccountId;
                      equal(Id, accountId, "Retrieve() method should return the same account ID as Create() result. ");

                  },
                  function (error) {
                      equal(true, false, error.message);
                  },
                  false
              );
            });

            test("Test XrmServiceToolkit.Rest.Update() method to update a record", function () {

                var account = {};
                account.Name = "Updated Account Name";
                account.Address1_AddressTypeCode = { Value: 3 }; //Address 1: Address Type = Primary
                account.Address1_City = "Sammamish";
                account.Address1_Line1 = "123 Maple St.";
                account.Address1_PostalCode = "98074";
                account.Address1_StateOrProvince = "WA";
                account.EMailAddress1 = "someone@microsoft.com";

                XrmServiceToolkit.Rest.Update(
                  accountId,
                  account,
                  "AccountSet",
                  function () {
                      equal(true, true, "The record should have been updated.");
                  },
                  function (error) {
                      equal(true, false, error.message);
                  },
                  false
              );
            });

            test("Test XrmServiceToolkit.Rest.Associate() method to associate a record", function () {

                XrmServiceToolkit.Rest.Associate(
                  contactId,
                  "ContactSet",
                  accountId,
                  "AccountSet",
                  "account_primary_contact",
                  function () {
                      equal(true, true, "The record should have been associated.");
                  },
                  function (error) {
                      equal(true, false, error.message);
                  },
                  false
              );
            });

            test("Test XrmServiceToolkit.Rest.Disassociate() method to disassociate a record", function () {

                XrmServiceToolkit.Rest.Disassociate(
                      contactId,
                      "ContactSet",
                      accountId,
                      "account_primary_contact",
                      function () {
                          equal(true, true, "The record should have been disassociated.");
                      },
                      function (error) {
                          equal(true, false, error.message);
                      },
                      false
                  );
            });

            test("Test XrmServiceToolkit.Rest.Delete(account) method to delete a record", function () {

                XrmServiceToolkit.Rest.Delete(
                  accountId,
                  "AccountSet",
                  function () {
                      equal(true, true, "The record should have been deleted.");
                  },
                  function (error) {
                      equal(true, false, error.message);
                  },
                  false
              );
            });

            test("Test XrmServiceToolkit.Rest.Delete(contact) method to delete a record", function () {

                XrmServiceToolkit.Rest.Delete(
                  contactId,
                  "ContactSet",
                  function () {
                      equal(true, true, "The record should have been deleted.");
                  },
                  function (error) {
                      equal(true, false, error.message);
                  },
                  false
              );
            });

            test("Test XrmServiceToolkit.Rest.RetrieveMultiple(account) method to get the contacts", function () {

                var counter = 0;
                XrmServiceToolkit.Rest.RetrieveMultiple(
                  "AccountSet",
                  "$select=AccountId, Name",
                  function (results) {
                      //ok(results.length > 0, results.length.toString() + " records should have been retrieved.");   
                      counter += results.length;
                  },
                  function (error) {
                      equal(true, false, error.message);
                  },
                  function onComplete() {
                      ok(counter > 0, counter.toString() + " records should have been retrieved.");
                  },
                  false
              );
            });

            module("[Soap Functions]");

            test("Test XrmServiceToolkit.Soap.Execute() method using WhoAmIRequest message to get current user's ID", function () {

                var request = "<request i:type='b:WhoAmIRequest' xmlns:a='http://schemas.microsoft.com/xrm/2011/Contracts' xmlns:b='http://schemas.microsoft.com/crm/2011/Contracts'>" +
                              "<a:Parameters xmlns:c='http://schemas.datacontract.org/2004/07/System.Collections.Generic' />" +
                              "<a:RequestId i:nil='true' />" +
                              "<a:RequestName>WhoAmI</a:RequestName>" +
                            "</request>";
                var whoAmI = XrmServiceToolkit.Soap.Execute(request);
                if (jQuery(whoAmI).find("a\\:Results").length != 0) {
                    whoamiUserId = jQuery(whoAmI).find('a\\:Results').children().eq(0).children().eq(1).text();
                } else {
                    whoamiUserId = jQuery(whoAmI).find('Results').children().eq(0).children().eq(1).text(); //chrome
                }

                ok(guidExpr.test(whoamiUserId), "WhoAmI request should returned a valid GUID. ");

            });

            test("Test XrmServiceToolkit.Soap.GetCurrentUserId() method to get current user's ID", function () {

                currentUserId = XrmServiceToolkit.Soap.GetCurrentUserId();
                equal(currentUserId, whoamiUserId, "getCurrentUserId() method should return the same user ID as WhoAmI request. ");

            });

            test("Test XrmServiceToolkit.Soap.IsCurrentUserInRole() method to check if current user is a System Administrator.", function () {

                var isSystemAdministrator = XrmServiceToolkit.Soap.IsCurrentUserRole("System Administrator");
                ok(isSystemAdministrator, "You ought to be a System Administrator to run test for isCurrentUserInRole() method. ");

            });

            test("Test XrmServiceToolkit.Soap.GetCurrentUserRoles() method to get all the system roles that the current user has been assigned to.", function () {

                var roles = XrmServiceToolkit.Soap.GetCurrentUserRoles();
                ok(roles.constructor.toString().indexOf("Array") != -1, "getCurrentUserRoles() method should an array of user roles:  " + roles);

            });

            test("Test XrmServiceToolkit.Soap.Create() method to create a CRM record (account)", function () {

                var createAccount = new XrmServiceToolkit.Soap.BusinessEntity("account");
                createAccount.attributes["name"] = "Test Account Name";
                createAccount.attributes["description"] = "This account was created by the XrmServiceToolkit.Soap.Create() sample.";
                createAccount.attributes["preferredcontactmethodcode"] = { value: 2, type: "OptionSetValue" };
                createAccount.attributes["revenue"] = { value: 2000.00, type: "Money" };
                createAccount.attributes["donotphone"] = false;

                accountId = XrmServiceToolkit.Soap.Create(createAccount);

                ok(guidExpr.test(accountId), "Creating a account should returned the new record's ID in GUID format. ");

            });

            test("Test XrmServiceToolkit.Soap.Create() method to create a CRM record (contact)", function () {

                var createContact = new XrmServiceToolkit.Soap.BusinessEntity("contact");
                createContact.attributes["firstname"] = "Diane";
                createContact.attributes["lastname"] = "Morgan";
                createContact.attributes["middlename"] = "<&>";   // Deliberate special characters to ensure that the toolkit can handle special characters correctly.
                createContact.attributes["gendercode"] = { value: 2, type: "OptionSetValue" };
                createContact.attributes["familystatuscode"] = { value: 1, type: "OptionSetValue" }; // Picklist : Single - 1
                createContact.attributes["creditlimit"] = { value: 2, type: "Money" };
                createContact.attributes["birthdate"] = birthDate;
                createContact.attributes["donotemail"] = true;
                createContact.attributes["donotphone"] = false;
                createContact.attributes["parentcustomerid"] = { id: accountId, logicalName: "account", type: "EntityReference" };

                contactId = XrmServiceToolkit.Soap.Create(createContact);

                ok(guidExpr.test(contactId), "Creating a contact should returned the new record's ID in GUID format. ");

            });

            test("Test XrmServiceToolkit.Soap.Update() method to update a CRM record (contact)", function () {

                equal(contactId, contactId, "ContactID");
                var updateContact = new XrmServiceToolkit.Soap.BusinessEntity("contact", contactId);
                updateContact.attributes["firstname"] = "Diane";
                updateContact.attributes["lastname"] = "Lopez";
                updateContact.attributes["donotpostalmail"] = null;
                updateContact.attributes["familystatuscode"] = { value: 2, type: "OptionSetValue" }; // Married

                var updateResponse = XrmServiceToolkit.Soap.Update(updateContact);

                ok(updateResponse === "", "The contact should be able to be updated.");
            });

            test("Test XrmServiceToolkit.Soap.Retrieve() method to retrieve a CRM record (contact)", function () {

                var cols = ["firstname", "lastname", "middlename", "familystatuscode", "ownerid", "creditlimit", "birthdate", "donotemail", "donotphone"];
                var retrievedContact = XrmServiceToolkit.Soap.Retrieve("contact", contactId, cols);

                equal(retrievedContact.attributes['lastname'].value, "Lopez", "A retrieve of just updated contact has proved that its last name has actually been updated. ");
                equal(retrievedContact.attributes['firstname'].value, "Diane", "firstname matches");
                equal(retrievedContact.attributes['middlename'].value, "<&>", "middlename matches");
                equal(retrievedContact.attributes['familystatuscode'].value, 2, "familystatuscode matches");
                equal(retrievedContact.attributes['familystatuscode'].type, "OptionSetValue", "CRM picklist's JavaScript type should be OptionSetValue");
                ok(CompareGuid(retrievedContact.attributes['ownerid'].id, currentUserId), "ownerid matches");
                equal(retrievedContact.attributes['creditlimit'].value, 2, "creditlimit matches");
                equal(retrievedContact.attributes['creditlimit'].type, "Money", "CRM number's JavaScript type should be Money");
                equal(retrievedContact.attributes['birthdate'].value.getTime(), birthDate.getTime(), "birthdate matches");
                equal(retrievedContact.attributes['donotemail'].value, true, "donotemail matches");
                equal(retrievedContact.attributes['donotemail'].type, "boolean", "CRM bit field's value type should be boolean (donotemail)");
                equal(retrievedContact.attributes['donotphone'].value, false, "donotphone matches");
                equal(retrievedContact.attributes['donotphone'].type, "boolean", "CRM bit's JavaScript type should be boolean (donotphone");
                deepEqual(typeof retrievedContact.attributes['donotpostalmail'], "undefined", "donotpostalmail matches");
            });

            test("Test XrmServiceToolkit.Soap.RetrieveMultiple() method to retrieve a CRM record (contact)", function () {

                var query =
                       "<a:ColumnSet>" +
                        "<a:AllColumns>false</a:AllColumns>" +
                        "<a:Columns xmlns:c='http://schemas.microsoft.com/2003/10/Serialization/Arrays'>" +
                          "<c:string>firstname</c:string>" +
                          "<c:string>lastname</c:string>" +
                          "<c:string>middlename</c:string>" +
                          "<c:string>familystatuscode</c:string>" +
                          "<c:string>ownerid</c:string>" +
                          "<c:string>creditlimit</c:string>" +
                          "<c:string>birthdate</c:string>" +
                          "<c:string>donotemail</c:string>" +
                          "<c:string>donotphone</c:string>" +
                        "</a:Columns>" +
                      "</a:ColumnSet>" +
                      "<a:Criteria>" +
                        "<a:Conditions />" +
                        "<a:FilterOperator>And</a:FilterOperator>" +
                        "<a:Filters>" +
                          "<a:FilterExpression>" +
                            "<a:Conditions>" +
                              "<a:ConditionExpression>" +
                                "<a:AttributeName>contactid</a:AttributeName>" +
                                "<a:Operator>Equal</a:Operator>" +
                                "<a:Values xmlns:b='http://schemas.microsoft.com/2003/10/Serialization/Arrays'>" +
                                  "<b:anyType i:type='c:string' xmlns:c='http://www.w3.org/2001/XMLSchema'>" + contactId + "</b:anyType>" +
                                "</a:Values>" +
                              "</a:ConditionExpression>" +
                            "</a:Conditions>" +
                            "<a:FilterOperator>And</a:FilterOperator>" +
                            "<a:Filters />" +
                          "</a:FilterExpression>" +
                        "</a:Filters>" +
                      "</a:Criteria>" +
                      "<a:Distinct>false</a:Distinct>" +
                      "<a:EntityName>contact</a:EntityName>" +
                      "<a:LinkEntities />" +
                      "<a:Orders />" +
                      "<a:PageInfo>" +
                        "<a:Count>0</a:Count>" +
                        "<a:PageNumber>0</a:PageNumber>" +
                        "<a:PagingCookie i:nil='true' />" +
                        "<a:ReturnTotalRecordCount>false</a:ReturnTotalRecordCount>" +
                      "</a:PageInfo>" +
                      "<a:NoLock>false</a:NoLock>";

                var retrievedContacts = XrmServiceToolkit.Soap.RetrieveMultiple(query);

                equal(retrievedContacts.length, 1, "only last created contact should be found");
                equal(retrievedContacts[0].attributes['lastname'].value, "Lopez", "A retrieve of just updated contact has proved that its last name has actually been updated. ");
                equal(retrievedContacts[0].attributes['firstname'].value, "Diane", "firstname matches");
                equal(retrievedContacts[0].attributes['middlename'].value, "<&>", "middlename matches");
                equal(retrievedContacts[0].attributes['familystatuscode'].value, 2, "familystatuscode matches");
                equal(retrievedContacts[0].attributes['familystatuscode'].type, "OptionSetValue", "CRM picklist's JavaScript type should be OptionSetValue");
                ok(CompareGuid(retrievedContacts[0].attributes['ownerid'].id, currentUserId), "ownerid matches");
                equal(retrievedContacts[0].attributes['creditlimit'].value, 2, "creditlimit matches");
                equal(retrievedContacts[0].attributes['creditlimit'].type, "Money", "CRM number's JavaScript type should be Money");
                equal(retrievedContacts[0].attributes['birthdate'].value.getTime(), birthDate.getTime(), "birthdate matches");
                equal(retrievedContacts[0].attributes['donotemail'].value, true, "donotemail matches");
                equal(retrievedContacts[0].attributes['donotemail'].type, "boolean", "CRM bit field's value type should be boolean (donotemail)");
                equal(retrievedContacts[0].attributes['donotphone'].value, false, "donotphone matches");
                equal(retrievedContacts[0].attributes['donotphone'].type, "boolean", "CRM bit's JavaScript type should be boolean (donotphone");
                deepEqual(typeof retrievedContacts[0].attributes['donotpostalmail'], "undefined", "donotpostalmail matches");

            });

            test("Test XrmServiceToolkit.Soap.Fetch() method to retrieve a CRM record (contact)", function () {

                var fetchXml =
                      "<fetch mapping='logical'>" +
                         "<entity name='contact'>" +
                            "<attribute name='contactid' />" +
                            "<attribute name='firstname' />" +
                            "<attribute name='lastname' />" +
                            "<attribute name='middlename' />" +
                            "<attribute name='familystatuscode' />" +
                            "<attribute name='ownerid' />" +
                            "<attribute name='creditlimit' />" +
                            "<attribute name='birthdate' />" +
                            "<attribute name='accountrolecode' />" +
                            "<attribute name='donotemail' />" +
                            "<attribute name='donotphone' />" +
                            "<filter>" +
                               "<condition attribute='contactid' operator='eq' value='" + contactId + "' />" +
                            "</filter>" +
                         "</entity>" +
                      "</fetch>";

                var retrievedContacts = XrmServiceToolkit.Soap.Fetch(fetchXml, false);

                equal(retrievedContacts.length, 1, "only last created contact should be found");
                equal(retrievedContacts[0].attributes['lastname'].value, "Lopez", "A retrieve of just updated contact has proved that its last name has actually been updated. ");
                equal(retrievedContacts[0].attributes['firstname'].value, "Diane", "firstname matches");
                equal(retrievedContacts[0].attributes['middlename'].value, "<&>", "middlename matches");
                equal(retrievedContacts[0].attributes['familystatuscode'].value, 2, "familystatuscode matches");
                equal(retrievedContacts[0].attributes['familystatuscode'].type, "OptionSetValue", "CRM picklist's JavaScript type should be OptionSetValue");
                ok(CompareGuid(retrievedContacts[0].attributes['ownerid'].id, currentUserId), "ownerid matches");
                equal(retrievedContacts[0].attributes['creditlimit'].value, 2, "creditlimit matches");
                equal(retrievedContacts[0].attributes['creditlimit'].type, "Money", "CRM number's JavaScript type should be Money");
                equal(retrievedContacts[0].attributes['birthdate'].value.getTime(), birthDate.getTime(), "birthdate matches");
                equal(retrievedContacts[0].attributes['donotemail'].value, true, "donotemail matches");
                equal(retrievedContacts[0].attributes['donotemail'].type, "boolean", "CRM bit field's value type should be boolean (donotemail)");
                equal(retrievedContacts[0].attributes['donotphone'].value, false, "donotphone matches");
                equal(retrievedContacts[0].attributes['donotphone'].type, "boolean", "CRM bit's JavaScript type should be boolean (donotphone");
                deepEqual(typeof retrievedContacts[0].attributes['donotpostalmail'], "undefined", "donotpostalmail matches");

            });

            test("Test XrmServiceToolkit.Soap.Fetch() method to do an aggregation query", function () {

                var fetchXml =
                  "<fetch mapping='logical' aggregate='true'>" +
                     "<entity name='contact'>" +
                        "<attribute name='contactid' aggregate='count' alias='count' />" +
                        "<filter>" +
                           "<condition attribute='contactid' operator='eq' value='" + contactId + "' />" +
                        "</filter>" +
                     "</entity>" +
                  "</fetch>";

                var fetchedContacts = XrmServiceToolkit.Soap.Fetch(fetchXml, false);

                equal(fetchedContacts.length, 1, "only one record should be returned when doing aggregation.");
                equal(fetchedContacts[0].attributes['count'].formattedValue, "1", "only one contact record would match the id.");
            });

            test("Test XrmServiceToolkit.Soap.Fetch() method to retrieve a CRM record (account)", function () {

                var fetchXml =
                      "<fetch mapping='logical'>" +
                         "<entity name='account'>" +
                            "<attribute name='accountid' />" +
                            "<attribute name='name' />" +
                         "</entity>" +
                      "</fetch>";

                var results = XrmServiceToolkit.Soap.Fetch(fetchXml, true);

                ok(results.length > 0, "Total Records returned " + results.length.toString());
            });

            test("Test XrmServiceToolkit.Soap.Fetch() method to do a query with limited return", function () {

                var fetchXml =
                  "<fetch mapping='logical' page='1' count='7'>" +
                     "<entity name='account'>" +
                        "<attribute name='accountid' />" +
                     "</entity>" +
                  "</fetch>";

                var fetchedContacts = XrmServiceToolkit.Soap.Fetch(fetchXml, false);

                equal(fetchedContacts.length, 7, "only 7 records should be returned when doing limited fetch.");
            });

            test("Test XrmServiceToolkit.Soap.QueryByAttribute() method to retrieve a CRM record (contact) using one criterion", function () {
                var queryOptions = {
                    entityName: "contact",
                    attributes: "contactid",
                    values: contactId
                };
                var fetchedContacts = XrmServiceToolkit.Soap.QueryByAttribute(queryOptions); // Retrieve all fields (BAD Practice) with no sorting

                equal(fetchedContacts.length, 1, "only last created contact should be found");
            });

            test("Test XrmServiceToolkit.Soap.QueryByAttribute() method to retrieve a CRM record (contact) using two criteria", function () {
                var queryOptions = {
                    entityName: "contact",
                    attributes: ["firstname", "middlename", "lastname"],
                    values: ["Diane", "<&>", "Lopez"],
                    columnSet: ["firstname", "lastname", "middlename", "familystatuscode", "ownerid", "creditlimit", "birthdate", "donotemail", "donotphone"],
                    orderBy: ["firstname", "lastname"] // Order by firstname and then lastname even though we are only getting one record back
                };

                var fetchedContacts = XrmServiceToolkit.Soap.QueryByAttribute(queryOptions);

                ok(fetchedContacts.length >= 1, "at least there should be one matched contact record, which is what we just created");
            });

            test("Test XrmServiceToolkit.Soap.QueryAll() method to retrieve all CRM records (account) using one criterion", function () {
                var queryOptions = {
                    entityName: "account",
                    attributes: "statuscode",
                    values: 1,
                    columnSet: ["accountid"]
                };
                var fetchedAccounts = XrmServiceToolkit.Soap.QueryAll(queryOptions); // Retrieve all fields (BAD Practice) with no sorting

                equal(true, true, fetchedAccounts.length.toString() + " records (account) have been returned");
            });


            test("Test XrmServiceToolkit.Soap.SetState() method to set a CRM record's status", function () {

                var response = XrmServiceToolkit.Soap.SetState("contact", contactId, 1, 2);
                ok(response == "SetState", "The contact can be deactivated. ");

            });

            test("Test XrmServiceToolkit.Soap.Associate() method to associate records through an 1:N relationship", function () {

                var account = new XrmServiceToolkit.Soap.BusinessEntity("account", accountId);
                var relatedAccounts = new Array();
                relatedAccounts[0] = account;
                var response = XrmServiceToolkit.Soap.Associate("account_primary_contact", "contact", contactId, "account", relatedAccounts);
                ok(response == "Associate", "The contact can be associated with account. ");

            });

            test("Test XrmServiceToolkit.Soap.Disassociate() method to disassociate records of an 1:N relationship", function () {

                var account = new XrmServiceToolkit.Soap.BusinessEntity("account", accountId);
                var relatedAccounts = new Array();
                relatedAccounts[0] = account;
                var response = XrmServiceToolkit.Soap.Disassociate("account_primary_contact", "contact", contactId, "account", relatedAccounts);
                ok(response == "Disassociate", "The contact can be disassociate with account. ");

            });

            test("Test XrmServiceToolkit.Soap.Assign() method to assign a CRM record (contact) to a user", function () {

                var assignResponse = XrmServiceToolkit.Soap.Assign("contact", contactId, "systemuser", currentUserId);
                ok(assignResponse == "Assign", "The contact can be assigned to the current user. ");

            });

            test("Test XrmServiceToolkit.Soap.RetrievePrincipalAccess() method to retrieve a user access to a CRM record (contact)", function () {

                var accessOptions = {
                    targetEntityName: "contact",
                    targetEntityId: contactId,
                    principalEntityName: "systemuser",
                    principalEntityId: currentUserId
                };

                var retrieveAccessResponse = XrmServiceToolkit.Soap.RetrievePrincipalAccess(accessOptions);
                ok(retrieveAccessResponse != "", "The current user should have the access " + retrieveAccessResponse);

            });

            test("Test XrmServiceToolkit.Soap.GrantAccess() method to grant a user access to a CRM record (contact)", function () {

                var accessOptions = {
                    targetEntityName: "contact",
                    targetEntityId: contactId,
                    principalEntityName: "systemuser",
                    principalEntityId: currentUserId,
                    accessRights: ["ReadAccess", "WriteAccess"]
                };

                var grantAccessResponse = XrmServiceToolkit.Soap.GrantAccess(accessOptions);
                ok(grantAccessResponse == "GrantAccess", "The current user should have the listed access to the contact");

            });

            test("Test XrmServiceToolkit.Soap.ModifyAccess() method to modify a user access to a CRM record (contact)", function () {

                var accessOptions = {
                    targetEntityName: "contact",
                    targetEntityId: contactId,
                    principalEntityName: "systemuser",
                    principalEntityId: currentUserId,
                    accessRights: ["ReadAccess", "WriteAccess"]
                };

                var modifyAccessResponse = XrmServiceToolkit.Soap.ModifyAccess(accessOptions);
                ok(modifyAccessResponse == "ModifyAccess", "The current user should have the listed modified access to the contact");

            });

            test("Test XrmServiceToolkit.Soap.RevokeAccess() method to revoke a user access to a CRM record (contact)", function () {

                var accessOptions = {
                    targetEntityName: "contact",
                    targetEntityId: contactId,
                    revokeeEntityName: "systemuser",
                    revokeeEntityId: currentUserId
                };

                var revokeAccessResponse = XrmServiceToolkit.Soap.RevokeAccess(accessOptions);
                ok(revokeAccessResponse == "RevokeAccess", "The current user should have the access to the contact revoked");

            });

            test("Test XrmServiceToolkit.Soap.Create() method to create a email activity (email)", function () {

                var today = new Date();
                var createEmail = new XrmServiceToolkit.Soap.BusinessEntity("email");
                createEmail.attributes["subject"] = "Test Email subject " + today.toString();
                createEmail.attributes["description"] = "This email was created by the XrmServiceToolkit.Soap.Create() sample.";

                var from = [
                  { id: whoamiUserId, logicalName: "systemuser", type: "EntityReference" }
                ];

                createEmail.attributes["from"] = { value: from, type: "EntityCollection" };

                var to = [
                  { id: accountId, logicalName: "account", type: "EntityReference" },
                  { id: contactId, logicalName: "contact", type: "EntityReference" }
                ];

                createEmail.attributes["to"] = { value: to, type: "EntityCollection" };

                var cc = [
                  { id: accountId, logicalName: "account", type: "EntityReference" },
                  { id: contactId, logicalName: "contact", type: "EntityReference" }
                ];

                createEmail.attributes["cc"] = { value: cc, type: "EntityCollection" };

                var bcc = [
                  { id: accountId, logicalName: "account", type: "EntityReference" },
                  { id: contactId, logicalName: "contact", type: "EntityReference" }
                ];

                createEmail.attributes["bcc"] = { value: bcc, type: "EntityCollection" };

                createEmail.attributes["directioncode"] = true;

                createEmail.attributes["regardingobjectid"] = { id: accountId, logicalName: "account", type: "EntityReference" };

                emailId = XrmServiceToolkit.Soap.Create(createEmail);

                ok(guidExpr.test(emailId), "Creating an email should returned the new record's ID in GUID format. " + emailId);
            });

            test("Test XrmServiceToolkit.Soap.Retrieve() method to retrieve a CRM record (email)", function () {

                var cols = ["subject", "description", "from", "to", "cc", "bcc", "directioncode", "regardingobjectid"];
                var retrievedEmail = XrmServiceToolkit.Soap.Retrieve("email", emailId, cols);

                equal(retrievedEmail.attributes['subject'].type, "string", "Subject matches");
                equal(retrievedEmail.attributes['description'].value, "This email was created by the XrmServiceToolkit.Soap.Create() sample.", "Description Matches");
                equal(retrievedEmail.attributes['from'].type, "EntityCollection", "CRM partylist type should be EntityCollection");
                equal(retrievedEmail.attributes['from'].value.length, 1, "CRM should return 1 values for email from attribute");
                equal(retrievedEmail.attributes['to'].type, "EntityCollection", "CRM partylist type should be EntityCollection");
                equal(retrievedEmail.attributes['to'].value.length, 2, "CRM should return 2 values for email to attribute");
                equal(retrievedEmail.attributes['cc'].type, "EntityCollection", "CRM partylist type should be EntityCollection");
                equal(retrievedEmail.attributes['bcc'].type, "EntityCollection", "CRM partylist type should be EntityCollection");
                equal(retrievedEmail.attributes['directioncode'].type, "boolean", "CRM boolean type should be boolean");
            });

            test("Test XrmServiceToolkit.Soap.Delete() method to delete a CRM record (contact)", function () {

                var deleteResponse = XrmServiceToolkit.Soap.Delete("contact", contactId);
                ok(deleteResponse == "", "The contact can be deleted. ");

            });

            test("Test XrmServiceToolkit.Soap.Delete() method to delete a CRM record (account)", function () {

                var deleteResponse = XrmServiceToolkit.Soap.Delete("account", accountId);
                ok(deleteResponse == "", "The account can be deleted. ");

            });

            test("Test XrmServiceToolkit.Soap.RetrieveAllEntitiesMetadata() method to return CRM Metadata for all entities", function () {

                var allEntitiesMetadata = XrmServiceToolkit.Soap.RetrieveAllEntitiesMetadata(["Entity"], true);
                ok(allEntitiesMetadata.length > 0, "The Metadata has been returned for all entities ");

            });

            test("Test XrmServiceToolkit.Soap.RetrieveEntityMetadata() method to return CRM Metadata for a certain entity", function () {

                var entityMetadata = XrmServiceToolkit.Soap.RetrieveEntityMetadata(["Entity"], "account", true);
                ok(entityMetadata.length == 1, "The Metadata has been returned for the account entity");

            });

            test("Test XrmServiceToolkit.Soap.RetrieveAttributeMetadata() method to return CRM Metadata for a certain attribute", function () {

                var attributeMetadata = XrmServiceToolkit.Soap.RetrieveAttributeMetadata("account", "name", true);
                ok(attributeMetadata.length == 1, "The Metadata has been returned for the name attribute of the account entity");

            });

            // Utility method to compare two GUID strings, return true if the GUID's are actually equal.
            var CompareGuid = function (guid1, guid2) {
                if (guid1 === null && guid2 === null)
                    return true;

                if (guid1 === null || guid2 === null)
                    return false;

                guid1 = guid1.toLowerCase(guid1);
                guid2 = guid2.toLowerCase(guid2);

                if (!guidExpr.test(guid1) || !guidExpr.test(guid2))
                    return false;

                guid1 = guid1.replace(guidExpr, "$2");
                guid2 = guid2.replace(guidExpr, "$2");

                if (guid1 === guid2)
                    return true;

                return false;
            };

            */
        }
        catch (error) {
            alert(error.message);
        }

    </script>

</head>
<body>
    <h1 id="qunit-header">Xrm Service Toolkit Test - Functions</h1>
    <h2 id="qunit-banner"></h2>
    <div id="qunit-testrunner-toolbar"></div>
    <h2 id="qunit-userAgent"></h2>
    <ol id="qunit-tests"></ol>
</body>
</html>
