require 'active_record' 

module ActiveRecordComposition
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
      ActiveRecordComposite.table_name = "#{self.name}s".underscore
      @composite_record = ActiveRecordComposite.create args
    end

    def find *args
      ActiveRecordComposite.table_name = "#{self.name}s".underscore
      ActiveRecordComposite.find args
    end

    def where hash
      ActiveRecordComposite.table_name = "#{self.name}s".underscore
      ActiveRecordComposite.where hash
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  class ActiveRecordComposite < ActiveRecord::Base

  end

end
