==================================================  
"We are all connected in some way", "Integration is the ultimate competitive advantage for retail leaders."    
PROJECT: Core concepts and hands-on examples for working with APIs — authentication, requests, and data extraction.



Learning progress, best practices and code examples:
1. Training: API and Web serviced Introduction - Nate Ross [Udemy], progress: (19 of 57 completed)
  - #direct link to the training:
  - https://www.udemy.com/course/api-and-web-service-introduction
2. Training: Hands-on challenge with salesforce, Rank: HIKER, progress: (3 Badges).
  - #direct link to the training:
  - https://trailhead.salesforce.com
  - Badges/Modules completed:
  - https://www.salesforce.com/trailblazer/robert-posiadala-rp1

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