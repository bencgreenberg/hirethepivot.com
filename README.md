# Hire The Pivot

The reverse job board for second career developers.

![hirethePIVOT homepage](https://raw.githubusercontent.com/bencgreenberg/hirethepivot.com/main/screenshot_27_12_2021.png)

`hirethePIVOT` empowers second career developers to find their next work. It is built on the idea that developers from previous careers bring **pivot skills** to their work, that is experiences and proficiencies that complement their technical skills.

This initiative is built with the work of Joe Masilotti from [railsdevs.com](https://railsdevs.com). I am grateful for his work, building in open source, and his support.

---

## Getting started

### Requirements

You will need a few non-Ruby packages installed. Install these at once via:

```bash
brew bundle install --no-upgrade
```

...or manually:

* Ruby 3.1.0
* [libpq](https://www.postgresql.org/docs/9.5/libpq.html) - `brew install libpq`
    * `libpg` is needed to use the native `pg` gem without Rosetta on M1 macs
* [postgresql](https://www.postgresql.org) - `brew install postgresql`
* [node](https://nodejs.org/en/) - `brew install node`
* [Yarn](https://yarnpkg.com) - `brew install yarn`
* [Redis](https://redis.io) - `brew install redis`
* [Imagemagick](https://imagemagick.org) - `brew install imagemagick`
* [Stripe CLI](https://stripe.com/docs/stripe-cli) - `brew install stripe/stripe-cli/stripe`
* [foreman](https://github.com/ddollar/foreman) - `gem install foreman`

You will also need Google Chrome installed to run the system tests.

### Initial setup

An installation script is included with the repository that will automatically get the application setup.

```bash
bin/setup
```

## Development

Run the following to start the server and automatically build assets.

* Requires `foreman` or `overmind`
* Requires `stripe`

```bash
bin/dev
```

### Seeds

Seeding the database, either via `rails db:seed` or during `bin/setup`, creates a few accounts with developer profiles. Sign in to these with the following email addresses; all the passwords are `password`.

* `ada@example.com`
* `bjarne@example.com`
* `dennis@example.com`

There is also a single business account, `business@example.com`, that has an active subscription. Use this to test anything related to messaging.

### Stripe

You will need to configure Stripe or do a mock configuration (ie set dummy values for the last step listed below) if you are working on anything related to payments.

1. [Register for Stripe](https://dashboard.stripe.com/register) and add an account
1. Download the Stripe CLI via `brew install stripe/stripe-cli/stripe`
1. Login to the Stripe CLI via `stripe login`
1. Configure your development credentials
    1. [Create a Stripe secret key for test mode](https://dashboard.stripe.com/test/apikeys)
    1. Run `stripe listen --forward-to localhost:3000/pay/webhooks/stripe` in order to generate your webhook signing secret.
    1. [Create a product](https://dashboard.stripe.com/test/products/create) with a recurring, monthly price
    1. Generate your editable development credentials file via `EDITOR="mate --wait" bin/rails credentials:edit --environment development`. You may need to install and provide terminal access to the editor first (mate, subl, and atom should all work). If you run the code above and receive the message "New credentials encrypted and saved", without having had the opportunity to edit the file first, things have gone astray. You will need to troubleshoot this step based on your OS and desired editor, to ensure you are able to edit the development.yml file before it is encoded and saved. [See here for more details.](https://stackoverflow.com/questions/52370065/issue-to-open-credentials-file)
    1. Add the secret key, the price, and your webhook signing secret to your development credentials in the following format, and save/close the file:

```
stripe:
  private_key: sk_test_YOUR_TEST_STRIPE_KEY
  signing_secret: whsec_YOUR_SIGNING_SECRET
  price_id: price_YOUR_PRODUCT_PRICE_ID
```

## Testing

* Run `rails test` to run unit/integration tests.
* Run `rails test:system` to run system tests, using `headless_chrome`.
* Run `HEADFUL=1 rails test:system` to run system tests, using `headful_chrome`.
