==================================================  
"Every complex architecture begins with a single line of clean code."    
PROJECT: Data Stack Integration with Python



Learning progress, best practices and code examples:
1. Syntax, data structures, resources and code best practices.  
2. Training: The Complete Python Bootcamp From Zero to Hero in Python, progress: (29 of 170 completed)
  - #official repositories provided by the course instructor
  - https://github.com/Pierian-Data/Complete-Python-3-Bootcamp.git
3. Training: Hands-on challenge with "stratascratch.com" pandas Python path, progress: (53% completed).
  - #direct link to the training:
  - https://www.stratascratch.com/learn/comprehensive-python


==================================================

1.001    
    # "code is read much more often than it is written", “readability counts”  
  - Official PEP 8 coding style guidelines and industry standards for clean Python code:  
  - https://python.org/pep-0008/  

1.002    
    # practice resources  
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
  - pwd  - shows directory of current jupyter notebook location  
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

# Stratascratch Study Log

## Index (Newest First)
* [3.016 — pd.merge() & Joins](#3016--pdmerge--joins)
* [3.015 — pd.concat() vs pd.merge()](#3015--pdconcat-vs-pdmerge)
* [3.014 — pd.concat()](#3014--pdconcat)
* [3.011 — Conditional Aggregation](#3011--conditional-aggregation)
* [3.009 — Filtering Groups](#3009--filtering-groups)
* [3.008 — Group By](#3008--group-by)
* [3.007 — Aggregation](#3007--aggregation)
* [3.006 — Sorting Values](#3006--sorting-values)
* [3.005 — Missing Data Handling](#3005--missing-data-handling)
* [3.004 — Combining Conditions](#3004--combining-conditions)
* [3.003 — Filtering](#3003--filtering)
* [3.002 — Working with Columns](#3002--working-with-columns)
* [3.001 — Summary: Python & Pandas](#3001--summary-python--pandas)

---

## 3.016 — pd.merge() & Joins
**Core Concept:** Combine two DataFrames horizontally using shared keys, or use a cross join to compare rows within the same table.

**Notes & Gotchas:**
* `indicator=True` adds a `_merge` column showing whether rows matched in `both` tables or appeared in `left_only`.
* `how="cross"` pairs every row with every other row, useful for finding pairs like workers with identical salaries.

````python
# 1. Left join with match indicator
result = pd.merge(
    customers,
    orders,
    left_on="id",
    right_on="cust_id",
    how="left",
    indicator=True
)
result["_merge"].value_counts()

# 2. Filter before merging, then aggregate
ah = airbnb_hosts
au = airbnb_units

ah_USA_u30 = ah[(ah["age"] < 30) & (ah["nationality"] == "USA")]

result = pd.merge(
    ah_USA_u30[["host_id", "age", "nationality"]],
    au,
    left_on="host_id",
    right_on="host_id",
    how="left"
)
summary = (
    result.groupby(["nationality"])["unit_type"]
    .nunique()
    .reset_index(name="type_count")
)

# 3. Inner join on multiple keys + drop duplicates
ah = airbnb_hosts
ag = airbnb_guests

matching = pd.merge(
    ah,
    ag,
    on=["nationality", "gender"],
    how="inner"
).drop_duplicates()

result = matching[["host_id", "guest_id"]]

# 4. Cross join to find workers with the same salary
w = worker
pairs = pd.merge(w, w, how="cross", suffixes=("_a", "_b"))

filter1 = pairs["worker_id_a"] != pairs["worker_id_b"]
filter2 = pairs["salary_a"] == pairs["salary_b"]

result = (
    pairs.loc[filter1 & filter2, ["worker_id_a", "first_name_a", "salary_a"]]
    .sort_values(by="salary_a", ascending=False)
    .rename(columns={
        "worker_id_a": "worker_id",
        "first_name_a": "first_name",
        "salary_a": "salary"
    })
)
````

---

## 3.015 — pd.concat() vs pd.merge()
**Core Concept:** Join DataFrames on matching key columns with `pd.merge()` and manage overlapping column names.

**Notes & Gotchas:**
* When both DataFrames share a column name (like `id`), pandas appends `_x` and `_y` by default.
* Override default suffixes using `suffixes=("_order", "_customer")`.

````python
# Basic merge syntax
result = pd.merge(left_df, right_df, left_on="fk", right_on="pk")
result = pd.merge(df_a, df_b, on="shared_column")

# Filter, merge, sort, and select specific columns
c = customers
o = orders

names = ["Jill", "Eva"]
c_filtered = c[c["first_name"].isin(names)]

c_active = pd.merge(
    o,
    c_filtered,
    left_on="cust_id",
    right_on="id"
).sort_values("cust_id", ascending=True)

columns = ["first_name", "order_date", "order_details", "total_order_cost"]
c_active[columns]
````

---

## 3.014 — pd.concat()
**Core Concept:** Stack DataFrames vertically (row-wise) when they share the same structure.

**Notes & Gotchas:**
* Use `.copy()` when adding tracking columns so you do not mutate the original source tables.
* Pass `ignore_index=True` to reset the row index across the combined DataFrame.

````python
# 1. Stack two datasets with a source label
p1 = winemag_p1.copy()
p1["source"] = "dataset_1"
p2 = winemag_p2.copy()
p2["source"] = "dataset_2"
pd.concat([p1, p2], ignore_index=True)

# 2. Create bidirectional relationships by swapping columns and concatenating
gf = google_friends_network
gf2 = gf.rename(columns={"user_id": "friend_id", "friend_id": "user_id"})

combined = pd.concat([gf, gf2], ignore_index=True).drop_duplicates()
````

---

## 3.011 — Conditional Aggregation
**Core Concept:** Calculate conditional rates or shares per group either by merging two aggregations or by converting booleans to integers first.

**Notes & Gotchas:**
* Converting a boolean column with `.astype(int)` lets you compute both the conditional count (`sum`) and total count (`size`) in a single `.groupby()` pass without filtering twice.

````python
# Approach 1: Separate groupings + inner merge
import pandas as pd

fc = facebook_complaints
proc = fc["processed"] == True
proc_df = fc[proc]

grouped = (
    proc_df.groupby("type")["complaint_id"]
    .count()
    .reset_index(name="type_count")
)
grouped_tot = (
    fc.groupby("type")["complaint_id"]
    .count()
    .reset_index(name="all_count")
)

combined = pd.merge(grouped, grouped_tot, on="type", how="inner")
combined["share"] = (1.0 * combined["type_count"] / combined["all_count"]).round(2)
combined = combined[["type", "share"]]

# Approach 2: Single-pass aggregation using .astype(int)
fc = facebook_complaints
fc["is_proc"] = (fc["processed"]).astype(int)

summary = (
    fc.groupby("type")["is_proc"]
    .agg(type_count="sum", all_count="size")
    .reset_index()
)

summary["share"] = (1.0 * summary["type_count"] / summary["all_count"]).round(2)
final_result = summary[["type", "share"]]
````

---

## 3.009 — Filtering Groups
**Core Concept:** Follow the standard aggregation pipeline: **Filter rows → Group → Aggregate → Filter groups**.

**Notes & Gotchas:**
* **Before grouping:** Filter individual rows (e.g., employees hired after 2022).
* **After grouping:** Filter groups by their aggregated values (e.g., departments with 5+ people).
* `len(df)` counts all rows including `NaN`, while `.groupby()` drops `NaN` keys by default. Use `.fillna(0)` before aggregating if missing values should be treated as zero.

````python
# Filter individual rows (equivalent syntax)
df[df["position"] == 1]
df.query("position == 1")

# Filter aggregated groups
calc_df_name[calc_df_name["calc_col_name"] >= 3]

# Combine multiple groupings
combined = pd.merge(
    first_grouping_df,
    second_grouping_df,
    on="grouping_column",
    how="inner"
)
````

---

## 3.008 — Group By
**Core Concept:** Split data into groups, apply summary calculations, and flatten the index back into a regular column.

**Notes & Gotchas:**
* Always chain `.reset_index()` (or `.reset_index(name="new_col")`) to convert the group index back into a standard DataFrame column.

````python
# Single aggregation with custom column name
(
    df.groupby("col")["calc_col"]
    .count()
    .reset_index(name="calc_col_name")
)

# Multiple aggregations at once
df.groupby("col")["calc_col"].agg(["sum", "mean"]).reset_index()

# Filter rows first with .query()
df.query("position == 1").groupby("col")["calc_col"].count().reset_index()
````

---

## 3.007 — Aggregation
**Core Concept:** Compute summary metrics across columns or entire DataFrames.

**Notes & Gotchas:**
* `len(df)` counts total rows (including `NaN`), whereas `.count()` counts only non-null values per column.
* `.sum()` and `.mean()` ignore `NaN` values automatically.
* `.T` transposes rows and columns for easier reading of wide summaries.

````python
len(df)                                      # Total rows
df["col"].count()                            # Non-null count
df["col"].nunique()                          # Count of unique values
df["col"].sum()                              # Sum (ignores NaN)
df["col"].mean()                             # Mean (ignores NaN)
df["col"].agg(["sum", "mean", "min", "max"]) # Multiple stats
df.describe().T                              # All stats transposed into rows
````

---

## 3.006 — Sorting Values
**Core Concept:** Follow the query pattern: **Filter → Sort → Limit → Select columns**.

**Notes & Gotchas:**
* Convert text dates with `pd.to_datetime(df["column"])` before sorting chronologically.
* `.sort_values()` defaults to `ascending=True`. Pass a list of booleans for multi-column sorting.

````python
# Multi-column sorting
df.sort_values(["col1", "col2"], ascending=[True, False])

# Convert to datetime before sorting
df["column"] = pd.to_datetime(df["column"])

# Filter -> Sort pattern
o = orders
above_50 = o["order_cost"] > 50
o_f = o[above_50].sort_values("order_cost", ascending=False)

# Sort by string length (via helper column or key function)
tw["name_len"] = tw["first_name"].str.len()
df.sort_values("first_name", key=lambda c: c.str.len())

# Limit results with .head(), .nlargest(), or .nsmallest()
df.sort_values("col").head(5)
top_3 = o[o["cust_id"] == 15].nlargest(3, "total_order_cost")
````

---

## 3.005 — Missing Data Handling
**Core Concept:** Identify, count, fill, or drop `NaN` values safely without breaking comparisons.

**Notes & Gotchas:**
* `0` is zero, `""` is an empty string, and `NaN` (`np.nan`) is unknown (treated as a float).
* `np.nan == np.nan` evaluates to `False`, and `np.nan != np.nan` evaluates to `True`. Always use `.isna()` or `.notna()`.
* String methods like `.str.contains()` and `.str.startswith()` exclude `NaN` automatically; use `.fillna("")` or combine with `.isna()` if you need to keep them.

````python
# Check for missing values
missing = df["col"].isna()
not_missing = df["col"].notna()

# Count and percentage of missing values
df.isna().sum()              # Missing count per column
````
---

## 3.004 — Combining Conditions
**Core Concept:** Combine multiple boolean filters safely using bitwise operators, list membership, and range helpers.

**Notes & Gotchas:**
* Use `&` (AND), `|` (OR), and `~` (NOT) for Series filtering—never Python's `and` or `or`, which only evaluate single True/False values.
* Wrap each condition in parentheses `()` when filtering inside `df[...]` because `&` is evaluated before `|`.
* `.isin()` checks membership against a list (replacing multiple `|` conditions), but it does not accept `<=` or `>=` inside the statement.
* Remember double brackets `[["col2"]]` in `.loc` when you want a DataFrame output instead of a Series.
* Wrap long conditions inside parentheses `()` across multiple indented lines (preferred over `\` line continuations) to keep code readable.

````python
# Shorten long DataFrame names for cleaner filters
df_short = data_frame_long_name

# Multiple conditions in parentheses & multi-argument .loc filtering
df[(condition1) & (condition2)]
df.loc[cond1 & cond2, ["col1", "col2"]]
df.loc[condition, ["col2"]]  # Use [] around col2 to avoid Series/index display

# Readable multi-line condition with .isin()
condition = (
    df["column_name"].isin(["object1", "object2"])
)
df[condition]

# Range filtering with .between() (inclusive: "both", "left", "right")
orders[orders["total_order_cost"].between(50, 200, inclusive="right")]
df["date_col"].between("yyyy-mm-dd", "yyyy-mm-dd")

# Negation (~ for pandas Series, != for inequality)
df[~condition]
````

---

## 3.003 — Filtering
**Core Concept:** Subset rows and columns using boolean indexing, numeric comparisons, `.loc`, and string methods.

**Notes & Gotchas:**
* In `.str.contains()`, `.` matches any character and `$` matches the end of a string by default. Pass `regex=False` to search for literal punctuation.
* Chain `.str.lower()` before `.str.startswith()` or `.str.contains()` for case-insensitive matching.

````python
# Boolean indexing (two-step vs single-line)
condition = df["col"] == "object"
df[condition]
df[df["col"] == "object"]

# Numeric comparison operators: >, <, >=, <=, !=
df[df["num_col"] >= 10]

# Filter rows and select specific columns
df.loc[condition, ["col1", "col2"]]

# String filtering
df["name"].str.startswith("object")
df["name"].str.contains("object")
df["name"].str.endswith("object")
df["name"].str.lower().str.startswith("object")  # Case-insensitive handling
df[df["text"].str.contains(".", regex=False)]    # Literal "." match

# Combining conditions: & (and), | (or), ~ (not)
df[(condition1) & (condition2)]
````

---

## 3.002 — Working with Columns
**Core Concept:** Rename columns, create calculated fields, convert data types, and inspect unique values.

**Notes & Gotchas:**
* `.rename()` does not modify the DataFrame in place unless you reassign it (`df = df.rename(...)`).
* Common pandas dtypes include `object`, `int64`, `float64`, `datetime64`, and `bool`.
* Numeric columns containing strings like `"N/A"` or `"$1,200"` stay as `object` dtype until cleaned.

````python
# Rename columns (reassign to save for later)
df = df.rename(columns={
    "first_col": "first col descr",
    "nxt_col": "nxt col descr"
})

# Arithmetic operators (+, -, *, /) and string concatenation
df["col_calc"] = df["col"] / x
df["combined_text"] = (
    df["text1"] + " " + df["text2"]
)
df["id_name"] = df["id"].astype(str) + " - " + df["name"]  # Convert numeric int to string

# Deduplication and unique values
df[["col"]].drop_duplicates()  # Checks unique combinations across specified columns
df["col"].unique()             # Returns NumPy array of unique values

# Check column data types
df.dtypes
````

---

## 3.001 — Summary: Python & Pandas
**Core Concept:** Load external data into a DataFrame and inspect its dimensions, data types, and summary statistics.

**Notes & Gotchas:**
* `df["col"]` returns a 1D **Series**, while `df[["col"]]` returns a 2D **DataFrame**.
* Text strings are stored as `object` dtype in pandas.

````python
import pandas as pd

# Load data from files or SQL
df = pd.read_csv("file.csv")      # Also: .read_excel(), .read_json()
df = pd.read_sql("SELECT * FROM table", connection)

# Select columns vs whole table
df_sub = df[["column1", "column2"]]  # Subset of columns (df = whole table)
series = df["col"]                   # Series
dataframe = df[["col"]]              # DataFrame

# Inspect structure, types, and summary stats
df.head()
df.tail()
df.shape                     # (rows, columns)
df.columns                   # Column names
df.dtypes                    # Data types
df.info()                    # Columns, types, and non-null counts
df.describe()                # Summary stats for numeric columns
df.describe(include="all")   # Summary stats for all columns
````