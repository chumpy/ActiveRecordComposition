[![Build Status](https://secure.travis-ci.org/chumpy/ActiveRecordComposition.png)](http://travis-ci.org/chumpy/ActiveRecordComposition)

#ActiveRecordComposition
ActiveRecord is awesome, inheritance is not always so awesome.  This gem is for people who want to use ActiveRecord but don't want to be forced to use inheritance in their models.

##Use
In your Gemfile add:

```ruby
gem 'active_record_composition'
```

Then run:

```ruby
bundle
```

Now you take away the inheritance of ActiveRecord::Base from your models and add include ActiveRecordComposition to the first line:

```ruby
class ExampleA < class MyParent; end
  include ActiveRecordComposition
  has_many :example_bs
end

class ExampleB < class MyOtherParent; end
  include ActiveRecordComposition
  belongs_to :example_a
end
```
You can see in the example above we are inheriting from our own classes since we no longer have to manage inheritance of ActiveRecord::Base.
You can now go ahead and use your models as if they are active records like so:

```ruby
example_a = ExampleA.create(:a => 2)
ExampleB.create(:example_a => example_a, :a => 3)
example_b = ExampleB.where(:example_a_id => example_a.id).first
```
The above example does highlight one of the current limitations of ActiveRecordComposition, when matching on foreign ids, you have to specify the id attribute.  This is because we are delegating method calls to an aggregation. 

##Status
Currently supports ruby MRI 1.9.3

ActiveRecordCompostion can handle the duties of basic ActiveRecord relationships.  Coming in the next version is support for single table inheritance.

##License
(The MIT License)

Copyright (c) Kevin Beddingfield

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
