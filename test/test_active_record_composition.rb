require 'minitest/autorun'
require 'active_record_composition'

class ExampleA < class MyParent; end
  include ActiveRecordComposition
  has_many :example_bs, :foreign_key => 'example_a_id'
  has_many :example_cs, :foreign_key => 'example_a_id'
  has_many :example_ds, :through => :example_cs, :foreign_key => 'example_a_id'
end

class ExampleD
  include ActiveRecordComposition
  has_many :example_cs, :foreign_key => 'example_d_id'
  has_many :example_as, :through => :example_cs, :foreign_key => 'example_d_id'
end

class ExampleC
  include ActiveRecordComposition
  belongs_to :example_d
  belongs_to :example_a
end

class ExampleB < class MyOtherParent; end
  include ActiveRecordComposition
  belongs_to :example_a
end

def before
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'test/db/test'
  )
  ActiveRecord::Base.connection.execute("create table example_as (id INTEGER PRIMARY KEY,a INTEGER,b INTEGER)")
  ActiveRecord::Base.connection.execute("create table example_ds (id INTEGER PRIMARY KEY,a INTEGER)")
  ActiveRecord::Base.connection.execute("create table example_cs (id INTEGER PRIMARY KEY,example_a_id INTEGER,example_d_id INTEGER)")
  ActiveRecord::Base.connection.execute("create table example_bs (id INTEGER PRIMARY KEY, example_a_id INTEGER, a INTEGER)")
end

def after
  ActiveRecord::Base.connection.execute("drop table example_as")
  ActiveRecord::Base.connection.execute("drop table example_bs") 
  ActiveRecord::Base.connection.execute("drop table example_cs") 
  ActiveRecord::Base.connection.execute("drop table example_ds") 
end

describe ExampleA do

  before do
    before
  end

  after do
    after
  end

  it "has a create method that creates a row in the db" do
    ExampleA.create(:a => 1)
    assert_equal(ExampleA.where(:a => 1).size,1)
  end

  it "can be created with a many-to-many relationship intact" do
    example_d = ExampleD.create :a => 2
    example_a = ExampleA.create :a => 1
    example_c = ExampleC.create :example_a => example_a, :example_d => example_d
  end
 
  it "can traverse a has-many relationship that hasn't been loaded" do
    example_a = ExampleA.create(:a => 1)
    example_b = ExampleB.create(:example_a => example_a, :a => 1)
    assert_equal example_a.example_bs[0], example_b
  end
end

describe ExampleB do
  before do
    before
  end

  after do
    after
  end

  it "can be created with an ActiveComposite owner" do
    example_a = ExampleA.create(:a => 2)
    example_b = ExampleB.create(:example_a => example_a, :a => 1)
    assert_equal(ExampleB.where(:a => 1).first.example_a.id, example_a.id) 
  end

  it "can be queried by associated ExampleA id" do
    example_a = ExampleA.create(:a => 2)
    example_b = ExampleB.create(:example_a => example_a, :a => 3)
    assert(ExampleB.where(:example_a_id => example_a).first)
  end
end
