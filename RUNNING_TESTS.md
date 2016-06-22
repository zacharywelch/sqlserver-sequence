# Running Tests

To successfully run the test suite you'll need SQL Server credentials and the ability to create tables and sequences.

When the tests are run a `suppliers` table and sequence named `number` are created for support.

## Getting Started

Copy config.yml.sample as config.yml

    $ cp spec/config.yml.sample spec/config.yml

Then update `config.yml` with the server, database and your credentials.
