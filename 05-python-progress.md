==================================================  
"Every complex architecture begins with a single line of clean code."    
PROJECT: Data Stack Integration with Python



Learning progress, best practices and code examples:
1. Syntax, data structures, resources and code best practices.  
2. Training: The Complete Python Bootcamp From Zero to Hero in Python, progress: (29 of 170 completed)
  - #official repositories provided by the course instructor
  - https://github.com/Pierian-Data/Complete-Python-3-Bootcamp.git
3. Training: Hands-on challenge with "stratascratch.com" Python path with Pandas library, progress: (19% completed).
  - #direct link to the training:
  - https://www.stratascratch.com/learn/comprehensive-python  

==================================================

1.001    
    # "code is read much more often than it is written", “readability counts”  
  - Official PEP 8 coding style guidelines and industry standards for clean Python code:  
  - https://python.org/pep-0008/  

1.002    
    # daily practice resources  
  - http://codingbat.com/python #basic practice
  - https://projecteuler.net/archives #More Mathematical (and Harder) Practice
  - http://www.codeabbey.com/index/task_list #List of Practice Problems
  - https://www.reddit.com/r/dailyprogrammer #A SubReddit Devoted to Daily Practice Problems:
  - http://www.pythonchallenge.com/ #tricky with very few hints

2.022   
    # String properties and methods
  - concatenate strings with "+", ie. x = x + "it is nice"
  - strings can be multiplied *
  - comments in python start with #
  - carefull when string exists in int column cause it supports addition and mutiplication
  - x.+tab - when tab pressed will display methods for the string defined as x
  - x.split('i') i = list with example letter to split on, otherwise based on white space 
  
2.024   
    # string interpolation - variable into string
  - .format() print('string {}'.format('INSERTED')) = "string INSERTED"
  - .format() index positions and keywords ex. print('string {1} {a}'.format(a='str0','str1'))
  - float formatting "{value:width.precision f}"
  - ex. print("The result{r:1.3f}".format(r=result)) {r:width.precision}
  - newer method, formattet string : print(f'{name} is {age} years old.') as of python 3.6
  - https://pyformat.info/ #string formatting documentation  

2.026   
    # lists
  - separated by ',' - flexible with dtypes they can hold ['string', int, float]
  - suports len(my_list), indexing mylist[0], slicing mylist[1:],
  - support concatenation +
  - support change new_list[0] = 'new_first_el'
  - .append() - adding list element to the end
  - .pop(), .pop(index_location) - removing list element fro the end
  - .sort(), revers() sorting, reversing in place, actually sorts/reverses list
  - .sort() sorted_list = my_list.sort() - this wont work
  - nested_lis: [1,2,[3,4]]t my_list[0][1] gives [1,4]  
  
2.028   
    # dictionaries - unordered key:value pairing
  - my_dict = {'key1':'value1','key2':'value2'}
  - my_dict['key1'] will show value1
  - flexible, can hold key pairs with: 'string', list or my_dict
  - nested keys syntax: my_dict['key']['nested_key'] or ['key'][index].method()
  - adding dic_name['new_key'] = 'new_val', replacing dic_name['ex_key'] = 'new_val'
  - .keys, .values, .items    
  
2.030   
    # tuples (a,b,c) tuples, instead of [a,b,c] - list  
  - similar to lists but immutable  
  - type() object type  
  - .count(''), .index()    

2.031   
    # sets - unordered collections of unique elements  
  - set(my_list) to get unique val from my_list    

2.032  
    # Booleans bool capitalized True, False  
  - comments 

2.033   
    # I/O basic files  
  - %%writefile myfile.txt  
  - myfile = open('myfile.txt')  
  - myfile.read(), myfile.seek(0) - reset read  
  - pwd shows directory of current jupyter notebook location  
  - myfile.close() - best practice  
  - with open('myfile.txt', mode='r') as my_file:  
          contents = my_file.read()   
  - "shift + tab" opens function signature with parameters details
  -.mode='r'-read only, 'w' write only (will overwrite or create new!)
      'a'-appned only (will add on to files)
      'r+'- reading and writing
      'w+' - writing and reaidng (overwrites ex files or cr new f.)

2.034   
    # base subject  
  - comment

2.035   
    # base subject  
  - comment

3.001   
    # Python & Pandas
   - import pandas as pd
   - df = pd.read_csv("file.csv"), .read_excel, .read_json;
   - df = pd.read_sql("SELECT * FROM table", connection);
   - df = df[["column1","column2"]], df - whole table;
   - df['col'] Seriex, df[['col']] DataFrame
   - df.head(), df.tail();
   - df.shape #rows and columns, df.columns, df.dtypes, 
   - df.info() #columns, types, non-null counts
   - dtype strings (object in pandas)
   - df.describe() #numeric columns summary, df.describe(include='all')

