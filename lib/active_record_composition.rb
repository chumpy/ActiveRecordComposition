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
    def method_missing(meth, *args, &block)
      ActiveRecordComposite.table_name = "#{self.name}s".underscore
      ActiveRecordComposite.send meth, *args, &block
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  class ActiveRecordComposite < ActiveRecord::Base

  end

end
