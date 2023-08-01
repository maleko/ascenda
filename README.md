# README

Submission for the [Ascenda Coding Challenge](https://gist.github.com/melvrickgoh/e7266f09bc346e6624e3db5843f25637)

## Requirements

* Ruby version - 3.0.0
* Rails version - 7.0.6
  
> I am using RVM. The necessary `.ruby-gemset` and `.ruby-version` files are checked in

## Getting Started

Run the following commands to get started

    bundle install
    bin/setup

> Note that I have chosen to just seed the database by immediately importing from the mock apis. You can have a look at `db/seeds.rb` on how it is done. 

## How to use the API? 

We are utilising GraphQL to query the database. Navigate to:

    http://localhost:3000/graphiql

To list all accommodations with all attributes, apply the following query to the GraphQL console

    {
      accommodations {
        id
        name
        info
        address
        suburb
        state
        country
        postcode
        longitude
        latitude
        images {
          url
          imageType
          description
        }
        facilities {
          category
          name
        }
        bookingConditions {
          condition
        }
      }
    }

To list an accommodation by their hotel id, add the id to the query

    {
      accommodations(id: "f8c9") {
        id
        name
        info
        ...
      }
    }

Same goes for destination id

    {
      accommodations(destinationId: 5432) {
        id
        name
        info
        ...
      }
    }

## Caveats and Reasonings

### Pulling data

I do not really like the idea of pulling and merging the data on the fly. In reality, we would not be doing this in production anyhow.

Ideally there would be a cron job that runs to pull the data. 

### Merging

I have used a fairly simplistic way of merging the data. The app pulls the data and does not accept null values. Additionally it will remove trailing whitespace and capitalise where necessary

### Improvements
1. More tests 🤣
2. A separate Rake functionality to start the pull requests and merging
3. Probably separate the pulling and merging into two separate services but it will require persistence of the external data temporarily 

### Thought Experiment on Production

I would probably use SOA principles to build this. A schedule AWS Lambda (or GCP Functions) would be used to pull the data from external sources before adding the job request to a queue like AWS SQS to notify the downstream merging service to merge the details. 