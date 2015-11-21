# Notebook

[![Build Status](https://travis-ci.org/moss-rb/notebook.svg?branch=master)](https://travis-ci.org/moss-rb/notebook?branch=master)

Notebook is a Ruby file attachment library, that has easy integration
with Rails and ActiveRecord.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notebook'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notebook

## Rails Quickstart

### Models

**Rails 4**

```ruby
class User < ActiveRecord::Base
  notebook_attachment :profile_picture
end
```

### Edit and New Views

```erb
<%= form_for @user, url: users_path, html: { multipart: true } do |form| %>
  <%= form.file_field :avatar %>
<% end %>
```

### Controller

**Rails 4**

```ruby
def create
  @user = User.create(user_params)
end

private
def user_params
  params.require(:user).permit(:avatar)
end
```

### Show View

```erb
<%= image_tag @user.avatar.url %>
```

### Deleting an Attachment

Set the attribute to `nil` and save.

```ruby
@user.avatar = nil
@user.save
```

### Configuration
To use a different storage location than /public, create a
`config/initializers/notebook.rb`, and then set the following:

```ruby
Notebook.public_directory = 'hi'
```

To store your upload files in a different place than the filesystem,
create a `config/initializers/notebook.rb`, then set the following:

```ruby
# these are the two out of the box storage adapters
# to use one from another source, just place the constant of a
compliant adapter here.
Notebook.adapter = Notebook::StorageAdapters::Filesystem
Notebook.adapter = Notebook::StorageAdapters::S3
```

## Plain Old Ruby

It's awesome you want to use plain Ruby without Rails with Notebook!

First off, you need to read in a file, and create a new
`Notebook::Attachment` object, like so:

```ruby
file = File.read("avatar.jpg")
attachment = Notebook::Attachment.new(file)
```

The last and final step is to just upload it!
```ruby
attachment.upload

# get the url of the newly persisted file
attachment.url
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moss-rb/notebook. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
