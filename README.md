# chimpbook
chimpbook is a Chef cookbook generator using [chef-gen-flavors](https://rubygems.org/gems/chef-gen-flavors). You can use it out of the box as an opinionated way of creating new cookbooks, or modify it to meet your organization needs.

It is heavily based on [pan](https://github.com/echohack/pan)
- license :: [Apache2](http://www.apache.org/licenses/LICENSE-2.0)
- gem version :: [![Gem Version](https://badge.fury.io/rb/chimpbook.png)](http://badge.fury.io/rb/chimpbook)
- code climate :: [![Code Climate](https://codeclimate.com/github/monkeylittleinc/chimpbook/badges/gpa.svg)](https://codeclimate.com/github/monkeylittleinc/chimpbook)

## Features
- Automatically create boilerplate files for cookbooks.
- Drive organizational policy by setting standards and good defaults for what a cookbook should look like.
- Review existing cookbooks during code reviews or during your cookbook build.
- Automatically generate examples for developers brand new to Chef.

## Install
- To get started, you'll need to install chef-gen-flavors, a gem that allows you to have multiple types of generators.

`chef gem install chef-gen-flavors`
- Then you can install the pan flavor:

`chef gem install chimpbook`
- Now add this to your knife.rb:

```
# only load ChefGen::Flavors if we're being called from the ChefDK CLI
if defined?(ChefDK::CLI)
  require 'chef_gen/flavors'
  chefdk.generator_cookbook = ChefGen::Flavors.path
end
```

- You're done! Let's get cooking.

## Usage
`chef generate cookbook my_cookbook_name`

```
[ChefGen Flavor Selector]: Flavors on the menu
1. chimp_opensource: Generate a new cookbook for opensource.
2. chimp_inhouse: Generate a new cookbook for inhouse use.
[ChefGen Flavor Selector]: Enter selection:
```

## Examples
- Create a cookbook named my_cookbook_name in the same subdirectory where pan resides.

(Mac & Windows): `chef generate cookbook my_cookbook_name`
- Create a cookbook named my_cookbook_name in the root of your primary drive with pan residing in your home directory

(Mac): `chef generate cookbook /mycookbook`

(Windows): `chef generate cookbook C:\mycookbook`

## Supported Platforms
### Tested And Validated On
- Mac OSX 10.10 with ChefDK 0.6.0
- Windows 7 with ChefDK 0.6.0

ChefDK 0.3.6 and higher all likely work, but previous versions were not tested and validated.

## Stuff This Custom Generator Does
Take a look at the flavors and generate a few cookbooks to see what they do. But I'll mention some best practices here:

### In default_attributes.rb
- default['<%= @attribute_context %>']['file_cache_path']
  - I like to do this so that I can create a "workspace" for the cookbook to drop any files in so I avoid cookbook download collisions. If your cookbook doesn't download anything, than you can trash this.
  - It also provides a good example of how to do an attribute.

### In .kitchen.yml
- chef_zero provisioner
  - It's probably stronger to provision with chef_zero than chef_solo since it behaves more like the server does. (That is to say, if you use chef server, then test with chef zero. If you're using solo, then test with solo.)

- Windows 2012 R2 with automagical WinRM transport
  - Ideally this is how you would set up the transport for WinRM with Kitchen. This is a new feature as of Test Kitchen 1.4.0 / ChefDK 0.5.0.
