# AI-assisted workflow record

AI was used as an implementation assistant, with human review of product and data decisions.

## Working brief

> Build a minimal HR salary workspace with a Rails/PostgreSQL backend and a React UI. Start by defining tests for employee validation, searchable bounded pagination, CRUD, country salary min/max/average/payroll, and role average. Use SQL aggregates instead of loading records, keep salaries denominated in each employee's local currency, and seed 10,000 deterministic employees from first/last name files in efficient batches. Document trade-offs and never claim deployment or test success without evidence.

## Review checklist applied

- Confirm list endpoints cap page size and keep sorting deterministic.
- Confirm query values are parameterized and wildcard characters escaped.
- Confirm database indexes match country and country/role aggregate filters.
- Confirm `upsert_all` is deterministic and safe to rerun.
- Confirm compensation metrics do not silently combine unlike currencies.
- Confirm test status distinguishes code checks from database-backed specs.
