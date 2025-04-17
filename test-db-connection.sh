#!/bin/bash

echo "Testing database connection..."

# Test basic connection
if ! PGPASSWORD=$DB_POSTGRESDB_PASSWORD psql -h $DB_POSTGRESDB_HOST -U $DB_POSTGRESDB_USER -d $DB_POSTGRESDB_DATABASE -c "SELECT 1" > /dev/null 2>&1; then
  echo "❌ ERROR: Cannot connect to database"
  exit 1
fi

# Check n8n tables
TABLE_COUNT=$(PGPASSWORD=$DB_POSTGRESDB_PASSWORD psql -h $DB_POSTGRESDB_HOST -U $DB_POSTGRESDB_USER -d $DB_POSTGRESDB_DATABASE -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';" | tr -d '[:space:]')

echo "✅ Connected successfully!"
echo "📊 Found $TABLE_COUNT tables in public schema"

exit 0
