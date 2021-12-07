*** Settings ***
Library                   QForce
Library                   QWeb
Library                   QVision
Library                   String


*** Variables ***
${BROWSER}               chrome
${partner_username}      wriker@canclsuat.testinator.com
${salesforce_username}   automationlab3@canclsuat.testinator.com
${partner_url}           https://uat-cancapital.cs43.force.com/partnerportal            
${salesforce_url}        https://test.salesforce.com/                            # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}              ${login_url}/lightning/page/home
${gmail_pass}            Copado2021


*** Keywords ***
Setup Browser
    Set Library Search Order    QWeb
    Open Browser          about:blank                 ${BROWSER}
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              20s                    #sometimes salesforce is slow


End suite
    Close All Browsers

Home
    [Documentation]      Navigate to homepage, login if needed
    GoTo                 ${home_url}
    ${login_status} =    IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If       ${login_status}             Login
    VerifyText           Home


#Below two custom keywords were created for Can Capital workshop

Partner Login
    [Documentation]      Login to Salesforce instance
    GoTo                 ${partner_url}
    TypeText             Username                    ${partner_username}
    TypeText             Password                    ${partner_password}
    ClickText            Log In

Salesforce Login
    [Documentation]      Login to Salesforce instance
    GoTo                 ${salesforce_url}
    TypeText             Username                    ${salesforce_username}
    TypeText             Password                    ${salesforce_password}
    ClickText            Log In








                            


