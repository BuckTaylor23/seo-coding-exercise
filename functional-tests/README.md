# D26 Driver Domain Service Function Tests

This test pack is designed to test the 4 endpoints for the driver domain service, create, retrieve, update and delete.

To run this test pack, you will need to go through each of the following steps:

### Pre-requisites

* Bundler installed
* Ruby 4
* Bruno ***-- optional***

1. Run up the API locally

First navigate to the d26-driver-domain-service in your terminal

```bash
cd d29-driver-domain-service
```

Once there, install gems required to run the API

```bash
bundle install
```

Then to get the API, run the command

```bash
rackup
```

***optional*** -- with the API up and running, you can run the service through Bruno API client and check the unit tests
under the tests tab.
- Simply open Bruno, open a new collection at the + button, top left, navigate to and open the
d26-driver-domain-service-bruno directory, and you should have the 4 endpoints available to play with at that point.

2. Once your API is up and running in your terminal, open a fresh terminal and navigate to functional-tests directory

```bash
cd functional-tests
```
    
3. Install the gems required to run the functional tests

```bash
bundle install
```

4. Run the functional tests using Cucumber.

```bash
bundle exec cucumber
```