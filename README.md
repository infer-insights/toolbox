# Data Extraction & Analytics Engineering Toolbox

This repository is a collection of code templates and reference patterns for data extraction, transformation, and measure design — spanning DAX, M, SQL, Python, and data infrastructure examples.

Rather than solving one specific business case, it tracks training progress and documents the engineering practices behind how logic is organized across each layer of an analytics stack.

---

## Repository Components

### 📄[01-practice-queries.sql](./01-practice-queries.sql) — Relational Data Extraction
Patterns for extracting data and pre-calculating measures directly at the SQL layer, ahead of the visualization tool — keeping the reporting layer lighter and moving logic closer to the source.

### 📄[02-power-query-etl-lib.m](./02-power-query-etl-lib.pq) — Power Query / ETL
Examples of cleaning, shaping, and combining data from multiple source systems before it reaches the data model.

### 📄[03-measures-applied.dax](./03-measures-applied.dax) — Measures & Analytics
DAX patterns focused on scalable calculation design. The emphasis is on clear, self-explanatory naming so logic stays maintainable as business rules grow more complex.

### 📄[04-snowflake-memo.sql](./04-snowflake-memo.sql) — Cloud Data Warehousing
Exploring the Snowflake capabilities as corporate cloud data platform, environment structure, role-based access and data governance fundamentals.

### 📄[05-python-progress.md](./05-python-progress.md) — Data, ETL and LLM Ops basics
Building foundations while documenting baby steps and milestones as I bring the language into my technology stack.

### 📄[06-api-foundations.md](./06-api-foundations.md) — Data integration with APIs
Learning data integration through Postman and Salesforce's Trailhead, the industry-leading standards.

### 📄[07-best-practice.md](./07-best-practice.md) — Business Analysis Core Concept Model (BACCM)
Core concepts and foundational framework of Business Analysis process.  
 
---

## Engineering Principles

- **Business-driven logic** — Performance matters, but not at the expense of correctness. The design allows for added complexity where the underlying business rules genuinely require it.
- **Readability and maintainability** — Descriptive naming and inline documentation, so the logic stays easy to follow over time.
- **Logic placement** — Where practical, calculations are pushed upstream (e.g., into SQL) rather than left for the visualization layer to handle.

---

## License

MIT License — free to use, modify, or adapt.