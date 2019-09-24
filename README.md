# Codeshift

[![Gem Version](https://badge.fury.io/rb/codeshift.svg)](https://badge.fury.io/rb/codeshift)
[![Build Status](https://travis-ci.org/rajasegar/codeshift.svg?branch=master)](https://travis-ci.org/rajasegar/codeshift) 
![](https://ruby-gem-downloads-badge.herokuapp.com/codeshift?type=total&style=plastic&color=brightgreen&total_label=)
[![Coverage Status](https://coveralls.io/repos/github/rajasegar/codeshift/badge.svg?branch=master)](https://coveralls.io/github/rajasegar/codeshift?branch=master)

A Ruby codemod CLI to transform your source code using AST(Abstract Syntax Trees) and the [parser](https://github.com/whitequark/parser) gem. 
It is typically used on ruby codebase like RAILS applications and other stuff.

## Installation

```sh
$ gem install codeshift
```


## Usage
This tool requires a `transform.rb` file which contains the transform logic to be 
applied on the source files in a folder.

```sh
$ codeshift -t [TRANSFORM FILE] [PATHS]
```

To apply the transform logic on your `app/models` files

```sh
$ codeshift -t transform.rb app/models
```

For example if you want to reverse the local variable names and method names in your code
you will be doing something like this:

Create a new ruby file with the tranformation logic to be applied on the
AST of the source code. For writing transforms you can make use of the 
[Ruby AST Explorer](https://ruby-ast-explorer.herokuapp.com/) and [cybertron](https://github.com/rajasegar/cybertron)

### transform.rb
```ruby
# Your Transform Class should always extend from 
# Parser:: TreeRewriter
class Transform < Parser::TreeRewriter
  def on_lvasgn(node)
    # Reverse the variable names
    replace(node.loc.to_hash[:name], node.children[0].to_s.reverse)
  end

  def on_def(node)
    replace(node.loc.to_hash[:name], node.children[0].to_s.reverse)
  end
end

```

If your source code looks like below in a folder called `~/Desktop/test/ruby`

### sample.rb
```ruby
tips = ["hello", "world"]
def print_tips
  tips.each { |key, value| print "Tip #{key}: #{value}" }
end
```

Then use it against your source code

```sh
$ codeshift -t transform.rb ~/Desktop/test/ruby
```

Then your source will be transformed something like:

### sample.rb
```ruby
spit = ["hello", "world"]
def spit_tnirp
  tips.each { |key, value| print "Tip #{key}: #{value}" }
end

```

## Options
Usage: codeshift -t <transform-file> [path]
* --version                    Print version number
* -t, --transform=TRANSFORM        path to the transform file. Can be either a local path or url
             (default: ./transform.rb)
* -h, --help                       Prints this help

### tranfrom-file
The transform file could be a local file or a remote url. For example you can use like

```sh
$ codeshift -t https://gist.githubusercontent.com/[user]/.../transform.rb ~/Desktop/test/ruby
```

### path
The path could be a list of directories or files separated by space.

```sh
$ codeshift -t transform.rb ~/app/legacy/ruby ~/app/old
```

```sh
$ codeshift -t transform.rb ~/code/legacy/app/models/account.rb ~/old/app/models/customer.rb
```

## Related tools
- [ruby-ast-explorer](https://github.com/rajasegar/ruby-ast-explorer]
- [cybertron](https://github.com/rajasegar/cybertron]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rajasegar/codeshift. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Codeshift project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/codeshift/blob/master/CODE_OF_CONDUCT.md).
