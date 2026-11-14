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

---

## Python Fundamentals Study Log
* [2.035 — Base Subject (Placeholder)](#2035--base-subject-placeholder)
* [2.034 — Base Subject (Placeholder)](#2034--base-subject-placeholder)
* [2.033 — Basic File I/O](#2033--basic-file-io)
* [2.032 — Booleans](#2032--booleans)
* [2.031 — Sets](#2031--sets)
* [2.030 — Tuples](#2030--tuples)
* [2.028 — Dictionaries](#2028--dictionaries)
* [2.026 — Lists](#2026--lists)
* [2.024 — String Interpolation & Formatting](#2024--string-interpolation--formatting)
* [2.022 — String Properties & Methods](#2022--string-properties--methods)

---

## Stratascratch Study Log
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


---

---

## 2.034 — Progress template (placeholder)
**Core Concept:**  topic summary here.

**Notes & Gotchas:**
* Add notes or edge cases here.

````python
# Code examples
````

---

## 2.033 — File I/O
**Core Concept:** Read, write, and append text files safely in Python and Jupyter Notebooks.

**Notes & Gotchas:**
* After calling `.read()`, the file cursor sits at the end of the file; call `.seek(0)` to reset the cursor back to the beginning before reading again.
* Always close manually opened files with `.close()`, or use a `with open(...)` block to close them automatically.
* **File Modes:**
  * `'r'` — Read only.
  * `'w'` — Write only (overwrites existing file or creates a new one).
  * `'a'` — Append only (adds new content to the end of an existing file).
  * `'r+'` — Reading and writing.
  * `'w+'` — Writing and reading (overwrites existing file or creates a new one).
* **Jupyter Shortcuts:** Use `pwd` to check your current working directory, `%%writefile` to create a file from a cell, and `Shift + Tab` inside a function call to view its signature and parameters.

````python
# Jupyter magic command to write a quick text file
%%writefile myfile.txt
Hello world

# Manual open, read, reset cursor, and close
myfile = open("myfile.txt")
myfile.read()
myfile.seek(0)     # Reset cursor to start of file
myfile.close()     # Best practice when not using 'with'

# Recommended context manager approach (auto-closes file)
with open("myfile.txt", mode="r") as my_file:
    contents = my_file.read()
````

---

## 2.032 — Booleans
**Core Concept:** Represent logical truth values using Python's built-in `bool` type.

**Notes & Gotchas:**
* Boolean keywords in Python must be capitalized (`True` and `False`), unlike lowercase `true`/`false` in other languages.

````python
is_active = True
is_empty = False
type(is_active)  # bool
````

---

## 2.031 — Sets
**Core Concept:** Store unordered collections of unique elements and deduplicate lists.

**Notes & Gotchas:**
* Sets automatically discard duplicate values and do not preserve item order or support indexing.

````python
my_list = [1, 1, 2, 2, 3, 3]
unique_vals = set(my_list)  # {1, 2, 3}
````

---

## 2.030 — Tuples
**Core Concept:** Store ordered sequences of items that cannot be modified after creation.

**Notes & Gotchas:**
* Tuples use parentheses `(a, b, c)` instead of square brackets `[a, b, c]`.
* Because tuples are **immutable**, trying to reassign an element (`my_tuple[0] = "new"`) raises a `TypeError`.

````python
my_tuple = ("a", "b", "c")
type(my_tuple)         # tuple

my_tuple.count("a")    # Count occurrences of 'a'
my_tuple.index("b")    # Find first index of 'b'
````

---

## 2.028 — Dictionaries
**Core Concept:** Store data as unordered `key: value` pairs for fast lookups and nested structures.

**Notes & Gotchas:**
* Dictionary values are flexible and can store strings, numbers, lists, or even other nested dictionaries.
* Assigning to an existing key overwrites its value; assigning to a new key adds a new entry.

````python
my_dict = {"key1": "value1", "key2": "value2"}
my_dict["key1"]  # 'value1'

# Adding and updating keys
my_dict["new_key"] = "new_val"
my_dict["key1"] = "updated_val"

# Nested dictionary and list access
nested = {"key": {"nested_key": ["a", "b"]}}
nested["key"]["nested_key"][0].upper()  # 'A'

# Inspect keys, values, and pairs
my_dict.keys()
my_dict.values()
my_dict.items()
````

---

## 2.026 — Lists
**Core Concept:** Store ordered, mutable sequences that can hold mixed data types.

**Notes & Gotchas:**
* `.sort()` and `.reverse()` modify the list **in place** and return `None`. Writing `sorted_list = my_list.sort()` stores `None` instead of the sorted list.
* `.pop()` removes and returns the last element by default, or the element at a specific index `.pop(index)`.

````python
my_list = ["string", 10, 3.14]
len(my_list)
my_list[0]               # Indexing
my_list[1:]              # Slicing
my_list + ["extra"]      # Concatenation

# Mutating elements
my_list[0] = "new_first_el"
my_list.append("end_item")
my_list.pop()            # Removes last item
my_list.pop(0)           # Removes item at index 0

# Sorting in place (do not assign to a variable)
num_list = [4, 1, 3, 2]
num_list.sort()
num_list.reverse()

# Nested list indexing
nested_list = [1, 2, [3, 4]]
nested_list[2][1]        # 4
````

---

## 2.024 — String Interpolation & Formatting
**Core Concept:** Inject variables and formatted numbers into strings using `.format()` or f-strings.

**Notes & Gotchas:**
* **f-strings** (`f"..."`, introduced in Python 3.6) are the cleanest and most modern way to embed expressions directly inside strings.
* Float formatting syntax follows `{value:width.precisionf}` (for example, `{r:1.3f}` formats to 3 decimal places).
* Full reference guide: [PyFormat.info — Using % and .format()](https://pyformat.info).

````python
# 1. .format() with positional and keyword arguments
print("string {}".format("INSERTED"))                  # 'string INSERTED'
print("string {1} {a}".format("str0", "str1", a="kw")) # 'string str1 kw'

# 2. Float precision formatting: {value:width.precisionf}
result = 100 / 777
print("The result {r:1.3f}".format(r=result))          # 'The result 0.129'

# 3. f-strings (Python 3.6+)
name = "Alice"
age = 30
print(f"{name} is {age} years old.")
````

---

## 2.022 — String Properties & Methods
**Core Concept:** Manipulate strings using concatenation, repetition, and built-in string methods.

**Notes & Gotchas:**
* Be careful when numeric-looking data is stored as strings—`"5" + "5"` concatenates to `"55"` instead of adding to `10`, and `"5" * 3` repeats to `"555"`.
* In Jupyter Notebooks, type `x.` and press **`Tab`** to browse all available methods on string `x`.
* `.split()` splits on whitespace by default, or on a specific character if passed as an argument (e.g., `x.split("i")`).

````python
# Comments in Python start with #
x = "Hello world"
x = x + " it is nice"   # String concatenation (+)
"ha" * 3                # String multiplication ('hahaha')

# Splitting strings into a list
x.split()               # Splits on whitespace
x.split("i")            # Splits on every 'i'
````

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