# Product and engineering decisions

## User and scope

The primary user is an HR manager who needs to maintain employee records and compare compensation across teams and countries. The dashboard puts headcount, country pay range, country average, payroll, and a selected role average above a searchable, paginated directory. Employee CRUD is available from the same screen.

## Data and currency

Each record stores one annual salary and a currency code. Salary statistics are grouped by country, where the demo seed assigns one currency per country. No exchange-rate conversion is attempted because the assessment provides no conversion date or source. A production version should persist currency metadata and show conversion rate/source/date if cross-currency totals are requested.

## Performance

The employee list is capped at 100 rows per request and uses offset pagination for a simple HR workflow. Country and country/job-title indexes support the rollups; database aggregates compute min/max/avg/count/payroll without loading employee records. The seed creates deterministic rows and uses PostgreSQL `upsert_all` in 1,000-row batches to avoid model callback overhead and reduce SQL round trips. At larger scale, keyset pagination would avoid deep offsets.

## AI-assisted workflow

AI assistance was used to scaffold the application structure, draft initial behavior specs, and implement the data/API/UI layers. The tests were written before application code and committed first; review then focused on currency semantics, validation, SQL aggregation, bounded listing, idempotent seeding, and security headers. No external assessment URL, name-list attachments, deployment credentials, or demo destination were present in the supplied workspace.

## Trade-offs and next steps

- Authentication and authorization are not included because no identity provider or access model was specified. Add both before handling real compensation data.
- The React runtime is loaded from unpkg for this small assessment UI; a production deployment should bundle pinned assets locally.
- The assessment asks for a deployed system and a video. Those need a hosting account and a recording/publishing destination; no credentials or linked submission portal were present.
