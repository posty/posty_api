#posty\_API
[![Build Status](https://travis-ci.org/posty/posty_api.svg?branch=master)](https://travis-ci.org/posty/posty_api)

The posty\_API is the core element of the posty software stack. It is developed to administrate a mailserver based on Postfix and Dovecot. It offers an easy REST interface which can be used in own applications or with the posty client applications, posty\_CLI and posty\_webUI.

## Requirements

You need a working ruby installation.

Tested with ruby 2.5.1

## Installation

1.  Download the source either using git or from the GitHub page as archive.
2.  Extract the archive
3.  Change directory to the extracted folder
4.  Copy config/database.mysql2.yml or config/database.postgresql.yml to config/database.yml and change it to your needs.
5.  Run ``bundle install``
6.  Run ``rake db:migrate``
7.  Run ``rake api_key:generate``
8.  Start the application e.g. with ``rackup``

Note: Check your RACK_ENV if any problems occur.

## Usage

Following a short overview of the supported REST API calls.
To try it just use curl:

    $ curl -v -H 'AUTH_TOKEN: 709971592fb44e8d09e9d93f8xb2c956' http://localhost:9292/api/v1/domains
    $ curl -v -H 'AUTH_TOKEN: 709971592fb44e8d09e9d93f8xb2c956' http://localhost:9292/api/v1/domains/test.de
    $ curl -v -H 'AUTH_TOKEN: 709971592fb44e8d09e9d93f8xb2c956' http://localhost:9292/api/v1/domains/webflow.eu

The AUTH_TOKEN header value is the one you created with the api_key:generate task.

There is also a swagger documentation endpoint:
http://localhost:9292/api/v1/swagger_doc

Try it here: https://inspector.swagger.io/builder

**Domains:**

  * **GET** - http://API-URL/api/v1/domains - get all domains
  * **GET** - http://API-URL/api/v1/domains/{name} - get {name} domain
  * **POST** - http://API-URL/api/v1/domains - create domain (params: name)
  * **PUT** - http://API-URL/api/v1/domains/{name} - change domain {name} (params: name)
  * **DELETE** - http://API-URL/api/v1/domains/{name} - delete domain {name}

**Users:**

  * **GET** - http://API-URL/api/v1/domains/{domain}/users - get all users for {domain}
  * **GET** - http://API-URL/api/v1/domains/{domain}/users/{name} - get the user {name}@{domain}
  * **POST** - http://API-URL/api/v1/domains/{domain}/users - create user (params: name, password, quota)
  * **PUT** - http://API-URL/api/v1/domains/{domain}/users/{name} - change user {name}@{domain} (params: name, password, quota)
  * **DELETE** -  http://API-URL/api/v1/domains/{domain}/users/{name} - delete user {name}@{domain}

**UserAliases:**

  * **GET** - http://API-URL/api/v1/domains/{domain}/users/{user}/aliases - get all aliases for {user}
  * **GET** - http://API-URL/api/v1/domains/{domain}/users/{user}/aliases/{name} - get the alias {name}@{domain}
  * **POST** - http://API-URL/api/v1/domains/{domain}/users/{user}/aliases - create alias (params: name)
  * **PUT** - http://API-URL/api/v1/domains/{domain}/users/{user}/aliases/{name} - change alias {name}@{domain} (params: name)
  * **DELETE** - http://API-URL/api/v1/domains/{domain}/users/{user}/aliases/{name} - delete alias {name}@{domain}

**DomainAliases:**

  * **GET** - http://API-URL/api/v1/domains/{domain}/aliases - get all aliases for {domain}
  * **GET** - http://API-URL/api/v1/domains/{domain}/aliases/{name} - get the alias @{name}
  * **POST** - http://API-URL/api/v1/domains/{domain}/aliases - create alias (params: name)
  * **PUT** - http://API-URL/api/v1/domains/{domain}/aliases/{name} - change alias @{name} (params: name)
  * **DELETE** - http://API-URL/api/v1/domains/{domain}/aliases/{name} - delete alias @{name}

**Summary:**

  * **GET** - http://API-URL/api/v1/summary - get the number of existing domains, users, domain aliases and user aliases

**Transports:**

 * **GET** - http://API-URL/api/v1/transports - get all transports
 * **GET** - http://API-URL/api/v1/transports/{name} - get the transport for {name}
 * **POST** - http://API-URL/api/v1/transports - create alias (params: name, destination)
 * **PUT** - http://API-URL/api/v1/transports/{name} - change transport {name} (params: name, destination)
 * **DELETE** - http://API-URL/api/v1/transports/{name} - delete transport {name}

**ApiKeys:**

 * **GET** - http://API-URL/api/v1/api_keys - get all api keys
 * **GET** - http://API-URL/api/v1/api_keys/{token} - get the api_key for {token}
 * **POST** - http://API-URL/api/v1/api_keys - create access_token (params: expires_at)
 * **PUT** - http://API-URL/api/v1/api_keys/{token} - change api_key {token} (params: active, expires_at)
 * **DELETE** - http://API-URL/api/v1/api_keys/{token} - delete access_token {token}


## Test

You can run the tests by going to project root and run:
``rspec``

## Information

For more informations about posty please visit our website:
[www.posty-soft.org](http://www.posty-soft.org)

## Support


* Email:
	* support@posty-soft.org

### Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fixing the possible bug. We also encourage you to help even more by forking and sending us a pull request.

### License

LGPL v3 license. See LICENSE for details.

### Copyright

All rights are at (C) [http://www.posty-soft.org](http://www.posty-soft.org) 2014
