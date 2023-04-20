*** Settings ***
#El common_resource.robot ya contiene las librerias
Resource    common_resource.robot
Resource    test_resource.robot

*** Variables ***
${baseUrl}    ${url_ambiente_backend}
*** Test Cases ***
Get Status
  [Tags]    Smoke
  ${response}=    GET    ${baseUrl}${endpoint_status}
  Status Should Be    OK    ${response}  
Add Person
  [Tags]    Smoke  
  ${body}=    Create Dictionary    Id=0    Nombre=Hector    ApellidoPaterno=Durante    ApellidoMaterno=N  
  ${response}=    POST    ${baseUrl}${endpoint_addperson}    json=${body}    
  Status Should Be    OK    ${response}  
Get Person
  [Tags]    Smoke
  ${last}=    Obtener Ultimo Registro
  ${id}=    Catenate    ?id=${last}
  ${response}=    GET    ${baseUrl}${endpoint_getperson}${id}
  Should Be True    ${response.json()}[Id]==${last}
Update Person
  [Tags]    Smoke
  ${last}=    Obtener Ultimo Registro  
  ${id}=    Catenate    ?id=${last}
  ${nombre}=  Generate Random String  8  [LETTERS]
  ${body}=    Create Dictionary    Id=${last}    Nombre=${nombre}    ApellidoPaterno=Prueba    ApellidoMaterno=Update  
  ${response}=    POST    ${baseUrl}${endpoint_updateperson}    json=${body} 
  ${responseNuevo}=    GET    ${baseUrl}${endpoint_getperson}${id}  
  Status Should Be    OK    ${response} 
  Should Be Equal As Strings    ${responseNuevo.json()}[Nombre]    ${nombre}
Get People
  [Tags]    Smoke
  ${response}=    GET    ${baseUrl}${endpoint_peoplelist}  
  ${length}         Get length          ${response.json()}  
  ${resultado}=    Run Keyword If    ${length} > 0    Set Variable    True    ELSE Set Variable    False
  Should Be True    ${resultado}
Delete Person
  [Tags]    Smoke 
  ${last}=    Obtener Ultimo Registro
  ${id}=    Catenate    ?id=${last}
  ${response}=    DELETE    ${baseUrl}${endpoint_deleteperson}${id}
  Status Should Be    OK    ${response}   
*** Keywords ***
Obtener Ultimo Registro
  ${response}=    GET    ${baseUrl}${endpoint_peoplelist}  
  ${length}         Get length          ${response.json()}  
  ${last}=    Set Variable    ${response.json()}[${length-1}][Id]  
  Return From Keyword    ${last}