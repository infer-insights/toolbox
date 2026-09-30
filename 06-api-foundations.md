==================================================  
"We are all connected in some way", "Integration is the ultimate competitive advantage for retail leaders."    
PROJECT: Core concepts and hands-on examples for working with APIs — authentication, requests, and data extraction.



Learning progress, best practices and code examples:
1. Training: API and Web serviced Introduction - Nate Ross [Udemy], progress: (29 of 57 completed)
  - #direct link to the training:
  - https://www.udemy.com/course/api-and-web-service-introduction
2. Training: Hands-on challenge with postman, progress: API Beginner (3 of 7 completed).  
  - #direct link to the training:  
  - https://academy.postman.com/  
  - Badges/Modules completed:  
  - 
3. Training: Hands-on challenge with salesforce, Rank: HIKER, progress: (4 Badges).
  - #direct link to the training:
  - https://trailhead.salesforce.com
  - Badges/Modules completed:
  - https://www.salesforce.com/trailblazer/robert-posiadala-rp1

4. Security  
  - https://api-security.owasp.org/editions/2023/en/0x11-t10/

==================================================

 1.010 -  1.019 
    # "HTTP request and response”  
  - structure: Start Line, Headers, Blank Line, Body
  - #HTTP Start Line:  

| HTTP Start Line | Request | Response |
| -------- | -------- | -------- |
| Name | Start Line, Request Line | Start Line, Response Line, Status Line |
| HTTP Version | HTTP/1.1 | HTTP/1.1 |
| Method | GET, POST, PUT, DELETE, etc. | No |
| API Program Folder <br> Location (opt) | Yes (example: /search) | No |
| Parameters (opt) | Yes (example: ?q=tuna) | No |
| Status Code | No | Yes (example: 200 OK) |
| Format | Method(space)API Program Folder <br> Location+Parameters(space)HTTP Version | HTTP Version + Status Code |
| Example | GET /search?q=tuna HTTP/1.1 | HTTP/1.1 200 OK |  

  - #idempotence - safe to repeat
  - GET, PUT, DELETE - Yes, POST - No    
    #Header Line
  - HL Req ex. Accept-Language, Authorization, Cache-Control, Content-Type, Date, Host
  - HL Resp ex. Cache-Control, Date, Expires, Set-Cookie, Server  
    #Body - Content sent to/from
  - Content-Type: Data (JSON, XML), Image, web page/HTML, audio, video, .csv (flat file), there are header lines for contents to define what to request or expect
  - State (HTTP): Web Request and Response , Less - Without, HTTP - stateless by default
  - methods: REST (Representational State Transfer) and SOAP (Simple Objest Access Protocol)
  - HTTP Security: cookies not executable, cookies dont store pass (can use tokens),  
    app stores data with session id, MFA, Changes (biometrics), Antivirus, Human error, Be proactive - report,

| Abstract overview | No HTTP (phone) | HTTP (Amazon) |
| -------- | -------- | -------- |
| Application | Bell | Amazon |
| Client (Requester) | Person callin | Browse, Programs |
| Initial Receiver | Phone | Load balancer |
| Server | Person answering | Application server |
| Client-Server Connection | cabble wires | cables or satellite |
| Memory | brain of person answering | Database |

  - Stateless infrastructure benefits: Scalability, Resilience (Crashability - backup), Less Memory Needed  

  - #XML - eXtensible Markup Language,   
  - HTTP Header Line: Content-Type: application/xml
  - HTTP Body: XML  
  - uses tags <> just like HTML (ex <button>Click ME!</button>) 
      XML W3C standard, tags describe data in it, you cen customize tags - eXtensible
  ```
    <Pizza>
      <Size>Small</Size>
      <Toppings>
        <Topping>Onions</Topping>
        <Topping>Mushrooms</Topping>
      </Toppings>
    </Pizza>
  ```

  - XSD - required schema for XML  

  - #JSON - JavaScript Object Notation,  
  - HTTP Header Line: Content-Type: application/json  
  - HTTP Body: XML
  - uses pairs "Key" : "Value" (ex. "Size" : "Small")  
  ```  
      { "Pizza" : [
          {"Size" : "Smalll",
           "Topping" : ["Onions","Mushrooms"]
            }  
            ]  
      }  
  ``` 
  - JSON Edit Chrome: web store, json extensions, add local file option, ctrl+o, www.json.org  

  - #SOAP vs REST - ways to form Requests and Reponds,  
  - #SOAP - Simple Object (way to access web service) Access Protocol (by following rules)
  - uses; WSDL (Web Services Descriptin Language)
  - Start Line: POST WSDL HTTP Version POST  
                POST - just placehold, doesnt mean it always puts information  
                WSDL - location  
  - Header Line: Content-Type: text/xml  
  - Body:        XML envelope formed using WSDL 

  - #REST - ways to form Requests and Reponds


