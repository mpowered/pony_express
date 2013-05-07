# PonyExpress

PonyExpress provides an HTTP based messaging bus.

## Installation

Add it to your `Gemfile`:

```ruby
gem 'pony_express', :git => 'git@github.com:mpowered/pony_express.git'
```

Then configure the mount point in your `routes.rb` file:

```ruby
mount PonyExpress::Engine, :at => "ponyexpress"
```

This will namespace all PonyExpress routes on `/ponyexpress/`


## Usage
### Configuration
You specify recipients and their login credentials in `config/pony_express.yml` as follows:

```yaml
recipients:
  toolkit:
    mount_point: 'https://toolkit1.mpowered.io/ponyexpress'
    psk: 7oPUJLN4CLF
  sms:
    mount_point: 'https://sms1.mpowered.io/ponyexpress'
    psk: 9kUFFDk7mGM

my_psk: 3pQ8qkBMDun
```

`my_psk` refers to the psk for the application being configured. It will be needed in order to receive messages.

### Sending Messages
To send a message you simply inform the Teller as follows:

```ruby
PonyExpress.to(:toolkit, :sms).send_pony(:scorecard_changed, :vat_number => 442322342)
```

or you can send the message asynchronously like this:

```ruby
PonyExpress.to(:toolkit, :sms).send_pony_async(:scorecard_changed, :vat_number => 442322342)
```

### Handling Messages
PonyExpress expects that your application has a handler named after the message you want to be able to receive.
A `scorecard_changed` message will be routed to the `ScorecardChangedHandler` that you define in `apps/handlers`.

Handlers are plain old Ruby classes that define a `handle` method. Heres an example:

``` ruby
class ScorecardChangedHandler
  def handle(params)
    # Your code here
  end
end
```
