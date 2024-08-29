# Book Rreviews

> [!NOTE]
> This is an example project to demonstrate my coding skills. It is not actively maintained.

## Local Development Setup

### Requirements

* Ruby 3.3.4
* PostgreSQL 16+

### App setup

After installing Ruby and PostgreSQL, follow these steps:

1. Run `bundle install` to install all necessary Gems;
2. Run `bin/setup` to prepare the database;
3. Run `rake import:books` to import some books from [bigbookapi.com](https://bigbookapi.com/);
4. Run `rake fake_data:users` and `rake fake_data:reviews` if you want to create some users and reviews
5. Execute `bin/dev` to run the app locally.

### Using Big Book API

This application integrates with the [Big Book API](https://bigbookapi.com/) to import books. To enable this feature:

1. Sign up for an API key at [Big Book API](https://bigbookapi.com/);
2. Set the `BIGBOOK_API_KEY` environment variable in your shell or environment management tool.

## App features

* Provides a list of books that users can search and browse.
* Users can read reviews of books.
* Registered users can leave reviews for books.

## Testing

Test the application with RSpec by running the command `bundle exec rspec`.
