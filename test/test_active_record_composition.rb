require 'minitest/autorun'
require 'active_record_composition'


class ExampleA < class MyParent; end
  include ActiveRecordComposition
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
