*** Settings ***
Library    AppiumLibrary 
Library    String

*** Keywords ***
Open App
    Open Application     http://127.0.0.1:4723    platformName=Android    deviceName=emulator-5554    appPackage=com.avjindersinghsekhon.minimaltodo    appActivity=com.example.avjindersinghsekhon.toodle.MainActivity    automationName=UiAutomator2

Add new todo item
    [Arguments]    ${name}=${EMPTY}    ${date}=${EMPTY}    ${time}=${EMPTY}    ${negative}=false
    Wait Until Page Contains Element    id=addToDoItemFAB
    Click Element    id=addToDoItemFAB
    Wait Until Page Contains Element    id=userToDoRemindMeTextView
    Input Text    id=userToDoEditText    ${name}
    IF    '${date}' != '${EMPTY}'    #  Current month only
        select_date    ${date}
        IF    '${time}' != '${EMPTY}'    # Can't use
            select_time    ${time}
        END
    END
    IF  '${negative}' == 'false'
        Submit data    ${name}    ${date}    ${time}
    END

Edit todo item
    [Arguments]    ${name}=${EMPTY}    ${date}=${EMPTY}    ${time}=${EMPTY}    ${negative}=false
    Wait Until Page Contains Element    id=addToDoItemFAB
    Click Element    id=addToDoItemFAB
    Wait Until Page Contains Element    id=userToDoRemindMeTextView
    Input Text    id=userToDoEditText    ${name}
    IF    '${date}' != '${EMPTY}'    #  Current month only
        select_date    ${date}
        IF    '${time}' != '${EMPTY}'    # Can't use
            select_time    ${time}
        END
    END
    IF  '${negative}' == 'false'
        Submit data    ${name}    ${date}    ${time}
    END

select_date
    [Arguments]    ${date}=${EMPTY}
    Click Element    id=toDoHasDateSwitchCompat
    Click Element    id=newTodoDateEditText
    Scroll Down    xpath=//android.view.View[@content-desc="${date}"]
    Click Element    xpath=//android.view.View[@content-desc="${date}"]
    Click Element    id=ok

select_time
    [Arguments]    ${time}=${EMPTY}
    ${timeSplit}=    split time    ${time}
    Click Element    id=newTodoTimeEditText
    Click Element    id=hours
    Click Element    xpath=//android.widget.FrameLayout[@content-desc="Hours circular slider: ${timeSplit[0]}"]
    Click Element    id=minutes
    Click Element    xpath=//android.widget.FrameLayout[@content-desc="Minutes circular slider: ${timeSplit[1]}"]/android.view.View[4]
    Click Element    id=ok

Submit data
    [Arguments]    ${name}=${EMPTY}    ${date}=${EMPTY}    ${time}=${EMPTY}
    Click Element    id=makeToDoFloatingActionButton
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text,"${name}"]
    IF    '${date}' != '${EMPTY}'
        ${actualDateTime}=    Get Text    id=todoListItemTimeTextView
        Should Contain    ${actualDateTime}    ${date}
        IF    '${time}' != '${EMPTY}'
            Should Contain    ${actualDateTime}    ${time}
        END
    END

split time
    [Arguments]    ${time}
    ${timeSplit}=    Split String    ${time}    :
    log    ${timeSplit}
    RETURN    ${timeSplit}

*** Test Cases ***
Can Open Application should display main page correctly
    Open App

Can add new todo item should display item data correctly
    Open App
    Add new todo item    test1234    

Can add new todo item and open remind should display item data correctly
    Open App
    Add new todo item    test1234    31 May 2024    11:12  

Can edit name exist item
    Open App
    Add new todo item    test1234
    Edit todo item    newName

Can edit remind exist item
    Open App
    Add new todo item    test1234    31 May 2024    11:12
    Edit todo item    test1234    25 May 2025    6:30

Can't add new todo when entering a date less than the current date should display error message
    Open App
    Add new todo item    test1234    1 May 2024
    Wait Until Page Contains Element    xpath=//*[@text,"My time-machine is a bit rusty" ]

Can't add new todo when entering a time less than the current time should display error message
    Open App
    Add new todo item    test1234    16 May 2024    00:00
    Wait Until Page Contains Element    xpath=//*[@text,"The date you entered is in the past" ]