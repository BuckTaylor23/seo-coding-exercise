# D26 Drivers Domain Service


__________       __________        ________
|DDDDDDDDD\     /2222222222\      /66666666|
|DDD|   \DDD\  /2222/  \2222\    /666/
|DDD|    |DDD| |2222|  |2222|   |666/
|DDD|    |DDD|       /22222/    |666|
|DDD|    |DDD|     /22222/      |66666666666\
|DDD|   /DDDD|   /22222/        |666|    |666|
|DDDDDDDDDDD/   |22222222222|   |66666666666/
|DDDDDDDDDD/    |22222222222|    \666666666/
-----------      -----------       -------


## Overview of the Exercise

In this exercise you are required to present your solution to the panel.

You will be required to deliver your findings to the panel orally and by Screen Share.

## Background Information

You are developing a prototype for a new Driver Domain service.

The new service will need to support the following:

| Endpoint | Description                                 | Required                                                                                                        | Optional                                                      |
|----------|---------------------------------------------|-----------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| Create   | Creates a Driver Record and stores it in DB | First name, Last names, Date of birth, Driving licence type, Driving licence number (generated if not provided) |                                                               |
| Retrieve | Retrieves a Driver Record from the DB       | Driving licence number                                                                                          |                                                               |
| Update   | Updates an existing Driver Record           | Driving licence number                                                                                          | At least one of; First names, Last name, Driving licence type |
| Delete   | Deletes a Driver Record from the DB         | Driving licence number, First names, Last name, Date of birth                                                   |                                                               |

Driver Record

A Driver Record consists of the following attributes:

- First names
    * Required
    * Max 32 characters
    * At least 1 alphabetic character
    * Hyphen, apostrophe and whitespace special characters are allowed

- Last name
    * Required
    * Max 32 characters
    * At least 1 alphabetic character
    * Hyphen, apostrophe and whitespace special characters are allowed

- Date of birth
    * Required
    * YYYY-MM-DD
    * Zero padded
    * Cannot be younger than 17 years old
    * Cannot be older than 100 years old

- Driving licence number
    * Required
    * Unique
    * LLLL DD DD LL LL
    * First four letters taken from last name
    * Next two digits taken from month of birth (padded)
    * Next two digits taken from day of birth (padded)
    * Next two letters taken from first names
    * Final letters are random
    * Should a name consist of less than four characters, the remainder should be made up of X’s

- Driving licence type
    * Required
    * One of
    * Full
    * Provisional

Example Driver Record

```sql
{
driving_licence_number: ‘BARX0101FOAA’,
first_names: ‘Foo’,
last_name: ‘Bar’,
date_of_birth: ‘1990-01-01’
driving_licence_type: ‘Full’
}

```

Task

You will need to author code which performs the following functions:

1. Create a driver record
2. Retrieve a driver record
3. Update a driver record
4. Delete a driver record

You may use any reasonable general-purpose programming language to implement your solution. (Your audience will be
unlikely to understand deliberately esoteric and obfuscatory toy languages, e.g., Malbolge.)

The code is expected to compile and run successfully. You may use third-party libraries to assist you, but the
implementation of task must be original.

You do not have to implement testing for this code, but you should consider how you might test it since you may be asked
about it.

You must submit your solution by the Monday 13th April 2026. Please provide a link to a public source code repository
such as GitHub to ITSRecruitment@dvla.gov.uk

Code Walk Through

During the interview you will be asked to share your screen and walk the panel through your code. During this you should
cover:

- A working demo of your code against the task
- A general overview of how your code
- Aspects of the task you enjoyed
- Aspects of the task you found difficult
- Aspects of your code you would like to improve or change

Your talk should not cover:

- A line-by-line explanation of the code
