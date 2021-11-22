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
    TypeText      Business Tax ID            111222123
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
    TypeText      Social Security            111748285
    TypeText      Street Address             PO BOX 450763       anchor=DOB   css=off  
    TypeText      City                       ATLANTA             anchor=DOB     
    TypeText      State                      GA                  anchor=DOB
    TypeText      Zip                        31145               anchor=DOB
    TypeText      Country                    United States       anchor=DOB
    ClickText     Create Application 
    UseTable      Application ID
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

    
    OpenWindow    
    Gmail login
    ClickText                Set.pdf
    ClickText                Download        visibility=false
    ClickText                 Bank Statements TC1
    ClickText                 Download all attachments           css=off
    #ClickText                 //[@class=\["aZh T-I-J3 J-J5-Ji"]
    ClickText     set.pdf                    


Upload PDF Bank Statements    
    [tags]        Partner Portal
    SwitchWindow  1
    ClickText     Next
    VerifyText    Documents for Applications and Fundings can be uploaded here
    ClickText     Bank Statements   anchor=3
    ClickText     cloud_upload      css=off
    ClickText     Downloads         DoubleClick=true
    ClickText     tests
    ClickText     suite
    ClickText     files
    ClickText     
    

    #execution path different in live editor 
    #Unable to automate steps when accessing Linux directory in container

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
    Sleep         30
    # ^what's best pratice to wait extended periods and verify expected result once event has occurred
    ClickUntil    Overall Status: SCORING         Refresh        interval=2
    ClickText     Refresh
    VerifyText    Overall Status: SCORING 
    ClickText     Credit Scoring Details   
    #VerifyTableCell   No Credit Report Details to Display   (in 3 tables under each section)
    #is above step necessary? 

Verify Credit Reports Generated in Salesforce
    [tags]        Salesforce  
    Sleep         30
    ClickText     Refresh
    VerifyText    Status: BANK STATEMENT PROCESSING
    VerifyText    VERIFYING
    #UseTable      Ocrolus Report
    #VerifyTableCell      r1c2 VERIFYING (in Ocrolus Report table under Overall Document Status)
      







