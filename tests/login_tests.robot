*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}           https://www.saucedemo.com
${VALID_USER}    standard_user
${VALID_PASS}    secret_sauce
${WRONG_PASS}    wrong_password

*** Keywords ***
Open Test Browser
    ${chrome_options}=    Evaluate
    ...    sys.modules['selenium.webdriver'].ChromeOptions()
    ...    sys
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --window-size=1920,1080
    Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${URL}

*** Test Cases ***

TC01 - Valid Login
    Open Test Browser
    Input Text      id=user-name    ${VALID_USER}
    Input Text      id=password     ${VALID_PASS}
    Click Button    id=login-button
    Title Should Be    Swag Labs
    [Teardown]    Close All Browsers

TC02 - Invalid Login Shows Error
    Open Test Browser
    Input Text      id=user-name    ${VALID_USER}
    Input Text      id=password     ${WRONG_PASS}
    Click Button    id=login-button
    Element Should Be Visible    css=.error-message-container
    [Teardown]    Close All Browsers

TC03 - Empty Fields Show Error
    Open Test Browser
    Click Button    id=login-button
    Element Should Be Visible    css=.error-message-container
    [Teardown]    Close All Browsers
