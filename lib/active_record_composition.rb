require 'active_record' 

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

module ActiveRecordComposition

  module ClassMethods
    def active_composite=(active_composite)
      @active_composite = active_composite
    end    

    def active_composite
      @active_composite
    end

    def method_missing(method, *args, &block)
      begin
        active_composite.send method, *args, &block
      rescue
        super.method_missing method, *args, &block
      end
    end

  end

  def self.create_class(class_name, superclass, &block)
    klass = Class.new superclass, &block
    Object.const_set class_name, klass
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.active_composite = create_class("#{base.name}", ActiveRecord::Base)
  end

end
