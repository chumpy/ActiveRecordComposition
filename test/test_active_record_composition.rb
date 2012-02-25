require 'minitest/autorun'
require 'active_record_composition'


class ExampleA < class MyParent; end
  include ActiveRecordComposition
  has_many :example_bs
end

class ExampleB < class MyOtherParent; end
  include ActiveRecordComposition
  belongs_to :example_a
end

describe ExampleA do

  before do
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'db/test'
      )
    ActiveRecord::Base.connection.execute("create table example_as (id INTEGER PRIMARY KEY,a INTEGER,b INTEGER)")
    ActiveRecord::Base.connection.execute("create table example_bs (id INTEGER PRIMARY KEY, example_a_id INTEGER, a INTEGER)")
  end

  after do
    ActiveRecord::Base.connection.execute("drop table example_as")
    ActiveRecord::Base.connection.execute("drop table example_bs")   
  end

  it "is has a crate method that creates a row in the db" do
    ExampleA.create(:a => 1)
    assert_equal(ExampleA.where(:a => 1).size,1)
  end
end

describe ExampleB do
  before do
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'db/test'
      )
    ActiveRecord::Base.connection.execute("create table example_as (id INTEGER PRIMARY KEY,a INTEGER,b INTEGER)")
    ActiveRecord::Base.connection.execute("create table example_bs (id INTEGER PRIMARY KEY,example_a_id INTEGER,a INTEGER)")
  end

  after do
    ActiveRecord::Base.connection.execute("drop table example_as")
    ActiveRecord::Base.connection.execute("drop table example_bs")
  end

  it "can be created with an ActiveComposite owner" do
    example_a = ExampleA.create(:a => 2)
    example_b = ExampleB.create(:example_a => example_a, :a => 1)
    assert_equal(ExampleB.where(:a => 1).first.example_a.id, example_a.id) 
  end

  it "can be queried by associated ExampleA id" do
    example_a = ExampleA.create(:a => 2)
    example_b = ExampleB.create(:example_a => example_a, :a => 3)
    assert(ExampleB.where(:example_a_id => example_a.id).first)
  end

end
