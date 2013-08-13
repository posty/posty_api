#posty_API

The posty\_API is the core element of the posty softwarestack. It is developed to administrate a mailserver based on Postfix and Dovecot. It offers an easy REST interface which can be used in own applications or with the posty client applications, posty\_CLI and posty\_webUI.

## Requirements

You need a working ruby installation.

Tested with ruby 1.9.3.

## Installation

1.  Download the source either using git or from the GitHub page as archive.
2.  Extract the archive
3.  Change directory to the extracted folder
4.  Place a valid database.yml in the folder config
5.  Run ``bundle install``
6.  Run ``rake db:migrate``
7.  Start the application e.g. with ``rackup``

## Usage

Here is a short overview about the possible API REST calls.
Also available at [http://www.posty-soft.de/swagger/posty_api.html](http://www.posty-soft.org/swagger/posty_api.html#!/api)

**Domains:**

  * **GET** - http://API-URL/api/v1/domains - get all domains
  * **GET** - http://API-URL/api/v1/domains/{name} - get {name} domain
  * **POST** - http://API-URL/api/v1/domains - create domain (params: name)
  * **PUT** - http://API-URL/api/v1/domains/{name} - change domain {name} (params: name)
  * **DELETE** - http://API-URL/api/v1/domains/{name} - delete domain {name}

**Users:**

  * **GET** - http://API-URL/api/v1/domains/{domain}/users - get all users for {domain}
  * **GET** - http://API-URL/api/v1/domains/{domain}/users/{name} - get the user {name}@{domain}
  * **POST** - http://API-URL/api/v1/domains/{domain}/users - create user (params: name, password)
  * **PUT** - http://API-URL/api/v1/domains/{domain}/users/{name} - change user {name}@{domain} (params: name, password)
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
 * **GET** - http://API-URL/api/v1/transports/{domain} - get the transport for {domain}
 * **POST** - http://API-URL/api/v1/transports - create alias (params: name, destination)
 * **PUT** - http://API-URL/api/v1/transports/{domain} - change transport {domain} (params: name, destination)
 * **DELETE** - http://API-URL/api/v1/transports/{domain} - delete transport {domain}
 
**ApiKeys:**

 * **POST** - http://API-URL/api/v1/api_keys - create access_token
 * **PUT** - http://API-URL/api/v1/api_keys/expire/{token} - expire access_token
 * **PUT** - http://API-URL/api/v1/api_keys/disable/{token} - disable access_token
 * **DELETE** - http://API-URL/api/v1/api_keys/{token} - delete access_token

## Test

You can run the tests by going to project root and run:
``rspec``

## Information

For more informations about posty please visit our website:
[www.posty-soft.org](http://www.posty-soft.org)

### Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fixing the possible bug. We also encourage you to help even more by forking and sending us a pull request.

### License

LGPL v3 license. See LICENSE for details.

### Copyright

All rights are at (C) [http://www.posty-soft.org](http://www.posty-soft.org) 2013