*** Settings ***
Library           CryptoLibrary    variable_decryption=True
Library           SeleniumLibrary
Suite Teardown    Close Browser


*** Variables ***
# The test data (i.e. the password 'secret_sauce') encrypted into a cipher.
# The CryptoLibrary will decrypt the cipher on-the-fly and assign the resulting plaintext to the variable.
# The CryptoLibrary will additionally make sure that the plaintext password will not be printed in the log.
${PWD_AS_PLAINTEXT}    crypt:+PbezkRxTK/775kjJAd0BMGCbux8LB/khVxq4DDd5QfkjvEzPnlnmnPNlmbBXfFrqbG0RyVle4peDJJz


*** Test Cases ***
First example test case
    Open Browser    https://www.saucedemo.com/    gc
    Maximize Browser Window
    Input Text    id:user-name    standard_user
    Input Password    id:password    ${PWD_AS_PLAINTEXT}
    Click Element    id:login-button
    Wait Until Page Contains   Products

   
