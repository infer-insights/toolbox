/*
==================================================
PROJECT: SNOWFLAKE HANDS ON PRACTISE


### Environment Practise Best Practise code examples and training progress:
1. Environment tweaks and resources
2. Training: Badge One - Data Warehousing Workshop, progress: (100% ompleted)
    - #direct link to the training:
    - https://learn.snowflake.com/en/courses/OD-ESS-DWW/ 
    - #completion certificate: 
    - https://achieve.snowflake.com/d0146fd6-5654-4a80-b788-73e5968cb30e#acc.2b4mRroM
3. Training: Badge Two: Collaboration, Marketplace & Cost Estimation, progress: (48% completed)
    - #direct link to the training:
    - https://learn.snowflake.com/en/courses/OD-ESS-CMCW/
4. 
==================================================


1.001 
    --# tweaks: costs 
    -- decrease warehouse standby acticity and auto scalling for sql code cost optimisation
    -- Step A: Time travel history limit
         ALTER ACCOUNT SET DATA_RETENTION_TIME_IN_DAYS = 1;
    -- Step B: Wh acticity limit to 60s
         ALTER WAREHOUSE COMPUTE_WH SET AUTO_SUSPEND = 60 AUTO_RESUME = TRUE;
    -- Query acceleration limit to 2
         ALTER WAREHOUSE COMPUTE_WH SET 
            ENABLE_QUERY_ACCELERATION = TRUE 
            QUERY_ACCELERATION_MAX_SCALE_FACTOR = 2;
1.002 
    --# Resources: json  
    --JSON EDITOR Online - text, tree, table structure of json file    
    https://jsoneditoronline.org/
1.003 
    --# Resources: DAMA-DMBOK reference  
    --Practical guide to Data Management summary    
    https://www.snowflake.com/en/data-governance/frameworks/dama-dmbok/

*/