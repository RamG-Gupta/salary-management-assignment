# Salary workspace

A Rails 8 + PostgreSQL salary management app for an HR manager. The UI is a React dashboard backed by JSON CRUD and analytics endpoints.

## Run locally

Requirements: Ruby 4.0, PostgreSQL 15+, and Bundler. Set `PGHOST`, `PGUSER`, and `PGPASSWORD` for your local PostgreSQL instance when needed.

```sh
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

Open http://localhost:3000. The seed task idempotently upserts 10,000 generated employees in batches of 1,000. Name inputs are in `db/data/first_names.txt` and `db/data/last_names.txt`; employee IDs and emails are deterministic.

## API

- `GET /employees.json?query=&page=1&per_page=25`
- `POST /employees.json`, `GET /employees/:id.json`, `PATCH /employees/:id.json`, `DELETE /employees/:id.json`
- `GET /insights.json?country=India&job_title=Software%20Engineer`

Employee listing is paginated (maximum 100), searchable, and sorted. Salary rollups are SQL aggregates; country/role indexes support insights and country filtering. Salaries are stored in the employee's local currency and are never implicitly converted. The dashboard shows raw values in each country's currency.

## Tests

```sh
bundle exec rspec
```

Specs cover employee validation, CRUD, filtered pagination, country salary summaries, and job title averages. The GitHub Actions test job starts PostgreSQL 16 automatically.

## Product and engineering notes

See `docs/DECISIONS.md` for scope, data choices, performance notes, and AI-assisted workflow. An external deployment and demo recording require hosting credentials and a destination supplied by the assessment owner; this repository is ready for a PostgreSQL-backed Rails deployment.
