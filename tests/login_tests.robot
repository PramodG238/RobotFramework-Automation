*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser To Login Page
Suite Teardown    Close All Browsers
Documentation    Login functionality test suite

*** Variables ***
${URL}           https://www.saucedemo.com
${VALID_USER}    standard_user
${VALID_PASS}    secret_sauce
${WRONG_PASS}    wrong_password

*** Keywords ***
Open Browser To Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --headless=new
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu

    Open Browser    ${URL}    chrome    options=${options}
    Maximize Browser Window
    Wait Until Element Is Visible    id=user-name    timeout=10s

Go To Login Page
    Go To    ${URL}
    Wait Until Element Is Visible    id=user-name    timeout=10s

*** Test Cases ***

TC01 Valid Login
    [Tags]    smoke    regression
    [Documentation]    Verify valid login works
    Go To Login Page
    Input Text      id=user-name    ${VALID_USER}
    Input Text      id=password     ${VALID_PASS}
    Click Button    id=login-button
    Wait Until Page Contains Element    css=.inventory_list    timeout=10s
    Title Should Be    Swag Labs

TC02 Invalid Login Shows Error
    [Tags]    negative    regression
    [Documentation]    Verify error on invalid password
    Go To Login Page
    Input Text      id=user-name    ${VALID_USER}
    Input Text      id=password     ${WRONG_PASS}
    Click Button    id=login-button
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s

TC03 Empty Fields Show Error
    [Tags]    negative
    [Documentation]    Verify error when fields are empty
    Go To Login Page
    Click Button    id=login-button
    Wait Until Element Is Visible    css=.error-message-container    timeout=10s
