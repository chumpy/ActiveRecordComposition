Gem::Specification.new do |s|
  s.name        = 'active_record_composition'
  s.version     = '0.0.3'
  s.date        = '2012-02-24'
  s.summary     = "Enables ActiveRecord binding and functionality without using inheritance"
  s.description = "ActiveRecord is awesome, inheritance is not always so awesome. This gem is for people who want to use ActiveRecord but don't want to be forced to use inheritance of ActiveRecord:Base in their models.  Magic stuff happens that keeps the ActiveRecord::Base relationship away from your model object graph until runtime but you can still use all the ActiveRecord methods on your model as you're accustomed to.  Also, you now have an inheritance slot freed up - easy peasy :-)"
  s.authors     = ["Kevin Beddingfield"]
  s.email       = 'kevin.beddingfield@gmail.com'
  s.add_runtime_dependency 'activerecord', ['>= 3.2.1']
  s.files       = ["lib/active_record_composition.rb"]
  s.homepage    =
    'http://github.com/chumpy/ActiveRecordComposition'
end
