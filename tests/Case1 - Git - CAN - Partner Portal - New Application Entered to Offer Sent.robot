*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Fill Out Partner Application
    [tags]        Partner Portal
    Appstate      Partner Login
    VerifyText    Dashboard    timeout=30    
    
    ClickText     Create New
    ClickUntil    Expansion         Select Use of Funds
    ClickText     Expansion
    TypeText      Amount Requested        150000
    ClickText     Continue
    VerifyText    Does the customer have an existing account
    ClickItem     No
    VerifyText    Tell us about your Client                     

    TypeText      Business Legal Name        BURKE FUEL & HEATING CO, INC
    TypeText      Business Tax ID            111222333
    ClickUntil    Health Services            Select Industry
    ClickText     Health Services
    TypeText      Doing Business As Name     BURKE FUEL & HEATING CO, INC
    ClickText     Select Business Structure    
    ClickText     Corporation
    ClickText     State of Formation     
    ClickText     NY
    TypeText      Business Start Date        01012000
    TypeText      Business Phone             4732212460
    TypeText      Business Street Address    375 N BROADWAY
    TypeText      Billing City               JERICHO
    TypeText      Billing State              NY
    TypeText      Billing Zip                11753
    TypeText      Country                    United States

    ClickText     Select Title
    ClickText     Owner
    TypeText      First Name                 MELONYE
    TypeText      Last Name                  FUGATE
    TypeText      Email                      MELONYE@canclsuat.testinator.com
    TypeText      Mobile Phone               5732212172
    TypeText      DOB                        11011969
    TypeText      Social Security            111748555
    TypeText      Street Address             PO BOX 450763       anchor=DOB   css=off  
    TypeText      City                       ATLANTA             anchor=DOB     
    TypeText      State                      GA                  anchor=DOB
    TypeText      Zip                        31145               anchor=DOB
    TypeText      Country                    United States       anchor=DOB
    ClickText     Create Application 
    ${applicationID}    GetText     APP-
    VerifyText          ${applicationId}

Verify Application Entered in Salesforce
    [tags]        Salesforce
    OpenWindow
    Salesforce Login
    VerifyText    Home  
    ClickText     Applications
    ClickText     Select List View
    ClickText     All         
    ClickText     ${applicationId}
    VerifyText    Status: NEW ENTERED        anchor=2
              

Upload PDF Bank Statements    
    [tags]        Partner Portal
    SwitchWindow  1
    ClickText     Next
    VerifyText    Documents for Applications and Fundings can be uploaded here
    ClickText     Bank Statements   anchor=Stipulations
    ClickText     cloud_upload      css=off         DoubleClick=true
    QVision.ClickText               tests 
    QVision.ClickText               suite
    QVision.ClickUntil              pdf               files 
    QVision.ClickText               Feb-Aug.pdf         
    QVision.ClickText               Open              anchor=Cancel
    VerifyText    Feb-Aug.pdf
    VerifyText    Set.pdf
    ClickText     Next        
    ClickText     I have read and agree to the above disclosure    css=off
    ClickText     Submit
    Sleep         30
    VerifyText    Your application has been successfully submitted for review

Verify Application Status updated after PDF Upload                 
    [tags]        Salesforce        
    SwitchWindow  2
    ClickUntil    Overall Status: SCORING         Refresh        interval=2
    VerifyText    Overall Status: SCORING 

Verify Credit Reports Generated in Salesforce
    [tags]        Salesforce  
    Sleep         30
    ClickUntil    Status: BANK STATEMENT PROCESSING     Refresh
    VerifyText    Status: BANK STATEMENT PROCESSING
    VerifyText    VERIFYING          #(in Ocrolus Report table under Overall Document Status)
      







