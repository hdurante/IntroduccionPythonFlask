*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    RequestsLibrary
Library    OperatingSystem
Library    DatabaseLibrary
Library    String
Library    JSONLibrary

*** Variables ***
${token}        ${EMPTY}
${bdname}       ${EMPTY}
${bduser}       ${EMPTY}
${bdpass}       ${EMPTY}
${bdhost}       ${EMPTY}
${bdport}       ${EMPTY}


${url_ambiente_backend}    http://127.0.0.1:5000
${url_ambiente_front}    http://127.0.0.1:5001

