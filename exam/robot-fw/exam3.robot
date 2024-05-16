*** Settings ***
Library    RequestsLibrary

*** Variables ***
${URL}    https://reqres.in/api/users/12

*** Keywords ***
Request Get user profile
    ${response}=    GET    ${URL}    expected_status=200
    Should Be Equal As Numbers    ${response.json()}[data][id]    12
    Should Be Equal As Strings    ${response.json()}[data][email]    rachel.howell@reqres.in
    Should Be Equal As Strings    ${response.json()}[data][first_name]    Rachel
    Should Be Equal As Strings    ${response.json()}[data][last_name]    Howell
    Should Be Equal As Strings    ${response.json()}[data][avatar]    https://reqres.in/img/faces/12-image.jpg

Request Get user profile Negative
    ${response}=    GET    https://reqres.in/api/users/1234    expected_status=404
    Should Be Equal As Strings   ${response.json()}    {}

*** Test Cases ***
Get user profile success
    Request Get user profile

Get user profile but user not found
    Request Get user profile Negative