3.002    
    # working with columns
  - df.rename(columns={  
      "first_col": "first col descr",  
      "nxt_col": "nxt col descr"  
    })
  - df = df.rename(...) #needs saving to be stored for later    
  - df["col_calc"] = df["col"] /x # arithmetic operators: + - * /
  - df["combined_text"] = (  
      df["text1"] + " " + df["text2"]  
    )
  - .astype(str): df["id"].astype(str) + " - " + df["name"] #numeric column int string
  - df[["col"]].drop_duplicates(), #multiple columns, combination checked
  - df['col'].unique() #NumPy array of unique val
  - dtypes #object, int64, float64, datetime64, bool
  --# numeric - carefull with "N/A" or "$1,200"

3.003    
    # filtering
  - condition =  df["col"] == "object", result syntax: df[condition] #boolean indexing  
  - single line syntax: df[df["col"] == "object"]
  - numeric >,<,>=,<=,!=
  - syntax df.loc[condition,["col1","col2"]] 
  - df["name"].str.startswith("object"), .contains("object"), .endswith("object")
  - df["name"].str.lower().str.startswith("object") # case sensitive handling
  - df[df['text'].str.contains(".", regex=False)] #handling: "." any character, "$" - string end
  - multi condition: df[(condition1) & (condition2)],  and: "&", or: "|", not "~"

3.004    
    # combining conditions
  - multi condition: df[(condition1) & (condition2)] #conditions in () when calc inside df
  - .loc locmulti argument filter syntax df.loc[cond1 & cond2, ["col1","col2"]]
  - df_short = data_frame_long_name
  - .isin df[df["column_name"].isin(["object1", "object2"])] #.isin multi object "|" condition
  - .isin does not accept <=, >= inside the statement
  - df.loc[condition,["col2"]] #remember about [] to avoid index display
  - .between used with inclusive="right", "left", "both"
  - .between df["col"].between(int1, int2) ex: orders[orders["total_order_cost"].between(50, 200, inclusive="right")]
  - .between with dates .between("yyyy-mm-dd", "yyyy-mm-dd")
  - negation ~ and !
  - "/" and "(" #() - better to keep the code readable and move to next row with indentation
  - condition = (
      df["col"].isin(["object1","object2"])
    )
  - "and" and "or" work on single True/False, for filtering use &/|
  - "&" is evaluated before "|"

3.005    
    # missing data handling
  - 0 - zero, "" - empty, NaN - not known
  - .isna(), .notna() - True for missing, syntax: missing = df["col"].isna()
  - np.nan -  "something" but we dont know what it is,
  - np.nan == np.nan    # False (not True!) 
  - np.nan != np.nan    # True
  - np.nan > 5          # False
  - np.nan == "text"    # False, not string, treated as float
  - string methods .str.contains(),.startswith() logic exlude NaN
  - .fillna("") or combine filter with .isna() to keep
  - df.isna().sum() - count, .mean()*100 - %, .any(axis=1).sum() - total rows
  - .fillna({"column1":"string1", "column2":"string2"})
  - .dropna(subset=["column"])  

3.006    
    # sorting values, pattern: Filter → Sort → Limit → Select columns
  - .sort_values(["col1","col2"] ascending=[True, False]), defult asc
  - pd.to_datetime(df["column"]), convert first
  - .sort_values with condition df[df["col"] > condition].sort_values("col")
  - o_f = o[o["total_order_cost"] > 50].sort_values("total_order_cost", ascending=False)
    o=orders
    above_50 = o["order_cost"] > 50
    o_f = o[above_50]
    o_f.sort_values("order_cost", ascending = False)
  - tw["name_len"] = tw["first_name"].str.len() #will add column if not in dataframe
  - df.sort_values("first_name", key=lambda c: c.str.len())
  - .head(), .tail(), .sort_values("").head(int)
  - .nlargest, .nsmallest(int,"col")
  - top_3 = o[o["cust_id"] == 15].nlargest(3, "total_order_cost")
    o=orders
    cust = o["cust_id"] == 15 #filter 
    o_cust = o[cust]          #filter
    top_3 = o_cust.nlargest(3, "total_order_cost") #limit
  - Filter → Sort → Limit → Select columns  

3.007    
    # aggregation 
  - len() #total rows
  - .count() #not null per column, syntax: df["col"].count()
  - .nunique(), df["col"].nunique() #unique in col
  - .sum(), ignores NaN
  - .mean(), ignores NaN,
  - .agg(["sum", "mean", "min", "max"]) - multiple aggr
  - .describe() = .agg() with all stat
  - .T transpose into rows

3.008    
    # group by
  - .groupby("col")["calc_col"]
                      .count()
                      .reset_index(name="calc_col_name") # index change into col
  - #counted "calc_col" and grouped by "col" adding new "calc_col_name"
  - multiple(["sum", "mean"]).reset_index()

