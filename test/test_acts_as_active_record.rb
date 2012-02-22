require 'minitest/autorun'
require 'acts_as_active_record'


class ExampleA < class MyParent; end
  include ActsAsActiveRecord
end

describe ExampleA do

  before do
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'db/test'
      )
    ActiveRecord::Base.connection.execute("create table example_as (a,b)")
  end

  after do
    ActiveRecord::Base.connection.execute("drop table example_as")
  end

  it "is has a crate method that creates a row in the db" do
    ExampleA.create(:a => 1)
    assert_equal(ExampleA.where(:a => 1).size,1)
  end
end
