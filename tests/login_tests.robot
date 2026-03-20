*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}           https://www.saucedemo.com
${VALID_USER}    standard_user
${VALID_PASS}    secret_sauce
${WRONG_PASS}    wrong_password
${OPTIONS}       add_argument("--headless=new"); add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage"); add_argument("--disable-gpu")

*** Test Cases ***

TC01 - Valid Login
    Open Browser    ${URL}    chrome    options=${OPTIONS}
    Input Text      id=user-name    ${VALID_USER}
    Input Text      id=password     ${VALID_PASS}
    Click Button    id=login-button
    Title Should Be    Swag Labs
    [Teardown]    Close All Browsers

TC02 - Invalid Login Shows Error
    Open Browser    ${URL}    chrome    options=${OPTIONS}
    Input Text      id=user-name    ${VALID_USER}
    Input Text      id=password     ${WRONG_PASS}
    Click Button    id=login-button
    Element Should Be Visible    css=.error-message-container
    [Teardown]    Close All Browsers

TC03 - Empty Fields Show Error
    Open Browser    ${URL}    chrome    options=${OPTIONS}
    Click Button    id=login-button
    Element Should Be Visible    css=.error-message-container
    [Teardown]    Close All Browsers
