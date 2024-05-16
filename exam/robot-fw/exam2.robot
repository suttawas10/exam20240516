*** Settings ***
Library    Selenium2Library
Test Teardown    Close All Browsers

*** Variables ***
${BROWSER}    chrome
${URL}    http://the-internet.herokuapp.com/login

*** Keywords ***
Open web and login
    [Arguments]    ${username}    ${password}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    id=username
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Click Element    xpath=//*[@id="login"]/button
    Wait Until Page Contains Element    xpath=//i[contains(text(),' Logout')]

Logout
    ${login_text}=    Get Text    id=flash
    Should Contain   ${login_text}    You logged into a secure area!   
    Click Element    xpath=//i[contains(text(),' Logout')]
    Wait Until Page Contains Element    xpath=//*[@id="login"]/button
    ${logout_text}=    Get Text    id=flash
    Should Contain    ${logout_text}    You logged out of the secure area!  

Open web and login Negative
    [Arguments]    ${username}    ${password}    ${err_msg}
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Page Contains Element    id=username
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Click Element    xpath=//*[@id="login"]/button
    Wait Until Page Contains Element    xpath=//div[contains(text(),'${err_msg}')]

*** Test Cases ***
Login success
    Open web and login    tomsmith    SuperSecretPassword!
    Logout

Login failed - Password incorrect
    Open web and login Negative    tomsmith    Password!    Your password is invalid!

Login failed - Username not found
    Open web and login Negative    tomholland    Password!    Your username is invalid!