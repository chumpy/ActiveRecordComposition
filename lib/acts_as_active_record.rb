require 'active_record' 

module ActsAsActiveRecord
  class String
    def underscore
      self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
  end

  module ClassMethods
    def create *args
      ActiveRecordComposition.table_name = "#{self.name}s".underscore
      @composite_record = ActiveRecordComposition.create args
    end

    def find *args
      ActiveRecordComposition.table_name = "#{self.name}s".underscore
      ActiveRecordComposition.find args
    end

    def where hash
      ActiveRecordComposition.table_name = "#{self.name}s".underscore
      ActiveRecordComposition.where hash
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  class ActiveRecordComposition < ActiveRecord::Base

  end

end
